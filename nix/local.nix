{ lib, pkgs, ... }:

{
  imports = [
    ../modules/mobile-nixos/examples/demo/configuration.nix
  ];
  nixpkgs.system = "aarch64-linux";
  environment.systemPackages = with pkgs; [
    ncdu
    htop
    vim

    xlibs.xeyes
    xfce.xfce4-battery-plugin # Doesn't work as expected
  ];
}
