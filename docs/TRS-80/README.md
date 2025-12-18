# [TRS-80](https://en.wikipedia.org/wiki/TRS-80) for MiSTer Platform
## Model I Support ##
This is a port of [HT1080Z MiST core](https://github.com/mist-devel/ht1080z) by Jozsef Laszlo to the MiSTer

To learn how to use the TRS-80, this is a quick tutorial:
https://www.classic-computers.org.nz/system-80/driving_instructions.htm

The TRS-80 with boot to a "Ready?" screen, loading Basic with no drive support to let you load a cassette game. Once you place a disk in the drive 0 using the OSD menu and reset, it will boot on the drive.

## Boot Rom
You must provide a file named "BOOT.ROM" that contains a TRS-80 Model I ROM image. The file must be placed in /media/fat/games/TRS-80 or another location permitted by MiSTer. Any original should work, or a System80 one, and you may look at www.classic-computers.org.nz/system-80/software_archive.htm to find one. Usual size for this file is 12 kib or 14 kib.
The modified ROM that permits fast cassette accesses may be built from the file "system_80_bluelabel_rom" by applying the following patch :
```
  at location 0x236
  is        : e5 06 08 cd 41 02 10 fb e1 c1 c9 c5 f5 db ff 17
  should/be : e5 db 04 00 00 00 00 00 e1 c1 c9 db 04 c9 ff 17 
```
### To load a cassette game:
```
  return
  system
  <Then go to the OSD and load a cassette>
  [type the first letter of the file you want to load (e or g for the disk images provided)]
  / (to start once loaded)
```
Note: The cassette loader has a special feature allowing you to load a ZIP file (renamed as a fake .CAS file) and unzip it directly in any DOS with the "MrUnzip/cmd" application you'll find in the support files. The ROM patch is not needed for this to run full speed.

### To load a CMD file:
Just select it in the OSD. Some CMD files won't work if they access disk rom routines and there is no disk in the drive. Sometimes a clean reboot is necessary before loading a CMD.
3 options for the final transfer to the program are proposed by an OSD choice :
 * CAS : This is the default, for CMD files coming from cassette dumps. It sets up the stack to 0x4200 before jumping to the program entry
 * JMP : just JMP to the program entry and let the stack alone
 * NONE: Only loads the program in memory. It's up to the user to JMP to the program entry by another mean. It's the safest way to load and run a CMD file under DOS !

The Debug Message (you need to enable it to be able to see it, as explained below) will show the area where the program has been loaded and its entry point.
Under DOS, an easy way to JMP to the entry point is to create a simple Loader like so :
 * DUMP RUN7000/CMD (TRA=X'7000')
 * at the DOS prompt, typing "RUN7000<enter>" will then jump to hex addr 0x7000.

### To load a BAS file:
You can load Level I or II programs, but only in binary format. Text files must be loaded via the "MERGE" command only. Basic Level II (Disk version or not) should be in memory so the loader knows where to put things.
Load Basic (with or without a DOS) and once at the prompt ">" select a \*.bas file from the OSD. Use "LIST" or "RUN" to see and start the program as usual. 

### To load files from DSK images:
There are three main TRS-80 image formats, which are JV1, JV3 and DMK and they all usually share the same DSK extension.  This MiSTer Core only supports the JV1 image format with upto 240 tracks, all tracks must currently hold 10 x 256 byte sectors.  To check what format a disk is in, and if it is compatible with the core, use the TRSTOOLS utility from Matthew Reed, available from: http://www.trs-80emulators.com/trstools/

The Disk emulation supports reading and writing to JV1 formatted disks, but disks cannot be formatted in the core because there is no Write Track support for JV1 images.  There are many different DOS versions for the TRS-80 with popular ones including TRSDOS, NEWDOS/80, LDOS and MULTIDOS.  For beginners it is recommended you use TRSDOS which is the original DOS produced by Radio Shack.  Instructions for using TRSDOS can be found in the following Wikipedia article: https://en.wikipedia.org/wiki/TRSDOS


## Features:
 * TRS-80 Model I with 48KB installed
 * Expansion interface with quad disk drives
 * Real Time Clock (RTC)
 * RS232-C Interface (IO ports $E8 to $EA)
 * MIDI/80 compatible, with optional MT32-Pi
 * SavedStates
 * White, Green and Amber Phosphor screen emulation
 * Sound output is supported (however cassette saving sound is suppressed)
 * Cassette loading is many times faster than the original 500 bauds (if the ROM patch is present)
 * direct ZIP/UNZIP download feature (look in the support files for MrUnzip)
 * Ctrl Key simulates shift-DownArrow
 * TRS-80 Skin (only visible if an overscan is selected)

## How to use the Saved States
 * You must first create "rom_names" each virtually containing 4 saved states numbered from 1 to 4 and selected in the OSD
 * To create these "rom_names" just put a non-empty file with a .SAV extension anywhere, but preferably in games/TRS-80. The OSD options will be disabled until you select a "rom_name" file.
 * An easy linux/MiSTer command to do this is : echo "A">/media/fat/games/TRS-80/MySave001.SAV
 * You can create as many save "rom_names" as you want, they are just needed to define the "rom_name" under which the savestates are saved, and they are not used.
 * Use the OSD to select a slot with the "Snapshot "\*.SAV" OSD entry, and a state number from the "Savestate slot" OSD entry 
 * the physical saves are stored in /media/fat/savestates/TRS-80/
 * The SaveStates mecanism saves the video memory, the main memory and the processor's internal registers and states. It doesn't save any other peripheral, notably not the disk controller. That should be ok though, but don't do bizarre things like making a snapshot right in the middle of a writing sectors sequence, it's not gonna end well.
 * The details of the format of the savestate file are as follow :
   - 0000-000f : Mister header, serial number of the save and file size in 32bits words
   - 0010-002f : Z80 registers (A,F,A',F',I,R,SP,PC,BC,DE,HL,IX,BC',DE',HL',IY,IM,IFF1,IFF2)
   - 0030-042F : Video Screen 
   - 0430-c42f : Main Memory (4000-ffff) 

## MIDI/80
 * Open project by Michael Wessel and George Phillips, details at https://github.com/lambdamikel/MIDI-80
 * Defines I/O ports 8 and 9 as an alternative entry for the RS232 circuit, hooked to the MIDI outputs
 * Output to Mister's internal Synth, or MT-32 (if the option is checked)
 * Software lies there : https://github.com/lambdamikel/MIDI-80/tree/main/trs-80/model-1/dsk (all JV1 compatibles disks)
 * MIDORG works great ! But the midi files are not very suited instrument-wise, that would need some adaptation midi-wise.
 * Note : there is no Midi-inputs (no recorder) 
 * Note : if MT32-Pi is used, the RS232 circuit cannot be used for anything else. 

## Notes:
 * Even though sector write operations are supported, formatting of disks is not.
 * Prefer keyboard "TRS80" mapping for games, and reserve "PC" mapping for desktop apps. The latter may misbehave when several keys are pushed at the same time.

## System80 
If you use a System80 ROM 
 * Dick Smith System80 improved keyin routine at /12288 misbehave at higher clock speeds)
 * The System80 debugger can be loaded with "SYSTEM" then "/12710" at the prompt;
 * Refer to the System80 manual for details about this. 

## Omikron CP/M Mapper
If you provide an Omikron Mapper ROM as boot1.rom placed in games/TRS-80/, setting this option will run the Omikron Mapper and hopefully load CP/M from the Omikron disk.
You will probably need to do a "Erase memory and Reset" after enabling the Omikron mapper to get the menu ("Reset" won't work at this point, because it's routed to reset the CPM machine only when Omikron is active).
See the discussion at https://github.com/MiSTer-devel/TRS-80_MiSTer/issues/43 for more details and possible ressources.
 * disk images must be RAW (.DSK, .JV1) 128 bytes/sector, 18 sectors/track, Single-sided, 35 to 80 tracks.
 * disk images must have a size being an exact multiple of 512 (the MiSTer SD sector size), so every 35 track disk must be padded with 256 bytes to comply. The odd 71-tracks disks too, but I never saw one. With linux or MiSTer, this can be achieved with this command :
   ```dd if=/dev/zero bs=256 count=1 >> MYDISK.DSK```
 * 80-tracks disks have been tested successfully, you'll find one in the "support" directory.
 * MrUnzip has been ported to CP/M to ease file migration (see "support/CPM")

## Technical:
Debug status line
 * The Debug Status line will only be visible in Partial or Full overscan modes
   * For monitoring Floppy Disk Controller (FDC)
   * Uses the following format: Ddddd,Ccc,Ttt,Sss,dnn,sSS,Xxxxx \* where:
     * dddd - Drive select latch (1-4).  Only 2 drives are currently supported
     * cc   - FDC Command Register
     * tt   - FDC Track Register
     * ss   - FDC Sector Register
     * nn   - FDC Data Register
     * SS   - FDC Status Register
     * xxxx - Spare debug flags, depends upon the release. 
     * \*   - RTC Second Timer


Special ports (i.e. Z-80 "OUT"/"IN" commands) have been added as follows:
 * VIDEO:
   * OUT 1, n (where n=(0-7)) -> change background color
   * OUT 2, n (where n=(0-7)) -> change overscan color
   * OUT 3, n (where n=(0-7)) -> change foreground color

 * Memory-mapped cassette:
   * OUT 6, n (where n=(0-255)) -> set address bits 23-16 of virtual memory pointer
   * OUT 5, n (where n=(0-255)) -> set address bits 15- 8 of virtual memory pointer
   * OUT 4, n (where n=(0-255)) -> set address bits  7- 0 of virtual memory pointer
   * A = INP(4)  -> read virtual memory at current virtual memory pointer and increment pointer
   * Note that cassette image is loaded at 0x010000, and no memory exists beyond 0x01ffff

 * Holmes Sprinter Interface
   * OUT 254, n - Even number = Override Turbo.  Odd number = Enable Turbo

Special memory mapped ports have been added as follows:

* TRS-80 DD Interface - Memory mapped interface
    * 0x37ec = 0x80 - Enable Double Density Mode  (disabled for now)
    * 0x37ec = 0xa0 - Disable Double Density Mode
