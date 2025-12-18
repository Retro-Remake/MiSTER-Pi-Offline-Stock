# [Gameboy](https://en.wikipedia.org/wiki/Game_Boy)  / [Gameboy Color](https://en.wikipedia.org/wiki/Game_Boy_Color) port to [MiSTer](https://github.com/MiSTer-devel/Main_MiSTer/wiki)

_This is a port of [Gameboy for MiST](https://github.com/mist-devel/gameboy)_

* Place RBF file into root of SD card.
* Place \*.gb|*.gbc files into Gameboy folder.

## Features
* Original Gameboy & Gameboy Color Support
* Super Gameboy Support - Borders, Palettes and Multiplayer
* MegaDuck Support
* Custom Borders
* SaveStates
* Fastforward 
* Rewind - Allows you to rewind up to 40 seconds of gameplay
* Frameblending - Prevents flicker in some games (e.g. "Chikyuu Kaihou Gun Zas") 
* Custom Palette Loading
* Real-Time Clock Support
* Gameboy Link Port Support - Requires USERIO adapter
* Cheats
* Fast boot
* GBA mode for GBC games

## Open Source Bootstrap roms
Open source roms are included in the core, adapted from the SameBoy project [https://github.com/LIJI32/SameBoy/](https://github.com/LIJI32/SameBoy/). These roms have MiSTer-specific enhancements, allowing fast booting and GBA mode to be controlled by the on-screen display.

 For maximum compatibility/authenticity you can still place the Gameboy bios/bootroms into the Gameboy folder and load them in the menu with `Bootroms->Load GBC/DMG/SGB boot`. 

For more information see the [BootROM README](./BootROMs/README.md)  

## Palettes
This core supports custom palettes (*.gbp) which should be placed into the Gameboy folder. Some examples are available in the palettes folder.

## Custom Borders
This core supports custom borders (*.sgb) which should be placed into the Gameboy folder. Some examples are available in the borders folder.

## Autoload
To autoload your favorite game at startup rename it to `boot2.rom`.

## Video output
The Gameboy can disable video output at any time which causes problems with vsync_adjust=2 or analog video during screen transitions. Enabling the Stabilize video option may fix this at the cost of some increased latency.

## Savestates
This core provides 4 slots to save and restore the memory state which means you can save at any point in the game. These can be saved to your SD Card or they can reside only in memory for temporary use (OSD Option). Save states can be performed with the Keyboard, a mapped button to a gamepad, or through the OSD.

Keyboard Hotkeys for save states:
- <kbd>ALT</kbd>+<kbd>F1</kbd>/<kbd>F2</kbd>/<kbd>F3</kbd>/<kbd>F4</kbd> – save state  
- <kbd>F1</kbd>/<kbd>F2</kbd>/<kbd>F3</kbd>/<kbd>F4</kbd> – restore state


Gamepad:

- <kbd>SAVESTATEBUTTON</kbd>+<kbd>LEFT</kbd>/<kbd>RIGHT</kbd> prev/next savestate slot
- <kbd>SAVESTATEBUTTON</kbd>+<kbd>START</kbd>+<kbd>DOWN</kbd> saves to the selected slot
- <kbd>SAVESTATEBUTTON</kbd>+<kbd>START</kbd>+<kbd>UP</kbd> loads from the selected slot
