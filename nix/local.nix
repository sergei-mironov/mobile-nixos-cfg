{ lib, pkgs, ... }:

{
  imports = [
    ../modules/mobile-nixos/examples/demo/configuration.nix
  ];
  nixpkgs.system = "aarch64-linux";
  environment.systemPackages = [
    pkgs.ncdu
    pkgs.htop
	  # ... etc
  ];
}
