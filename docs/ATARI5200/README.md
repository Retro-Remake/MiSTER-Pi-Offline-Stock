# Atari [5200](https://en.wikipedia.org/wiki/Atari_5200) and [Atari 800/800XL/65XE/130XE](https://en.wikipedia.org/wiki/Atari_8-bit_family) for [MiSTer Platform](https://github.com/MiSTer-devel/Main_MiSTer/wiki)

### This is the port of [Atari 800XL core by Mark Watson](http://www.64kib.com/redmine/projects/eclairexl)

### Installation
* Copy the *.rbf file to the root of the system SD card.
* Copy the files to Atari800/Atari5200 folder

## Usage notes

### System ROM
You can supply other A800 XL OS ROM as games/ATARI800/boot.rom. 
Alternative Basic ROM can be placed to games/ATARI800/boot1.rom. 
Alternative A800 OS-A ROM as games/ATARI800/boot2.rom.
Alternative A800 OS-B ROM as games/ATARI800/boot3.rom.

Integrated OS ROMs include SIO turbo patch (fast disk loading). Note that the single fact that this patch is present can break some titles, especially the timing sensitive ATX disk based ones.

Turbo ROM has hot keys to control the turbo mode:
* SHIFT+CONTROL+N    Disable highspeed SIO (normal speed)
* SHIFT+CONTROL+H    Enable highspeed SIO 

Another alternative is to load and set the ROM files from the OSD menu, they will become permanent (use Backspace when loading to clear them), but only if there are no alternative boot.rom files, otherwise those will take precedence. Yet, there is an option to change that behaviour too (that is, keep the boot.rom files on the SD card, but have the ROM data loaded from the OSD selected files on core initialisation).

Additionally, you can control the speed of turbo loading in OSD menu.

### Disks
A800: After mounting the disk, press F10 to boot.
Some games don't like the Basic ROM. Keep F8(Option) pressed while pressing F10 to skip the Basic.
You can also boot a disk directly from the D1: drive using the first menu entry, the F10 Reset and F8 Option keys are applied automatically, any mounted carts are unmounted.
For ATX disk titles that are timing sensitive, you may also want to try to change the emulated drive timing between the older 810 disk drive, and the XL line 1050 one (this does not apply at all to non-ATX titles, the option has no effect). Moreover, some ATX titles will only load on the PAL or NTSC machine only, depending on which system they were designed for.
**Note:** ATR images inside ZIP containers are not writable, software that relies on being able to write to the disk might fail (sometimes ungracefully). Writing to disks is supported for ATR images outside containers, yet this can also be forced to be read-only with a menu option that makes all mounts write-protected. Finally, all ATX images are mounted read-only, ATX writing is not supported.

### Executable files
A800: There is an entry to directly load the Atari OS executable files (the so called XEX files) using a high-speed direct memory access loader.
If a title does not load, you may want to try to switch the loader location in Atari memory (Standard - it sits at 0x700, Stack - it is located at the bottom of the stack area at 0x100).

### Classic Atari 800 mode
When selecting OS-B in the Machine/BIOS menu option, the core works in the classic Atari 800 mode (reset required to take effect), and different memory layouts are available / activated. Note that the 52KB memory layout is not compatible with the core built-in 800 OS-A/B system, it freezes the boot process. This is not a core bug, but an Atari 800 legacy. To remedy this you have to use / load the genuine OS-A/B rom file.
Additionally, in the classic 800 mode there are 4 controllers available to the Atari (as the original hardware had it), 4 controllers are also available in the 5200 core.
Note also, that at least in this mode, the XEX loader is not really bulletproof when loading subsequent XEX files (due to the nature of OS-A/B and the construction of the XEX loader), a manual cold reset (F10) might be sometimes required in-between loading of two (different) XEX files in the 800/OS-A/B mode.

### Cartridges
With the newer version of the core the database of supported cartridge types have been extended and the ability to "stack" cartridges have been added. The stacking is only working or is useful when the first cartridge is a pass-thru type, these are the different kinds of Sparta DOS X cartridges. Moreover, now the selected distributions of SDX provided by the Sparta DOS X project are supported, you can use the rom files for Ultimate 1MB or Super Cart directly with the core. When stacking the size of both cartridges is limited to 1MB (this is only partly checked) when normally cartridges up to 2MB in size are supported. This, however, is not an actual limitation as all SDX releases are under 1MB and so are any useful to stack programming language cartridges, like MAC/65 or Action!. In the classic 800 mode, see above, the stacked cartridge slot doubles as the right cartridge slot of Atari 800 and the actual stacking for SDX is not supported.

