#!/bin/bash
# Copyright (c) 2021-2025 José Manuel Barroso Galindo <theypsilon@gmail.com>

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

# You can download the latest version of this tool from:
# https://github.com/MiSTer-devel/Downloader_MiSTer

set -euo pipefail

RUN_PATH="/tmp/downloader.sh"
LATEST_BUILD_PATH="/media/fat/Scripts/.config/downloader/downloader_latest.zip"
LATEST_BIN_PATH="/media/fat/Scripts/.config/downloader/downloader_bin"
CACERT_PEM_0="/etc/ssl/certs/cacert.pem"
CACERT_PEM_1="/media/fat/Scripts/.config/downloader/cacert.pem"

if (( $(date +%Y) < 2000 )) ; then
    NTP_SERVER="0.pool.ntp.org"
    echo "Syncing date and time with $NTP_SERVER"
    echo
    if ntpdate -s -b -u $NTP_SERVER ; then
        echo "Date and time is:"
        echo "$(date)"
        echo
    elif [[ "${CURL_SSL:-}" != "--insecure" ]] ; then
        echo "Unable to sync."
        echo "Please, try again later."
        exit 1
    fi
fi

if [ -s "${CACERT_PEM_1}" ] ; then
    export SSL_CERT_FILE="${CACERT_PEM_1}"
elif [ -s "${CACERT_PEM_0}" ] ; then
    export SSL_CERT_FILE="${CACERT_PEM_0}"
elif [[ "${CURL_SSL:-}" != "--insecure" ]] ; then
    set +e
    curl "https://github.com" > /dev/null 2>&1
    CURL_RET=$?
    set -e

    case $CURL_RET in
      0)
        ;;
      *)
        if ! which dialog > /dev/null 2>&1 ; then
            echo "ERROR: CURL returned error code ${CURL_RET}."
            exit $CURL_RET
        fi

        set +e
        dialog --keep-window --title "Bad Certificates" --defaultno \
            --yesno "CA certificates need to be fixed, do you want me to fix them?\n\nNOTE: This operation will delete files at /etc/ssl/certs" \
            7 65
        DIALOG_RET=$?
        set -e

        if [[ "${DIALOG_RET}" != "0" ]] ; then
            echo "No secure connection is possible without fixing the certificates."
            exit 1
        fi

        RO_ROOT="false"
        if mount | grep "on / .*[(,]ro[,$]" -q ; then
            RO_ROOT="true"
        fi
        [ "${RO_ROOT}" == "true" ] && mount / -o remount,rw
        rm /etc/ssl/certs/* 2> /dev/null || true
        echo
        echo "Installing cacert.pem from https://curl.se"
        curl --insecure --location -o /tmp/cacert.pem "https://curl.se/ca/cacert.pem"
        curl --insecure --location -o /tmp/cacert.pem.sha256 "https://curl.se/ca/cacert.pem.sha256"

        DOWNLOAD_SHA256=$(cat /tmp/cacert.pem.sha256 | awk '{print $1}')
        CALCULATED_SHA256=$(sha256sum /tmp/cacert.pem | awk '{print $1}')

        if [[ "${DOWNLOAD_SHA256}" == "${CALCULATED_SHA256}" ]]; then
            mv /tmp/cacert.pem "${CACERT_PEM_0}"
            sync
        else
            echo "Checksum validation for downloaded CA certificate failed."
            echo "Please try again later."
            exit 0
        fi

        [ "${RO_ROOT}" == "true" ] && mount / -o remount,ro

        export SSL_CERT_FILE="${CACERT_PEM_0}"
        ;;
    esac
fi

download_file() {
    local DOWNLOAD_PATH="${1}"
    local DOWNLOAD_URL="${2}"
    set +e
    curl ${CURL_SSL:-} --silent --fail --location -o "${DOWNLOAD_PATH}" "${DOWNLOAD_URL}"
    local CMD_RET=$?
    set -e

    case ${CMD_RET} in
        0)
            return
            ;;
        60|77|35|51|58|59|82|83)
            echo ; echo "No secure connection is possible without fixing the certificates."
            exit 1
            ;;
        *)
            echo ; echo "No internet connection, please try again later."
            exit 1
            ;;
    esac
}

rm ${RUN_PATH} 2> /dev/null || true

export DOWNLOADER_LAUNCHER_PATH="${BASH_SOURCE[0]}"

if [[ -s "${LATEST_BIN_PATH}" && -x /usr/bin/python3.9 ]] ; then
    echo "Running MiSTer Downloader" ; echo
    touch /tmp/downloader_run_signal
    cp "${LATEST_BIN_PATH}" "${RUN_PATH}"
    chmod +x "${RUN_PATH}"
    set +e
    "${RUN_PATH}" ; ERROR_CODE=$?
    set -e

    if [[ -f /tmp/downloader_run_signal ]] ; then
        echo -e "WARNING! downloader_bin didn't work as expected with error code ${ERROR_CODE}!\n"
        BIN_ERROR_LOG="/media/fat/Scripts/.config/downloader/downloader_bin_error.log"
        echo "WARNING! downloader_bin didn't work as expected with error code ${ERROR_CODE}!" > "${BIN_ERROR_LOG}" || true
        date >> "${BIN_ERROR_LOG}" || true

    elif [[ ${ERROR_CODE} -ne 0 ]] ; then
        echo -e "Downloader failed!\n"
        exit 1
    else
        exit 0
    fi
else
    echo "Running MiSTer Downloader!" ; echo
fi

if [ -s "${LATEST_BUILD_PATH}" ] ; then
    cp "${LATEST_BUILD_PATH}" "${RUN_PATH}"
else
    echo "Fetching latest Downloader build..."
    download_file "${RUN_PATH}" "https://raw.githubusercontent.com/MiSTer-devel/Downloader_MiSTer/main/dont_download.sh"
    echo
fi

chmod +x "${RUN_PATH}"
if ! "${RUN_PATH}" ; then
    echo -e "Downloader failed!\n"
    exit 1
fi

exit 0
