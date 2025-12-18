# CDi_MiSTer

A project dedicated to create an FPGA implementation of the Philips CD-i to be usable for the MiSTer FPGA project.
As every Philips CD-i player is based on different hardware, this project focuses on reverse engineering the "Mono I".
This mainboard is used in models like the 210/00, 210/05 or 220/20.

This project also aims to replicate the 22ER9141 Digital Video Cartridge based on the VMPEG hardware.

Most games utilizing the hardware of a base CD-i, should work as expected.
Titles which require the Digital Video Cartridge are considered experimental.

## Usage

Place `cdi200.rom` as `boot0.rom` in `/media/fat/games/CD-i`.
Place `zx405042p__cdi_slave_2.0__b43t__zzmk9213.mc68hc705c8a_withtestrom.7206` as `boot1.rom` next to it.
Place `vmpega_split.rom` as `boot2.rom` next to it for DVC functionality.

This core is tested against these files and their respective md5sum:

    2969341396aa61e0143dc2351aaa6ef6  cdi200.rom
    3d20cf7550f1b723158b42a1fd5bac62  zx405042p__cdi_slave_2.0__b43t__zzmk9213.mc68hc705c8a_withtestrom.7206
    9694c466f9b65c1990a81b7a6280546b  vmpega_split.rom
    53ba3bf7443187a657baa272d01d3771  vmpega.rom

Due to legal reasons, they must be sourced separately!

To generate the vmpeg_split rom, use this:

    dd if=vmpega.rom bs=1024 count=128 of=vmpega_split.rom

Save files are stored inside an 8K NvRAM. MiSTer will create one save file per CD.
Whenever the NvRAM state changes, the "User" LED will light up, indicating
a change is queued to store. When the OSD is opened, the NvRAM will be flushed to SD card.

The save files containing the NvRAM are compatible with the CD-i emulation of MAME.

Digital gamepads, analog gamepads and mice are supported for use with this core.
To play a title, load a CD and press on the play button at the start screen.
CD images can be stored as CHD or CUE/BIN format.

## Troubleshooting

* My NTSC CRT television set is not getting a stable image
  *  Please switch the core to NTSC and reset via OSD. This should fix the problem.

## Status

Core Utilization:

    Logic utilization (in ALMs)  22,424 / 41,910 ( 54 % )
    Total registers              25036
    Total block memory bits      2,331,040 / 5,662,720 ( 41 % )
    Total DSP Blocks             96 / 112 ( 86 % )

Expected synthesis times with Quartus 17.0.2

    AMD Ryzen 7 3700X 8-Core                   14 minutes
    Intel(R) Core(TM) i5-8265U CPU @ 1.60GHz   25 minutes

### TODOs

* Fix Christmas Crisis bonus ride
    * Video is much wider than the CD-i resolution. Window function required
* Fix position of MPEG video, relative to base case video
* Add MPEG audio attenuation
* "Mutant Rampage - Bodyslam" has a tendency to freeze?
* "The Last Bounty Hunter", "Drug Wars", "Mad Dog 2", "Who Shot Johnny Rock?" have regressions (works in rc2)?
* "Chaos Control" has video glitches?
* "The Lost Ride" has video glitches?
* "Crime Patrol" has video glitches?
* "Solar Crusade" has video glitches?
* "Brain Dead 13" having no video during intro. And hangs afterwards.
    * The decoding and playback does occur but mv_show() is not done?
* "The Secret of Nimh" (Philips Edition) has the wrong frame rate? Sometimes?
* "The Secret of Nimh" (VCD) doesn't play
    * Huffman decoding in state 14 takes too long
* Slow motion with VCDs is behaving incorrect
* Leaving the cake Puzzle in 7th Guest freezes (everytime?)
* Weird shifted graphics with "David and Goliath"
* VCD resolution for white book
* Sound bugs on the police procedures disk?
* Find a better solution for reducing CPU speed
* Black flicker during intro of Ultimate Noah's Ark in 60 Hz mode
    * A workaround is CPU overclocking. Problem not visible on real machine.
* Give a signal to the user when CPU data stalling occured
* Find a better solution for CD data stalling (take a screenshot)
    * PSX core seems to halt the whole machine to avoid this situation
* Fix regression: Audio hiccups during Philips Logo in Burn:Cycle
    * A workaround is CPU overclocking
* Add missing MCD212 features
    * Pixel Hold
* Investigate input responsiveness (skipped events?)
* Fix hang on audio track stop or change in media player
* Cheat support?
* Investigate "Gray border glitch" at the top of "Myst" gameplay (seems to be only one plane)
* Fix reset behaviour (Core is sometimes hanging after reset)
* Investigate desaturated colors / low contrast in "Photo CD Sample Disc"
    * Probably fixable with 16-235 to 0-255 scaling
    * More investigation needed
* Find a solution for the video mode reset during system resets
    * The ST flag is the issue here, causing a video mode change
* Add SNAC support (IR remote + wired controller)
    * RC5 support is added. A test using real hardware is required.
* Add 2 player support
* CD+G
* Check compatibilitiy with CDs that have track index 2 as opposed to the usual 0 and 1
* Possibly adding support for other PCBs (like Mono II)
* Refurbish I2C for the front display and show the content as picture in picture during changes?
    * It might not even be required at all.

### Issues with external dependencies

* A dump of the SLAVE 3.2 ROM is required to fix some hacks
    * I2C front panel data is not correctly handled (e.g. Play button)
    * The IR codes from the Remote have the same issue when media control buttons are used.

