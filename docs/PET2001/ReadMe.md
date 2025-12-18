# PET2001 for [MiSTer Board](https://github.com/MiSTer-devel/Main_MiSTer/wiki)

### This is the port of [pet2001fpga](https://github.com/skibo/Pet2001_Nexys3).

## Installation:
Copy the *.rbf file at the root of the SD card. Copy roms (*.prg,*.tap) to **PET2001** folder.

### Notes:
* PRG apps are directly injected into RAM. Load command is not required.
* TAP files are loaded through virtual tape input. press **F1** to issue LOAD command, and then choose TAP file in OSD.
* **F12** opens OSD.

### System ROM structure
* 0000-0FFF - unused, all zeros
* 1000-7FFF - mapped to 9000-FFFF

### Disk support

Core supports D64, D80 and D82 disk images through two 4040 and 8250 IEEE dual-disk drives. 
When using a D80 disk image, the first disk access will result in an error.
This is normal behaviour of the 8250 drive.

## Download precompiled binaries
Go to [releases](https://github.com/MiSTer-devel/PET2001_MiSTer/tree/master/releases) folder.
