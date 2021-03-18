What is it?
-----------

This is an umbrella repo for my Mobile NixOS experiemnts. My primary target
device is PinePhone. The repo will link other valuable repos as Git submodules.
Also I expect it to contain scripts and customized configurations.

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

Resources
---------

**General**

* Getting started https://mobile.nixos.org/getting-started.html
* Discource https://discourse.nixos.org/t/mobile-nixos-progress-thread/342/51
* GitHub https://github.com/NixOS/mobile-nixos
* Hydra status page https://hydra.nixos.org/build/134431266#tabs-buildinputs

**PinePhone general**

* PinePhone Installation Instructions https://wiki.pine64.org/wiki/PinePhone_Installation_Instructions
* nOOb microSD flashing https://wiki.pine64.org/wiki/NOOB#Step-by-Step_Instructions_to_Flashing_MicroSD_Cards
* https://news.ycombinator.com/item?id=23130247

**Mobile nixers**

* https://github.com/knedlsepp/flakephone
* Noob question from me https://discourse.nixos.org/t/mobile-nixos-progress-thread/342/57?u=sergeymironov

**Fun**

* Nix maintainers found out Nix icon on a PinePhone site, to their surprise https://discourse.nixos.org/t/nixos-on-home-page-of-pinephone/4765

