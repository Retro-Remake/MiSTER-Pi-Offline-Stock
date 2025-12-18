# MSX for [MiSTer Board](https://github.com/MiSTer-devel/Main_MiSTer/wiki)

Port of [MSX core version by Kdl](http://gnogni.altervista.org/)

## Features:
- MSX2/Plus/3.
- Sound YM2149(PSG), YM2419(OPLL), SCC.
- Various sound and memory expansions through virtual cartridges.
- Turbo modes for CPU.
- Mouse.
- Joystick.
- Real time clock.
- VHD images HDD.
- SD card support <4GB (SDSC) and >4GB (SDHC/SDXC).
- No longer requires secondary SD card on I/O board v5.x. Supports both SDSC and SDHC cards.

### Installation:
* Copy the [*.rbf](https://github.com/MiSTer-devel/MSX_MISTer/tree/master/releases) file at the root of the SD card.
* Use sdcreate util (you need to start it with Administrator rights) from [Utils](https://github.com/MiSTer-devel/MSX_MiSTer/tree/master/Utils) folder to format and create a basic SD card for MSX core. If you want to make it manually, then make sure OCM-BIOS.DAT is the first file copied to SD card after format! Only FAT16 is supported.

### Notes about SD card:
* Core does not require a secondary SD card located on I/O Board v5.x. You can use VHD images on the main SD card.
* You can use SD cards of any size, but only partitions less than 4GB are supported. It's advised to use sdcreate utility. It will create a 4GB partition if the SD card is bigger than 4GB. 
* The core is kind of picky about the SD card, so it's possible some cards won't work.

### Usage notes:
* In turbo mode, use **F11** to change the speed.
* Core recognizes short reset (warm reset) and long reset (cold reset). Long reset is reset held for more than 2 seconds.
* use supplied (in sdcreate package) file manager **mm** to load various kinds of apps, like ROM and DSK files.
* More advanced BIOSes can be downloaded from [KdL site](http://gnogni.altervista.org/) by sending a request as per instruction on that site.
