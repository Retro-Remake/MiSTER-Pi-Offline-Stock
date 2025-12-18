# [Gameboy](https://en.wikipedia.org/wiki/Game_Boy)  / [Gameboy Color](https://en.wikipedia.org/wiki/Game_Boy_Color) port to [MiSTer](https://github.com/MiSTer-devel/Main_MiSTer/wiki)

This branch is a special version for splitscreen multiplayer.
In case you are searching for the normal Gameboy, please go here:
https://github.com/MiSTer-devel/Gameboy_MiSTer

# HW Requirements/Features
SDRAM addon is required.

# Foldername
All Games and BIOS go to GAMEBOY2P folder. 

It is seperated from the normal GAMEBOY folder to ensure safe savegame handling.

You can create a symlink to GAMEBOY folder if you want to use the same games/BIOS.

# Status
Most multiplayer games should be supported and working

# Savegames
Saves created contain savegames for both players. 

For compatibility, all saves are 256Kbyte in size, 128 KByte for each player.

Saves can be copied from singleplayer, but only player 1 will have a savegame then. "Dupe Save to GB 2" option can be used to load singleplayer savegames for both players.

Saves can be copied to singleplayer, but when saved in singleplayer, the second player savegame is lost.

# Loading different games
The option "Rom for second GB" can be used to load two different games. First load the game for Player 1 with the option off, then activate the option and load another game for player 2. Both GBs will reset on loading the second game.

Loading the game for player 2 with both "Rom for second GB" and "Dupe Save to GB 2" options enabled can be used to load a singleplayer save for player 2 only.

Saving when playing two different roms will create a combined savegame with the gamename of the second loaded game, which can be loaded again with the same load order next time.

# Video Output
Output resolution is 320x144 pixel, which both screen placed next to each other horizontally.

A seperation line can be enabled in OSD, which will turn the last/first pixel black.

# Audio Output
Selectable in OSD:
- Core 1 to both Channels(left/right)
- Core 2 to both Channels(left/right)
- Mix both cores
- Core 1 to left Channel, Core 2 to right Channel

# Not included in this version:
- Savestates/rewind
- Fastforward
- Super Gameboy Support
- Custom Borders
- Frameblending
- Real-Time Clock Support
- Cheats