### Special ROMs
When loading a raw cartridge image, some files are treated specifically to their purpose. Particularly, SpartaDOSX images for Ultimate 1MB and pass-thru SIDE2 are treated as described below, and then also the Turbo Freezer ROM images (recognized by Hias' signature in them) are not regular cartridge images. Instead, they are loaded into the Turbo Freezer ROM area and the freezer functionality is enabled, and stays so until the next core reboot or reload (that is, it survives regular Atari reboots). Turbo Freezer menu is activated by pressing Del or Scroll-Lock.

### PBI BIOS

The PBI BIOS enables accessing ATR images in a fast DMA-based fashion (works only with "friendly" images), provides an OS independent HSIO implementation, and provides basic support for HDD image emulation for SpartaDOSX. No in-depth explanations of how SDX deals with hard drives or the general mechanics of PBI are given here, plenty of resources for this out there, but just some details particular to this PBI implementation. The splash options will make the Atari OS flash the PBI information during system boot, this is a non-interactive, information only screen (good as a reminder that PBI is turned on). The boot drive option essentially tells SDX where to end up after boot (currently selected drive) and where to search for the CONFIG.SYS and AUTOEXEC.BAT files. In the drives menu you can select how each particular emulated drive should behave against PBI probing, but there are internal overriding exceptions to this, for example, PBI mode is always on for XEX files mounted as disk drives, or ATX files are always handled as Stock/OS. Moreover, regardless of the drive settings, if an HDD partition is mounted at a particular drive it is always handled with PBI/DMA (obviously). For HDD images, only raw IMG files are supported (so no VHD, fixed size or otherwise) and there can be be only one image mounted (so only one HDD device is emulated), regardless of whether the image is mounted through D3: or D4:. Effectively, these two slots have a double function (this is due to the core already using the maximum allowed number of MiSTer mount slots), and once you use either of the slots to mount the image, you cannot mount a regular disk image (well, you can, but the HDD as a whole will disappear) on that slot (but you can still do it on the other slot). This should not be a problem in most cases, as the D3: alt. D4: drives are usually taken up by an HDD partition nevertheless to serve the SDX C: drive. Finally, the PBI driver does not support dynamic partition or FAT hosted ATR files mounting, the PBI BIOS ID is fixed to 0, and the implementation also assumes there would be no other PBI devices in the system (rather impossible on a MiSTer), this allows to speed up some "PBI decisions" as well. Really final note - some Atari titles may not like this PBI BIOS implementation, so far the Rewind 2 demo is known to crash mid way when the PBI BIOS is activated.

Practically, to use an HDD image with SDX you would first turn on the PBI, set the PBI boot drive to APT, then mount the HDD image file on D3:, and then load the SDX Ultimate 1MB ROM image as a cart, this should boot the Atari into SDX with the HDD. To create an empty HDD image you can get into the Linux console, find the games/ATARI800 folder, and run `dd if=/dev/zero of=sdx_hdd.img bs=1M count=X` where X is your desired image size in MB. Finally, note that if you want to use an image created earlier on a PC and mounted in Altirra and formatted with an SDX running there you may get skewed up partition geometry (due to a bug / feature in Altirra, it would be already skewed there, problem reported to the author and fixed in the recent test versions of Altirra).

### Differences from original version
* Joystick/Paddle mode switched by joystick. Press **Paddle1/2** to switch to paddle mode (analog X/Y). Press **Fire** to switch to joystick mode (digital X/Y).
* Use ` key as a **Break** on reduced keyboards.
* The original core used the Win key for pausing, right Alt(Gr) does this instead.
* Cursor keys are mapped to Atari cursor keys.
* PAL/NTSC mode switch in settings menu (A800)
* Video aspect ratio switch in settings menu
* Switchable side clipping of the video output to hide the GTIA "garbage". 
* An option to turn off the hi-res Antic extension from the original core, which brakes some titles.
* Some optimizations and tweaks in file selector and settings menu navigation.
* Standard OSD menu for cartridge/disk selection.
* Mouse emulates analog joystick(Atari 5200) and paddles(Atari 800).
* Fire 2 and Fire 3 on joystick.

### Disable Basic ROM by Joystick.
Fire 2 on joystick acts as an OPTION key while reboot. It's valid only 2 seconds after reboot. After that Fire 2 doesn't affect the OPTION key.

### More info
See more info in original [instructions](https://github.com/MiSTer-devel/Atari800_MiSTer/tree/master/instructions.txt)
and original [manual](https://github.com/MiSTer-devel/Atari800_MiSTer/tree/master/manual.pdf).

## Download precompiled binaries
Go to [releases](https://github.com/MiSTer-devel/Atari800_MiSTer/tree/master/releases) folder.
