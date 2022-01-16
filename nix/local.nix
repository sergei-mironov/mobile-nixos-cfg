{ lib, pkgs, ... }:

{
  imports = [
    ../modules/mobile-nixos/examples/demo/configuration.nix
  ];
  nixpkgs.system = "aarch64-linux";
  environment.systemPackages = [
    pkgs.ncdu
    pkgs.htop
    pkgs.vim

    pkgs.xlibs.xeyes
    pkgs.xfce.xfce4-battery-plugin # Doesn't work as expected
  ];
}
