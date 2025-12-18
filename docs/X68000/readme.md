# [Sharp X68000](https://en.wikipedia.org/wiki/X68000) for [MiSTer Platform](https://github.com/MiSTer-devel/Main_MiSTer/wiki)

This is the port of the [Sharp X68000](http://fpga8801.seesaa.net/category/24786679-1.html) core by Puu-san.

## Work in progress...

### Supported storage
* FDD *.d88 images
* SASI HDD *.hdf images

### Supported Controller Types - [Check here for a game compatibility list](controllers.md)
* 2-button controller (Standard)
* 2-button controller with turbo (SNES buttons B-Y-L and A-X-R for faster repeats)
* 3-button Megadrive
* 6-button Magical (included with Garou Densetsu 2)
* 6-button Capcom (adapter included with some Street Fighter 2 games)
* Double D-pad (Libble Rabble/Crazy Clinber)
* CyberStick/XE-1AP

### Additional info
- Supported MT32-pi over USER I/O port.

### Installation
Copy *.rbf to SD card. Copy boot.rom and boot3.vhd to Games/X68000 folder.
You can use BLANK_disk_X68000.D88 if you need to make a new FDD image (or for saves).

### Keyboard Layouts
There is an OSD option to choose different keyboard layouts.
Each layout are described on this excel sheet [Keyboard Layouts Excel Sheet](Doc/keymap.xlsx) from Puu-San, there is also this PDF file [Keyboard Layouts PDF](Doc/keymap.pdf) from Tonton that you can deployed on your MiSTer at this directory /media/fat/docs/X68000. You could opened this PDF on the core by selecting System -> Help on the OSD.
