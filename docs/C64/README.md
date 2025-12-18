# C64 for [MiSTer](https://github.com/MiSTer-devel/Main_MiSTer/wiki)

Based on FPGA64 by Peter Wendrich with heavy later modifications by different people.

## Features
- C64 and C64GS modes
- C1541 read/write/format support in raw GCR mode (*.D64, *.G64)
- C1581 read/write support (*.D81)
- Parallel C1541 port for faster (~20x) loading time using DolphinDOS
- External IEC through USER_IO port
- Almost all cartridge formats (*.CRT)
- Direct file injection (*.PRG)
- Dual SID with several degrees of mixing 6581/8580 from stereo to mono
- Similar to 6581 and 8580 SID filters
- REU 16MB and GeoRAM 4MB memory expanders
- OPL2 sound expander
- Pause option when OSD is opened
- 4 joysticks mode
- RS232 with VIC-1011 and UP9600 modes either internal or through USER_IO
- Loadable Kernal/C1541 ROMs
- Special reduced border mode for 16:9 display
- C128/Smart Turbo mode up to 4x
- Real-time clock

## Installation
Copy the *.rbf to the root of the SD card. Copy disks/carts to C64 folder.

## Usage

### Keyboard
Note: F2, F4, F6, F8, Left/Up keys automatically activate Shift key.

| Key       | Function                                     |
|:---------:|----------------------------------------------|
| F9        | Arrow-up key                                 |
| F10       | = key                                        |
| F11       | Restore key. Also special key in AR/FC carts |
| Alt, Tab  | C= key                                       |
| PgUp      | Tape play/pause                              |
<br>

![keyboard-mapping](https://github.com/mister-devel/C64_MiSTer/blob/master/keymap.gif)

### Using without keyboard
If your controller has more than four buttons then you can map a couple of buttons to **Mod1** and **Mod2** to add twelve frequently used keys; for example, to skip the intros and start the game.

|                       | →           | ↓           | ←           | ↑           | Fire1    | Fire2   | Fire3   | Paddle                      |
|:---------------------:|:-----------:|:-----------:|:-----------:|:-----------:|:--------:|:-------:|:-------:|:---------------------------:|
| **Mod1**              | Cursor<br>→ | Cursor<br>↓ | Cursor<br>← | Cursor<br>↑ | Enter    | Space   | Esc     | Alt+ESC (LOAD"*" then RUN)  |
| **Mod2**              | 1           | 2           | 3           | 4           | 5        | 0       | Y       | N                           |
| **Mod1 + Mod2**       | F1          | F2          | F3          | F4          | F5       | F6      | F7      | F8                          |

With maps above and using Dolphin DOS you can issue **F7** to list the files on disk, then move cursor to required file, then issue **Alt+ESC** to load it and run.

### Loadable ROM
Alternative ROM can be loaded from OSD: Hardware->Load System ROM.
Format is simple concatenation of BASIC + Kernal.rom + C1541.rom

To create the ROM in DOS or Windows, gather your files in one place and use the following command from the DOS prompt. 
The easiest place to acquire the ROM files is from the VICE distribution. BASIC and KERNAL are in the C64 directory,
and dos1541 is in the Drives directory.

`COPY BASIC + KERNAL + dos1541 MYOWN.ROM /B`

To use JiffyDOS or another alternative kernel, replace the filenames with the name of your ROM or BIN file. (Note, you must use the 1541-II ROM. The ROM for the original 1541 only covers half the drive ROM and does not work with emulators.)

`COPY /B BASIC.bin +JiffyDOS_C64.bin +JiffyDOS_1541-II.bin MYOWN.ROM`

To confirm you have the correct image, the BOOT.ROM created must be exactly 32768 or 49152 (in case of 32KB C1541 ROM) bytes long. 

Two loadable ROM sets are provided: **DolphinDOS v2.0** and **SpeedDOS v2.7**. Both ROMs support parallel Disk Port. DolphinDOS is the faster of the two.

For **C1581** you can use separate ROM with size up to 32768 bytes.

### Autoload the cartridge
In OSD->Hardware page you can choose Boot Cartridge, so every time a core is loaded, this cartridge will be loaded too.

### Parallel port for disks.
Are you tired of long loading times and fast loaders aren't really fast when comparing to other systems? 
In OSD->System choose **Expansion: Fast Disks**. Then load [DolphinDOS_2.0.rom](releases/DolphinDOS_2.0.rom). You will get about **20x times faster** loading from disks!

### Turbo modes

**C128 mode:** this is C128 compatible turbo mode available in C64 mode on Commodore 128 and can be controlled from software, so games written with this turbo mode support will take advantage of this.

**Smart mode:** In this mode any access to disk will disable turbo mode for short time enough to finish disk operations, thus you will have turbo mode without losing disk operations.

### RS232

Primary function of RS232 is emulated dial-up connection to old-fashioned BBS. **CCGMS Ultimate** is recommended (Don't use CCGMS 2021 - it's buggy version). It supports both standard 2400 VIC-1011 and more advanced UP9600 modes.

**Note:** DolphinDOS and SpeedDOS kernals have no RS232 routines so most RS232 software doesn't work with these kernals!

### GeoRAM
Supported up to 4MB of memory. GeoRAM is connected if no other cart is loaded. It's automatically disabled when cart is loaded, then enabled when cart unloaded.

### REU
Supported standard 512KB, expanded 2MB with wrapping inside 512KB blocks (for compatibility) and linear 16MB size with full 16MB counter wrap.
Support for REU files.

GeoRAM and REU don't conflict each other and can be both enabled.

### USER_IO pins

| USER_IO | USB 3.0 name | Signal name |
|:-------:|:-------------|:------------|
|   0     |    D+        | RS232 RX    |
|   1     |    D-        | RS232 TX    |
|   2     |    TX-       | IEC /CLK    |
|   3     |    GND_d     | IEC /RESET  |
|   4     |    RX+       | IEC /DATA   |
|   5     |    RX-       | IEC /ATN    |

All signals are 3.3V LVTTL and must be properly converted to required levels!
With a level converter this allows connecting the MisterFPGA for example to a real 1541 or printer!

### Real-time clock

RTC is PCF8583 connected to tape port.
To get real time in GEOS, copy CP-CLOCK64-1.3 from supplied [disk](https://github.com/mister-devel/C64_MiSTer/blob/master/releases/CP-ClockF83_1.3.D64) to GEOS system disk.

### 1541 Drive

C1541 implementation supports D64, T64, G64 and G81 images. Use supplied empty disks for saving or copying to. Images mounted from inside zip files are read only. You can force mounting an image (outside of zip) write protected through the menu or by changing the file attribute. The 1541 simulation for G64 images has (limited) support for protected disks. For best results try on original kernal, try PAL and NTSC (reset after changing!), try alternate images (alts), try multiple times (some protections are unreliable even on original hardware), be patient (some titles take very long to load), try with write protect on and off. If all else fails you can try the drive speed and drive wobble settings. Protected disk in some cases won't work yet and still require further tuning of access times.
