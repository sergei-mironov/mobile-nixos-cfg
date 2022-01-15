What is it?
-----------

This is an umbrella repo for my [Pinephone](https://www.pine64.org/pinephone/)
and [MobileNixOS](https://mobile.nixos.org/index.html) experiemnts. This repo
may link other projects as Git submodules. I expect it to contain scripts and
customized configurations.


Environment
-----------

* [Pinephone](https://www.pine64.org/pinephone/) and USB cable
* Host PC with the [Nix](https://nixos.org/nix) package manager installed
* 32Gb SDcard and USB cardreader

Usage
-----

### Flashing the external SDcard with the Jumpdrive utility

* The original document https://wiki.pine64.org/wiki/PinePhone_Installation_Instructions#Using_JumpDrive
* Jumpdrive page https://github.com/dreemurrs-embedded/Jumpdrive

The algorithm:

1. Insert the TF-sdcard to your cardreader and connect it to the Host PC
2. Run `sh ./script/flash-jumpdrive.sh`
3. Make sure the script detects the sdcard correctly, press `y`
4. Type in the `sudo` password if set. The sdcard is now the jumpdrive sdcard
5. Move the sdcard from the cardreader to the Pinephone
6. Boot the Pinephone and connect it to the PC with USB cable. eMMC flash will
   appear in the list of Host PC's block devices (verify it with `lsblk`).

Now one can flash the phone's internal eMMC from the Host PC.

### Flashing internal eMMC card with Mobile NixOS image

* [1] Tomf blog provided a good set of instructions https://git.sr.ht/~tomf/notes/tree/master/item/pinephone-nixos-getting-started.md
* [2] Aarch64 image issue https://github.com/NixOS/mobile-nixos/issues/373

I only tested building MobileNixos image using `binfmt` hack described in [1].

1. Enable `binfmt` boot option as described in [1].
2. Make sure that:
   - External SDcard is flashed with Jumpdrive utility
   - The pinephone is booted from Jumpdrive SDcard, connected to the Host PC and
     the internal eMMC is listed among the PC block devices (`lsblk`).
3. Make sure that `mobile-nixos` and `nixpkgs` submodules are checked-out (`git
   submodule update --init --recursive`).
4. Edit the `DEVL` variable of `script/flash-mobile-nixos`. Set it to the
   correct name of internal eMMC device.
5. Run `sh script/flash-mobile-nixos`


### Updating the system over SSH

How to update the mobile nixos over SSH?

The idea is to build the toplevel and then upload it using `nix-copy-closure`
over SSH. This PR offers some hints on how to do it
https://github.com/NixOS/mobile-nixos/issues/441#issuecomment-990642848

1. `sh script/build-mobile-nixos.sh -A config.system.build.toplevel`
2. (TODO) figure out how to SSH etc

Notes
-----

* To make a shallow fetch of a specific commit, do
  `git fetch --depth 1 origin <commit>`

Resources
---------

**MobileNixos general**

* Getting started https://mobile.nixos.org/getting-started.html
* Discource https://discourse.nixos.org/t/mobile-nixos-progress-thread/342/51
* GitHub https://github.com/NixOS/mobile-nixos
* Hydra status page https://hydra.nixos.org/build/134431266#tabs-buildinputs
* Main (big) NixOS wiki page about Pinephone https://nixos.wiki/wiki/PinePhone
* PR related to the emulation https://github.com/NixOS/mobile-nixos/pull/253
* Custom Qemu port (no GPU) https://unxp.fr/post/2020/pinephone_on_qemu_emulation/

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

* Nix maintainers, discovering Nix icon on the PinePhone site, to their surprise https://discourse.nixos.org/t/nixos-on-home-page-of-pinephone/4765

