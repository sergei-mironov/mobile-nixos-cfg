What is it?
-----------

This is an umbrella repo for my Pine64 and MobileNixOS experiemnts. This repo
may link other projects as Git submodules. Also I expect it to contain scripts
and customized configurations.

Usage
-----

0. Install [Nix](https://nixos.org/nix)
1. `git clone --recursive https://github.com/grwlf/mobile-nixos-cfg`
2. `cd mobile-nixos-cfg`
3. `./build.sh`
4. ???
5. Nothing valuable here yet.

Notes
-----

* To make a shallow fetch of a specific commit, do
  `git fetch --depth 1 origin <commit>`

### Flashing internal eMMC

* Original document https://wiki.pine64.org/wiki/PinePhone_Installation_Instructions#Using_JumpDrive
* Jumpdrive page https://github.com/dreemurrs-embedded/Jumpdrive

The algorithm:

1. Insert the TF-sdcard to your cardreader and connect it to PC
2. Run `sh ./script/flash-jumpdrive.sh`
3. Make sure the script detects the sdcard correctly, press `y`
4. Type in the `sudo` password if set. The sdcard is now the jumpdrive sdcard
5. Move the sdcard from the PC to the Pinephone
6. Boot the Pinephone and connect it to the PC with USB cable. eMMC flash will
   appear.
7. (TODO) write your image of choice to the eMMC
8. Remove jumpdrive sdcard from the Pinephone

Resources
---------

**General**

* Getting started https://mobile.nixos.org/getting-started.html
* Discource https://discourse.nixos.org/t/mobile-nixos-progress-thread/342/51
* GitHub https://github.com/NixOS/mobile-nixos
* Hydra status page https://hydra.nixos.org/build/134431266#tabs-buildinputs
* Main (big) NixOS wiki page about Pinephone https://nixos.wiki/wiki/PinePhone

**PinePhone general**

* PinePhone Installation Instructions https://wiki.pine64.org/wiki/PinePhone_Installation_Instructions
* nOOb microSD flashing https://wiki.pine64.org/wiki/NOOB#Step-by-Step_Instructions_to_Flashing_MicroSD_Cards
* https://news.ycombinator.com/item?id=23130247
* MicroSD extender https://pine64.com/product/pinephone-microsd-extender/
* PostmarketOS docs on Pinephone https://wiki.postmarketos.org/wiki/PINE64_PinePhone_(pine64-pinephone)

**Mobile nixers**

* https://github.com/knedlsepp/flakephone
* Noob question from me https://discourse.nixos.org/t/mobile-nixos-progress-thread/342/57?u=sergeymironov
* Tomf blog https://git.sr.ht/~tomf/notes/tree/master/item/pinephone-nixos-getting-started.md

**Fun**

* Nix maintainers found out Nix icon on the PinePhone site, to their surprise https://discourse.nixos.org/t/nixos-on-home-page-of-pinephone/4765

