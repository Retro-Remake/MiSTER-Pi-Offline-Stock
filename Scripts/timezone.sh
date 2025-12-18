#!/bin/bash

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# Copyright 2019 Alessandro "Locutus73" Miele

# You can download the latest version of this script from:
# https://github.com/MiSTer-devel/Scripts_MiSTer

# Version 1.3 - 2025-01-02 - Manual selection with country and city, added automatic/manual option.
# Version 1.2 - 2019-03-02 - Changed "/media/fat/timezone" to "/media/fat/linux/timezone", removed -k option from curl.
# Version 1.1 - 2019-01-08 - Changed "http://ip-api.com/json/" to "http://www.ip-api.com/json/".
# Version 1.0 - 2019-01-08 - First commit.

echo "Choose timezone setting method:"
echo "a) Automatic"
echo "m) Manual"
read -r mode

if [ "$mode" == "a" ]; then
    TIMEZONE="$(curl -sLf "http://www.ip-api.com/json/" | grep -o "\"timezone\" *: *\"[^\"]*" | grep -o "[^\"]*$")"
elif [ "$mode" == "m" ]; then
    echo "Available continents or regions:"
    COUNTRY_LIST=($(find /usr/share/zoneinfo/posix -mindepth 1 -maxdepth 1 -type d | sed 's|/usr/share/zoneinfo/posix/||'))
    for i in "${!COUNTRY_LIST[@]}"; do
        echo "$i) ${COUNTRY_LIST[$i]}"
    done | more

    echo "Enter the number corresponding to your continent/region:"
    read -r country_choice
    if [[ "$country_choice" =~ ^[0-9]+$ ]] && [ "$country_choice" -ge 0 ] && [ "$country_choice" -lt "${#COUNTRY_LIST[@]}" ]; then
        SELECTED_COUNTRY="${COUNTRY_LIST[$country_choice]}"
        echo "Available cities in $SELECTED_COUNTRY:"
        CITY_LIST=($(find "/usr/share/zoneinfo/posix/$SELECTED_COUNTRY" -type f | sed "s|/usr/share/zoneinfo/posix/$SELECTED_COUNTRY/||"))
        for i in "${!CITY_LIST[@]}"; do
            echo "$i) ${CITY_LIST[$i]}"
        done | more

        echo "Enter the number corresponding to your city:"
        read -r city_choice
        if [[ "$city_choice" =~ ^[0-9]+$ ]] && [ "$city_choice" -ge 0 ] && [ "$city_choice" -lt "${#CITY_LIST[@]}" ]; then
            TIMEZONE="$SELECTED_COUNTRY/${CITY_LIST[$city_choice]}"
        else
            echo "Invalid city choice. Exiting."
            exit 1
        fi
    else
        echo "Invalid continent/region choice. Exiting."
        exit 1
    fi
else
    echo "Invalid option. Exiting."
    exit 1
fi

if echo "$TIMEZONE" | grep -q "/"; then
    cp "/usr/share/zoneinfo/posix/$TIMEZONE" "/media/fat/linux/timezone"
    echo "Timezone set to $TIMEZONE."
else
    echo "Unable to set timezone. Please check your input or try again."
fi

exit 0
