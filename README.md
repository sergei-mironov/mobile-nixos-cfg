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

* Getting started https://mobile.nixos.org/getting-started.html
* Discource https://discourse.nixos.org/t/mobile-nixos-progress-thread/342/51
* GitHub https://github.com/NixOS/mobile-nixos
* Hydra status page https://hydra.nixos.org/build/134431266#tabs-buildinputs
