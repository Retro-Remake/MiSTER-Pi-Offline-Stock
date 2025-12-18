

# MiSTer Tandy Color Computer 2 (CoCo2)  and Dragon 32

Originally started by:

https://github.com/pcornier/coco2

Completeted by dshadoff, alanswx,  pcornier, shodge12, and theflynn49.
Regression tests by Kathleen.

### Tandy Color 2

This core implements a Tandy Color Computer 2 (CoCo2) including:
 * 64k Memory
 * 2 Analog Joysticks (with a swap feature)
 * Cassette Loading/Saving
 * Sound
 * Cartridge Support
 * Disk support

### Dragon 32 / 64

 * 32K Dragon32 or 64K Dragon64
 * 2 Analog Joysticks (with a swap feature)
 * Cassette Loading/Saving
 * Sound
 * Cartridge Support
 * Disk support

### ROMS

This core needs ROMS, that you may build from files you find easely on colorcomputerarchive (or elsewhere)

 * boot0.rom : 16k (CoCo2) : concatenation of extbas11.rom and bas12.rom, in this order.
 * boot1.rom : 16k (Dragon32) : copy of d32.rom
 * boot2.rom : 32k (Dragon64) concatenation of d64rom1.rom and d64rom2.rom in this order.
 * boot3.rom : 24k (Disk drivers) concatenation of disk11.rom, sdose8.rom (for D32) and sdose8.rom (for D64) again in this order.

You may use other components, these are just the ones we use to run the regression tests. You need to respect the location of the rom in the boot files, like you would respect the location of a rom chip on a motherboard.

Once you collected the needed files, you may run theses commands on your MiSTer to build the bootX.rom files :

 * cat extbas11.rom bas12.rom > /media/fat/games/CoCo2/boot0.rom
 * cp d32.rom  /media/fat/games/CoCo2/boot1.rom 
 * cat d64rom1.rom d64rom2.rom > /media/fat/games/CoCo2/boot2.rom
 * cat disk11.rom sdose8.rom sdose8.rom > /media/fat/games/CoCo2/boot3.rom

![Coco2 running on the AX309](photo.jpg)

*Coco 2 running on a AX309 board*
