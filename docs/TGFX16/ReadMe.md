# [TurboGrafx 16 / PC Engine](https://en.wikipedia.org/wiki/TurboGrafx-16) for [MiSTer Platform](https://github.com/MiSTer-devel/Main_MiSTer/wiki) 

### This is the port of Gregory Estrade's [FPGAPCE](https://github.com/Torlus/FPGAPCE)

Port to MiSTer, Arcade card, DDR3, mappers and other tweaks [Sorgelig](https://github.com/sorgelig)

Tweaks and CD Support added by [srg320](https://github.com/srg320)

Additional bug fixes by [greyrogue](https://github.com/greyrogue)

Palettes & audio filters by [Kitrinx](https://github.com/Kitrinx)

Further refinements and maintanance by [dshadoff](https://github.com/dshadoff)

## Features
 * Completely rewritten CPU and VDC for cycle accuracy
 * Uses DDR3 and SDRAM for cartridge's ROM (SDRAM is recommended for accuracy)
 * Overall Machine Support:
   - CD-ROM / Super CD-ROM
   - CD+G support
   - Arcade Card
   - SuperGrafx mode
   - Backup Memory Saves
 * Controllers:
   - Turbotap(multiple joysticks)
   - 2-button, 2-button 'turbo', and 6-button joystick support
   - Mouse
   - Pachinko controller
   - XE-1AP analog controller
 * Additional functionality:
   - Street Fighter II and Populous mappers
   - Memory Base 128 storage unit
   - Cheat engine
   - CHD Support

## Installation:
Copy the *.rbf file at the root of the SD card. Copy roms (*PCE,*BIN) to **TGFX16** folder. You may rename ROM of your favorite game to **boot.rom** - it will be automatically loaded upon core loading.
Use SGX file extension for SuperGrafx games.

## SDRAM
This core may work without SDRAM (using on-board DDR3), but it may have different kinds of issues/glitches due to high latency of DDR3 memory. Thus SDRAM module is highly recommended for maximum accuracy.

### Notes:
* Both headerless ROMs and ROMs with header (512b) are supported and automatically distinguished by file size.

## Cheat engine
Standard cheats location is supported for HuCard games. For CD-ROM game all cheats must be zipped into a single zip file and placed inside game's CD-ROM folder.

## Reset
Hold down Run button then press Select. Some games require to keep both buttons pressed longer to reset. The PC Engine/Turbografx-16 did not have a hardware reset button, and instead relies on this button combination. With this method, in-game options will remain if you have changed them, whereas the MiSTer OSD reset will revert them.
(Note: This is a soft-reset method, and is suppressed in a small number of games)

## CD-ROM games
CD-ROM images must be in BIN/CUE or CHD format, and must be located in the **TGFX16-CD** folder. Each CD-ROM image must have its own folder.
**cd_bios.rom** must be placed in the same TGFX16-CD folder as the images mentioned above. **Japanese Super CD-ROM v3.00 is recomended for maximum compatibility**. 
Additionally you can use a different bios for specific games (for example from Games Express) by placing cd_bios.rom inside the game image's folder.

**Do not zip CD-ROM images! It won't work correctly.**

**Attention about US BIOS:** MiSTer requires original dump of US BIOS to work properly. It needs to be of 262144 bytes.
If you can read copyright string at the end of US BIOS file, then it's not correct dump! It's already pre-swapped for emulators.
While it will work on MiSTer, some CD games will refuse to start. **Correct US BIOS file is when copyright string is not readable.**

## CD+G (CD Graphic) Support
CD+G support works only for games in CloneCD format (which can also be ripped by freeware "CD Manipulator"). This format creates cue, img, and sub files - the subcode "sub" file contains
the CD+G subcode information. This must exist with the same name as the "img" (audio portion) of the file, together in the same folder. The CD+G player is available as the "GRAPHICS"
button in the CD player on the system card (versions 2.0, 2.1, or 3.0).  CHD is not supported for CD+G.

## Joystick
Both Turbotap and 6-button joysticks are supported.
For 2-button 'turbo' joypad (sync'd as in original system), turbo fire is provided by alternate buttons : A, B (normal), X, Y (turbo 1 level), and L, R (turbo 2 level)
 * Games Supporting 6-button:
   - Street Fighter II
   - Advanced Variable Geo
   - Battlefield '94 in Tokyo Dome
   - Emerald Dragon
   - Fire Pro Jyoshi - Dome Choujyo Taisen
   - Flash Hiders
   - Garou Densetsu II - Aratanaru Tatakai
   - Garou Densetsu Special
   - Kakutou Haou Densetsu Algunos
   - Linda Cube
   - Mahjong Sword Princess Quest Gaiden
   - Martial Champions
   - Princess Maker 2
   - Ryuuko no Ken
   - Sotsugyou II - Neo Generation
   - Super Real Mahjong P II - P III Custom
   - Super Real Mahjong P V Custom
   - Tengai Makyo - Kabuki Itouryodan
   - World Heroes 2
   - Ys IV
 * XE-1AP analog joystick is supported for the 4 games which are supported:
   - After Burner II
   - Forgotten Worlds
   - Operation Wolf
   - Outrun

Do not enable the above features for games not supporting it, otherwise game will work incorrectly (for example, 6-button is only supported on a very small list of games).

## Mouse
Mouse is supported.  Supported games:
 * 1552 Tenka Tairan
 * A. III - Takin' the A Train
 * Atlas Renaissance Voyage
 * Brandish
 * Dennou Tenshi Digital Angel
 * Doukyuusei
 * Eikan ha Kimini - Koukou Yakyuu Zenkoku Taikai
 * Hatsukoi Monogatari
 * Jantei Monogatari III - Saver Angels
 * Lemmings
 * Metal Angel
 * Nemurenumori no Chiisana Ohanashi
 * Power Golf 2 Golfer
 * Princess Maker 2
 * Tokimeki Memorial
 * Vasteel 2

Do not enable this feature for games not supporting it, otherwise game will work incorrectly.

## Pachinko
Pachinko controller is supported through either paddle or analog joystick Y axis.

## Palettes
The 'Original' palette is based on reverse engineering work of the VDP by [furrtek](https://github.com/furrtek). An RGB to YUV lookup table was discovered that translates the colors to their intended values with the composite output of the console. Further work was done by [ArtemioUrbina](https://github.com/ArtemioUrbina) to verify the color output. [Kitrinx](https://github.com/Kitrinx) created a tool to generate the resulting [palette](https://github.com/Kitrinx/TG16_Palette).

## Memory Base 128 / Save-kun
This was an external save-game mechanism used by a small number of games, late in the PC Engine's life, particularly for complex simulations like the KOEI games.
Enabling this should not interfere with normal operation of games, but will only provide additional storage on a small number of games:
 * A. III - Takin' the A Train
 * Atlas Renaissance Voyage
 * Bishoujo Senshi Sailor Moon Collection
 * Brandish
 * Eikan ha Kimini - Koukou Yakyuu Zenkoku Taikai
 * Emerald Dragon
 * Fire Pro Jyoshi - Dome Choujyo Taisen
 * Ganchouhishi - Aoki Ookami to Shiroki Mejika
 * Linda Cube
 * Magicoal
 * Mahjong Sword Princess Quest Gaiden
 * Nobunaga no Yabou - Bushou Fuuunroku
 * Nobunaga no Yabou Zenkokuban
 * Popful Mail
 * Princess Maker 2
 * Private Eye Dol
 * Sankokushi III
 * Shin Megami Tensei
 * Super Mahjong Taikai
 * Super Real Mahjong P II - P III Custom
 * Super Real Mahjong P V Custom
 * Tadaima Yuusha Boshuuchuu
 * Vasteel 2

## Download precompiled binaries
Go to [releases](https://github.com/MiSTer-devel/TurboGrafx16_MiSTer/tree/master/releases) folder. 
