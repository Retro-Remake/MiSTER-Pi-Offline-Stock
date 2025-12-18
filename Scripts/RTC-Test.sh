#!/bin/bash

# Set the hardware clock to July 15th, 2025, at 09:00:00
# The format is YYYY-MM-DD HH:MM:SS
sudo hwclock --set --date="2025-07-15 09:00:00"

# Verify the new time
echo "Verifying hardware clock setting..."
sudo hwclock --show

# Reboot the MiSTer
echo "Reboot"
