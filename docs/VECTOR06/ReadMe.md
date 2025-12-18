# [Vector 06C](https://en.wikipedia.org/wiki/Vector-06C) for MiSTer Platform

Precise K580VM80A (i8080) Verilog model by Vslav is used in this project. Some modules from [Vector06cc](https://github.com/svofski/vector06cc) and [Bashkiria 2M](http://bashkiria-2m.narod.ru/index/fpga/0-12) were used.

### Features:
- Fully functional Vector 06C with precise timings
- 3MHz(original) and 6MHz(turbo) speeds for CPU.
- 320KB RAM (including 256KB of Quasi-disk)
- Following file formats are supported: 
    - ROM: simple tape backup (loading from 0x100 address)
    - FDD: floppy dump (read/write)
    - EDD: Quasi-disk dump
- All known joystick connections: 2xP, 1xPU(USPID), 2xS
- Specially developed i8253 module for better compatibility.
- AY8910/YM2149 sound
- Optional loadable BOOT ROM (up to 32KB)
- Z80 CPU (experimental)

Keep in mind Z80 CPU is not original CPU for Vector 06C, so not all applications can work correctly with this CPU. No additional hardware for ZX emulator supported. Use ZX Spectrum core if you want Spectrum.

### Installation:
Copy the *.rbf file at the root of the SD card. You can rename the file to core.rbf if you want the MiST to load it automatically at startup.

Copy **vector06.rom** to the root of SD card if you wish to use another BOOT ROM (up to 32KB).

##### Keyboard map:

- F12 - OSD menu.
- CTRL-F11 - Reset to Boot ROM (don't clean the memory).
- SHIFT-F11 - Reset to Boot ROM (various additional keys are supported (F1-F5) depending on BOOT ROM functions).
- ALT-F11 - Enter to application.
- ALT - Rus/Lat
- ESC - AP2
- CRTL - US
- SHIFT - SS

### Additional usage notes
- ROM files are started automatically after loading.
- After loading FDD or EDD files, BOOT ROM will be activated. You need to press **ALT-F11** to start the disk if it's bootable. If disk is not bootable then you need to load additionally EDD or ROM file with MicroDOS and then follow the MicroDOS guide.
- Some applications on disks require Quasi-disk to be formatted (and refuse to work if not). In this case, you need to hold **CTRL** and shortly press **ALT+F11** key combination to automatically format Quasi-disk at MiscroDOS startup.
- If both EDD and FDD are loaded then EDD has priority by default. To switch to FDD you need to hold down **SHIFT+F1+F2** and quickly press **F11**

### Download precompiled binaries:
Go to [releases](https://github.com/MiSTer-devel/Vector-06C_MiSTer/tree/master/releases) folder.
