# [Gameboy Advance](https://en.wikipedia.org/wiki/Game_Boy_Advance) for [MiSTer Platform](https://github.com/MiSTer-devel/Main_MiSTer/wiki)


## HW Requirements/Features
The games can run from a naked DE10-Nano with the built-in DDR-RAM.
However, using SDRAM is highly recommended, as some games may slowdown or lose sync when using DDR-RAM.

When using SDRAM, it requires 32MB SDRAM for games less than 32MB. 32MB games require either 64MB or 128MB module.
SDRAM will be automatically used when available and size is sufficient.

## Bios
Opensource Bios from Normmatt is included, however it has issues with some games.
Original GBA BIOS can be placed to GBA folder with name boot.rom

PLEASE do not report errors without testing with the original BIOS

Homebrew games are sometimes not supported by the official BIOS, 
because the BIOS checks for Nintendo Logo included in the ROM, which is protected by copyright.
To use these ROMs without renaming or removing the boot.rom, 
you can activate the "Homebrew BIOS" settings in OSD.
As the BIOS is already replaced at boot time, you must save this setting and hard reset/reload the GBA core.

## Status
~1600 games tested until ingame.
There is no known official game that doesn't work.
Exceptions are games that require rare extra hardware (mostly japanese).
Some small video glitches remain, see issue list.

## Features
- Saving as in GBA
- Savestates
- FastForward - speed up game by factor 2-4
- CPU Turbomode - give games additional CPU power
- Flickerblend - set to blend or 30Hz mode for games like F-Zero, Mario Kart or NES Classics to prevent flickering effects
- Spritelimit - turn on to prevent wrong sprites for games that rely on the limit (opt-in)
- Cheats
- Color optimizations: shader colors and desaturate
- Rewind: go back up to 60 seconds in time
- Tilt: use analog stick (map stick in Mister Main before)
- Solar Sensor: Set brightness in OSD
- Gyro: use analog stick (map stick in Mister Main before)
- RTC: automatically used, works with RTC board or internet connection
- Rumble: for Drill Dozer, Wario Ware Twisted and some romhacks
- 2x Resolution: game is rendered at 480x320 instead of 240x160 pixels

## Savestates
Core provides 4 slots to save and restore the state. 
Those can be saved to SD Card or reside only in memory for temporary use(OSD Option). 
Usage with either Keyboard, Gamepad mappable button or OSD.

Keyboard Hotkeys for save states:
- <kbd>ALT</kbd>+<kbd>F1</kbd>/<kbd>F2</kbd>/<kbd>F3</kbd>/<kbd>F4</kbd> – save state  
- <kbd>F1</kbd>/<kbd>F2</kbd>/<kbd>F3</kbd>/<kbd>F4</kbd> – restore state

Gamepad:
- <kbd>SAVESTATEBUTTON</kbd>+<kbd>LEFT</kbd>/<kbd>RIGHT</kbd> prev/next savestate slot
- <kbd>SAVESTATEBUTTON</kbd>+<kbd>START</kbd>+<kbd>DOWN</kbd> saves to the selected slot
- <kbd>SAVESTATEBUTTON</kbd>+<kbd>START</kbd>+<kbd>UP</kbd> loads from the selected slot

## Rewind
To use rewind, turn on the OSD Option "Rewind Capture" and map the rewind button.
You may have to restart the game for the function to work properly.
Attention: Rewind capture will slow down your game by about 0.5% and may lead to light audio stutter.
Rewind capture is not compatible with "Pause when OSD is open", so pause is disabled when Rewind capture is on.

## Spritelimit
There are only very few games known that produce glitches without sprite pixel limit.
Those games use the sprite pixel limit automatically.
You can optionally also turn this on if you notice problems.

## 2x Resolution
Only works over HDMI, Analog output is not changed in 2x Resolution mode. 

Improved rendering resolution for:
- Affine background: "Mode7" games, typically racing games like Mario Kart
- Affine sprites: games that scale or rotate sprites

This rendering is experimental and can cause glitches, as not all game behavior can be supported.
Those glitches can not be fixed without gamespecific hacks and therefore will not be fixed. 
Please don't add bugs in such cases.

## Cartridge Hardware supported games
- RTC: Pokemon Sapphire+Ruby+Emerald, Boktai 1+2+3, Sennen Kazoku, Rockman EXE 4.5
- Solar Sensor: Boktai 1+2+3
- Gyro: Wario Ware Twisted
- Tilt: Yoshi Topsy Turvy/Universal Gravitation, Koro Koro Puzzle - Happy Panechu!
- Rumble: Wario Ware Twisted, Drill Dozer

If there is a game you want to play that also uses one of these features, but is not listed, please open a bug request.

For romhacks you can activate the option "GPIO HACK(RTC+Rumble)". Make sure to deactivate it for other games, otherwise you will experience crashes.

## Not included
- Multiplayer features like serial communication
- E-Reader support
- Gameboy Player features

## Information for developers

How to simulate:
https://github.com/MiSTer-devel/GBA_MiSTer/tree/master/sim

How to implement a GPIO module:
https://github.com/MiSTer-devel/GBA_MiSTer/blob/master/gpio_readme.md
