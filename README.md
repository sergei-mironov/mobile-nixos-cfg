What is it?
-----------

This is an umbrella repo for my [Pinephone](https://www.pine64.org/pinephone/)
and [MobileNixOS](https://mobile.nixos.org/index.html) experiemnts. This repo
may link other projects as Git submodules. I expect it to contain scripts and
customized configurations.


Environment
-----------

* [Pinephone](https://www.pine64.org/pinephone/) and a USB cable
* Host PC with the [Nix](https://nixos.org/nix) package manager installed
* 32Gb SDcard and USB cardreader

Usage
-----

### Flashing the external SDcard with the Jumpdrive utility

* The original document https://wiki.pine64.org/wiki/PinePhone_Installation_Instructions#Using_JumpDrive
* Jumpdrive page https://github.com/dreemurrs-embedded/Jumpdrive

The algorithm:

1. Insert the TF-sdcard to your cardreader and connect it to the Host PC
2. Run the [flash-jumpdrive.sh](./script/flash-jumpdrive.sh) script `sh
   ./script/flash-jumpdrive.sh`
3. Make sure the script detects the sdcard correctly, press `y`
4. Type in the `sudo` password if set. The sdcard is now the jumpdrive sdcard
5. Move the sdcard from the cardreader to the Pinephone
6. Boot the Pinephone and connect it to the PC with USB cable. eMMC flash will
   appear in the list of Host PC's block devices (verify it with `lsblk`).

Now one can flash the phone's internal eMMC from the Host PC.

### Flashing internal eMMC card with the Mobile NixOS example configuration

* [1] Tomf blog provided a good set of instructions https://git.sr.ht/~tomf/notes/tree/master/item/pinephone-nixos-getting-started.md
* [2] Aarch64 image issue https://github.com/NixOS/mobile-nixos/issues/373
* On resizing partitions https://github.com/NixOS/mobile-nixos/issues/342

In this section we will flash the pinephone with the bootable MobileNixos
example. Currently it has only an absolute minimum of features, like GUI+Wifi.
I only tested building MobileNixos image using `binfmt` hack described in [1].
Original configuration doesn't enable SSH by mistake. This mobile-nixos PR fixes
it: https://github.com/NixOS/mobile-nixos/pull/455

1. Enable the `binfmt` boot option of the Host PC's kernel as described in [1].
2. Make sure that:
   - External SDcard is flashed with Jumpdrive utility
   - The pinephone is booted from Jumpdrive SDcard, connected to the Host PC and
     the internal eMMC is listed among the PC block devices (`lsblk`).
3. Make sure that `mobile-nixos` and `nixpkgs` submodules are checked-out (`git
   submodule update --init --recursive`).
4. Edit the `DEVL` variable of
   [flash-mobile-nixos](./script/flash-mobile-nixos.sh). Set it to the correct name
   of internal eMMC device.
5. Run `sh script/flash-mobile-nixos.sh`
6. Upon completion, turn the Pinephone off, remove the Jumpdrive sdcard from the
   Pinephone and turn it on again. Nixos XFCE example image should boot and the
   XFCE desktop should finally appear.
7. Manually resize the partition table on disk and the root filesystem, check
   the result with `df -h`.
   ``` sh
   (pinephone) $ sudo cfdisk /dev/mmcblk2
   ... Add the remaining free space to the /dev/mmcblk2p4 partition
   ... Write the new partition
   (pinephone) $ sudo resize2fs /dev/mmcblk2p4
   ```

### Updating pinephone over SSH

The below mothod allows one to update [Stage-2
software](https://mobile.nixos.org/boot_process.html). The idea is to build the
toplevel package and then upload it's closure using `nix-copy-closure` over SSH.
[See also a related PR
comment](https://github.com/NixOS/mobile-nixos/issues/441#issuecomment-990642848)

1. Turn the Pinephone on, connect it to your local WiFi network and figure out
   its IP address. Mine got 192.168.1.38.
2. Edit the [local.nix](./nix/local.nix) configuration (replace author's SSH
   keys, add packages from the nixpkgs).
3. Adjust the `DEVIP` variable of
   [build-switch-toplevel.sh](./script/build-switch-toplevel.sh) and run it. The
   script may ask device SSH password several times (`nixos` by default).

Now the Pinephone software should be switched to the just-built profile. The old
profile should be accessable through the recovery menu (shown at
reboot+volume up).

Notes
-----

* To make a shallow fetch of a specific commit, do
  `git fetch --depth 1 origin <commit>`

Resources
---------

**MobileNixos on Pinephone**

* PR about Phosh integration https://github.com/NixOS/mobile-nixos/pull/352
* NixOS wiki about Pinephones https://nixos.wiki/wiki/PinePhone

**MobileNixos general**

* Getting started https://mobile.nixos.org/getting-started.html
* Discource https://discourse.nixos.org/t/mobile-nixos-progress-thread/342/51
* GitHub https://github.com/NixOS/mobile-nixos
* Hydra status page https://hydra.nixos.org/build/134431266#tabs-buildinputs
* Custom Qemu port (no GPU) https://unxp.fr/post/2020/pinephone_on_qemu_emulation/
* PR related to the emulation https://github.com/NixOS/mobile-nixos/pull/253
* NixOS wiki on Aarch64 emulation https://nixos.wiki/wiki/NixOS_on_ARM#Compiling_through_QEMU
* PR+discussion about the emulation https://github.com/NixOS/mobile-nixos/issues/3

**PinePhone general**

* PinePhone Installation Instructions https://wiki.pine64.org/wiki/PinePhone_Installation_Instructions
* nOOb microSD flashing https://wiki.pine64.org/wiki/NOOB#Step-by-Step_Instructions_to_Flashing_MicroSD_Cards
* https://news.ycombinator.com/item?id=23130247
* MicroSD extender https://pine64.com/product/pinephone-microsd-extender/
* PostmarketOS docs on Pinephone https://wiki.postmarketos.org/wiki/PINE64_PinePhone_(pine64-pinephone)
* Jumpdrive https://github.com/dreemurrs-embedded/Jumpdrive
* Jumpdrive boot menu issue https://github.com/dreemurrs-embedded/Jumpdrive/issues/11

**Mobile nixers**

* https://github.com/knedlsepp/flakephone
* Noob question from me https://discourse.nixos.org/t/mobile-nixos-progress-thread/342/57?u=sergeymironov
* Tomf blog https://git.sr.ht/~tomf/notes/tree/master/item/pinephone-nixos-getting-started.md
* Mhuesch https://github.com/mhuesch/pinephone-mobile-nixos-flake-example

**Fun**

* Nix maintainers, discovering Nix icon on the PinePhone site, to their surprise https://discourse.nixos.org/t/nixos-on-home-page-of-pinephone/4765

