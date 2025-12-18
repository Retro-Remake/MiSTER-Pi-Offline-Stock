# [ZX Spectrum Next](https://www.specnext.com/) for [MiSTer Platform](https://github.com/MiSTer-devel/Main_MiSTer/wiki)

Port of original [ZX Spectrum Next core](https://gitlab.com/SpectrumNext/ZX_Spectrum_Next_FPGA) developed by Alvin Albrecht, Victor Trucco and Fabio Belavenuto.

## MiSTer specifics
- Uses SDRAM instead of SRAM. Some wait states are added in 14MHz and 28MHz modes.
- Bootstrap option to load other cores is not supported (obviously).
- Uses MiSTer's HDMI settings.
- Added standard wide screen video crop and HV-Integer scaling for HDMI.
- Re-added hard reset (unofficial).
- Support TZX and CSW(non-compressed) tape formats.


## Installation
- Place rbf into root of SD card.
- Unpack and place boot.vhd (from releases folder) into `/Games/ZXNext` folder. Alternatively you can rename it to ZXNext.vhd and place into root of SD card.


## SD card
Original core is written with direct access to SD card. MiSTer(Linux) doesn't allow to access main SD card directly as it will be corrupted.
You may use secondary SD card (on I/O board) directly in this core. Make sure you've deleted/renamed ZXNext.vhd in the root and Games/ZXNext/boot.vhd.
If core cannot find these files, then secondary SD card will be used instead.
On some IO boards ,the secondary SD is not detected because they do not have SD card detect pin , in this cases you need to flip switch in the position SW2  to on , in your DE10-Nano to force detect SD. 


## Hotkeys
* F1 - hard reset
* F3 - toggle 50Hz/60Hz modes
* F4 - soft reset
* F5 - tape play/pause
* F6 - tape restart
* F7 - tape finish
* F8 - change CPU clock: 3.5MHz, 7MHz, 14MHz, 28MHz
* F9 - NMI/Multiface
* F10 - DivMMC NMI


## Original specs:

A brief summary of the current machine specifications:

* **CPU** : Z80N (z80 compatible with some additional instructions) operable at software selectable speeds of 3.5 MHz, 7 MHz, 14 MHz or 28 MHz with wait states.
* **COPPER** : A co-processor running independently of the cpu executes simple instructions that can modify the nextreg state.  For example, it can change palettes, alter the display mode or play stereo music.  The copper is synchronized with the display generation so it is able to make these changes at precise locations in the display.
* **DMA** : The ZXN DMA, compatible with a subset of the Z80 DMA chip, is able to perform transfers between memory and/or io using short two cycle reads and writes.  In burst mode, the zxn dma can send bytes at programmable rates allowing it to play sampled music while returning control to the cpu between transfers.  At this time the zxn dma and the cpu share the bus and the dma operates at the currently set cpu speed.
*  **RAM MEMORY** : 768K of RAM in the unexpanded machine or 1792K of RAM in the expanded machine.   This memory is available in 16K banks as in the original 128K Spectrums and can be mapped as usual using the standard ports 0x7ffd and 0x1ffd.   An additional port 0xdffd adds bits to port 0x7ffd to reach all memory banks.  The native bankswitching scheme in the zx next is called MMU.  This scheme divides the same memory into 8K pages and allows any page to be mapped into any 8K slot of the Z80's 64K address space.
*  **ROM MEMORY** : 64K of ROM is reserved for ROMs 0-3 as in the Spectrum +3.  Also available is 32K of Alt ROM that can replace the normal ROMs; this ROM is user programmable.
* **GRAPHICS** : The display is composed of layers with programmable priority.  Layers are listed below.
	* ULA : Compatible timing, contention and floating bus behaviour with the 48k, 128k, +3 and Pentagon.  Supports hardware pixel scrolling in the X and Y directions and these resolutions:
		* 256x192 pixel 32x24 attributes in bank 5 (48k / 128k)
		* 256x192 pixel 32x24 attributes in bank 7 (128k second display)
		* 256x192 pixel 32x24 attributes at 0x6000 in bank 5 (timex second display)
		* 256x192 pixel 32x192 attributes at 0x4000 and 0x6000 in bank 5 (timex hi-colour)
		* 512x192 pixel monochrome at 0x4000 and 0x6000 in bank 5 (timex hi-res)
	* LoRes : Occupies the same layer as the ULA with LoRes replacing the ULA where it is enabled.  Supports hardware pixel scrolling in the X and Y directions.  Two resolutions are available:
		* 128x96 4-bit colour per pixel at either 0x4000 or 0x6000 in bank 5 (Radastan mode originating on the ZX UNO)
		* 128x96 8-bit colour per pixel occupying 0x4000 and 0x6000 in bank 5
	* Layer 2 : A pixel mapped display without colour clash.  Supports hardware pixel scrolling in the X and Y directions.  Can be mapped to any location in memory starting at a 16K boundary.  Available resolutions are:
		* 256x192 8-bit colour per pixel
		* 320x256 8-bit colour per pixel
		* 640x256 4-bit colour per pixel
	* Sprites : Up to 128 hardware sprites of size 16x16 pixels with either 8-bits or 4-bits of colour per pixel.  A minimum of 100 sprites per line can be display at this size.  Sprites can be scaled 1x 2x 4x 8x, rotated, mirrored and linked together.
	* Tilemap : A hardware character display coming in two resolutions (80x32 = 640x256 pixels, 40x32 = 320x256).  Supports hardware pixel scrolling in the X and Y directions.  The character map and glyphs are stored at programmable locations in bank 5.  Individual characters can be independently rotated and mirrored.  Each glyph is 8x8 pixels in size with 4-bits of colour per pixel.  Another mode eliminates rotation and mirroring in favour of 8x8 pixel glyphs defined as monochrome UDGs but with more colour information stored in the character map.

	Some layer priority modes allow layer 2 to be highlighted or darkened by the ULA.  Another setting allows the tilemap and ULA to stencil each other.
* **SOUND** : Stereo sound is played through HDMI, 3.5mm audio jack or optional internal speaker.  Sound sources:
	* Beeper : Beeps and tape sound.
	* 3 x AY 8910 : Arranged to be compatible with the dual arrangement turbosound.  AY instances can be programmed as mono or either ABC or ACB stereo mode.
	* 4 x 8-bit DACs : Two DACs are assigned to the left channel and two are assigned to the right channel.  Common 8-bit dac peripherals in the spectrum community such as specdrum and soundrive are mapped to these dacs.
	* Raspberry PI I2S : Audio generated by an optional Pi accelerator can be mixed into the internal next audio stream or can be mapped to ear for tape loading.