## Simulation

Even so, the [sim](sim) folder seems to be the correct one, it is deprecated.
It was used for mixed language simulation with the free version of ModelSim when the project has started.

The [sim2](sim2) folder is the current one, used for most development and makes use of Verilator for improved performance.

## Used resources

This MiSTer core would've probably never been possible without the reverse engineering efforts of certain people.
Thanks to [CD-i Fan](https://www.cdiemu.org/) for the insights into his closed source CD-i Emulator.
Also Thanks to MooglyGuy, which took on the task of implementing a CD-i emulator into MAME, which I used to analyse
the program flow of the CD-i boot process.

* https://github.com/TobiFlex/TG68K.C
* https://opencores.org/projects/68hc05
* https://github.com/cdifan/cdichips
* http://www.icdia.co.uk/microware/index.html
* https://github.com/Stovent/CeDImu/blob/master/src/CDI/OS9/SystemCalls.hpp
* playcdi (by CD-i Fan) (auto play for Mono I PCB)

## FAQ, Issues and Quirks

The production quality of CD-i hardware and software is sometimes questionable.
For this reason, I've created a list of some known quirks, one might suspect of being caused
by emulation errors but are also present on the real machine.

* Is the "Digital Video Cartridge" supported?
    * Please stop asking! >.<
* The map of "Zelda - Wand of Gamelon" has micro jitter during scrolling
    * This also happens on real 210/05 hardware
* "Hotel Mario" seems to have the first samples of every ingame song repeated
    * You have good ears as it is barely noticeable. This also happens on real hardware.
* Some earlier CD-i titles have both stereo channels swapped
    * Yes, according to an [internal memo from Philips](http://icdia.co.uk/docs/mono2status.zip) there
      were manufacturing issues and some early players have the left and right channel swapped.
      This might explain discrepancies.
    * One known quirk is inverted stereo on the "Philips Logo Jingle" of "Zelda - Wand of Gamelon"
* During the rotating transition in "Myst" there are glitched lines at the bottom
    * This also happens to some extent on a real 210/05 hardware and is caused by a misplaced Video IRQ
      The video data is changed while it is displayed.
* When I load a save game in "Burn:Cycle" it plays a short and unclean loop of noise until I do something
    * I thought that was a bug in the core at first too. However, it is actually like this on a real CD-i too.
* The music of Burn:Cycle sometimes has "pops" and "clicks"
    * This game is special. It doesn't play music from CD like most games for this system would do.
    * Small loops of sampled music are loaded from CD, stored in memory and randomly concatenated together
      to create the background music. These samples are sometimes not very "loopable" creating a pop at looping points.
    * This issue is reproducible on a real 210/05 as well
* The music during the Philips Logo animation of Burn:Cycle has broken audio
    * This issue is reproducible on a real 210/05 as well
    * For some reason, it seems to be absent on other models with different hardware, like the 450/00
    * The problem can be fixed by overclocking the CPU
* Burn:Cycle - Random flickery animated text in front of the "Psychic Roulette" credit card terminal
    * This actually happens on the real machine. I also thought this might be a CPU speed issue, considering that
      the flickering disappears if the CPU is slightly overclocked.
* Flashback: The audio and video during the intro are asynchronous
    * This curiously happens on the real machine as well and doesn't even depend on 50 or 60 Hz
    * It seems to be an oversight by the developers when the game was ported to CD-i
* When dying in "Zelda's Adventure" the accompanying sound effect doesn't match the audio data on CD
    * Good catch! This is a programming error which can be reproduced on a real CD-i 210/05 as well,
      which causes the audio playback to start one sector too late.
    * The same phenomenon exists in the "Help cutscene" of "Zelda - Wand of Gamelon"
        * It is not audible in that game, because of silence in the beginning
* The intro music of Zenith is played only on the left audio channel
  * Yes, this happens on a real 210/05 too. To be sure, I've tested it as well
    on a 450/00. It seems to be an oversight by the developers.
* During the cinematic intro of Kether, the screen flickers to black on some frames during the fading slideshows
  * This curiously happens on a real 210/05 too.
* If I mash the buttons really hard when booting up Tetris, I get a colorful glitched screen instead of the Philips Logo
  * Congratulations for this obscure finding. This happens on a real 210/05 too!
* During the intro of "Zombie Dinos vom Planeten Zeltoid", the title text looks like the last row of pixels is missing during the scaling effect
  * Yes, an oversight it seems. The scaling operation is broken, even on the real machine.
* QuizMania - Missing animation graphics during intro and alignment issues during video playback in menu
  * This game seems to have problems with 60Hz/NTSC mode. Both issues can be reproduced using real 210/05 hardware
  * I assume that this was a local production for the italian market and no testing was performed on NTSC machines
* Inside the settings menu on the start screen, there are purple glitch pixels on the right edge of the screen
  * How could they miss this? It is also present on a real 210/05
* Lemmings is running slow on the core when compared to the Amiga version
  * "Oh No!" *Explodes* It is running as slow as on real hardware,
    but it seems that the CPU Turbo fixes this issue and makes it behave
    more like the Amiga version.
* There is a small green artifact at the top left of the Philips Intro in "Lost Eden"
  * I thought that this is a decoding error, but it is actually there on real hardware
* "Lost Eden" hangs for 1-2 seconds when the music restarts
  * This seems to be an oversight by the developers. It occurs on real hardware all well.

