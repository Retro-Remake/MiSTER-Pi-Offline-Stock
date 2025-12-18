# [Acorn Archimedes](https://en.wikipedia.org/wiki/Acorn_Archimedes) for [MiSTer Board](https://github.com/MiSTer-devel/Main_MiSTer/wiki)

### This is the port of [Archie](https://github.com/mist-devel/mist-board/tree/master/cores/archie) core from MiST by Stephen Leary

## Installation

Copy the [*.rbf](https://github.com/MiSTer-devel/Archie_MiSTer/tree/master/releases) into a root folder of the SD card.
Copy a version of a RiscOS ROM into the "Archie" folder, renaming it to `riscos.rom`.

### Reset
* **warm reset:** short press ctrl-alt-alt or USER button.
* **cold reset:** long press of above. RISCOS ROM will be reloaded and memory will be cleared.

### CMOS
CMOS is automatically saved to cmos.dat if any modification (configure utility or others) is detected. To revert settings to default remove cmos.dat and **reload the core**.

### RTC
Core gets current clock setting from Linux subsystem.

### Floppy disk images
The current version supports two floppy drives. Floppy disk images ADF format and of exactly 819200 bytes in size are currently required. This is the most common format for the Acorn Archimedes.

### Hard disk images
Up to 2 hard disks images with extension HDF can be mounted. System has to be additionnaly configured.
1) delete any existing cmos.dat file from Archie folder.
2) Reload the core.
3) Open command line (F12 or ctrl+F12) and type: configure idefsdiscs 1 (or 2 if you use two hard disks)
4) Mount required image(s)
5) Make a cold reset.

To save currently selected images, use OSD option "Save Settings"

## OSD Menu
If the ROM is recognized the core should boot into Risc OS.
Press **Win+F12** to open the OSD menu.
You can move to other pages of settings by pressing the right arrow key.

# License
This core uses the Amber CPU core from OpenCores which is LGPL.
The core itself is dual licensed LGPL/BSD.
