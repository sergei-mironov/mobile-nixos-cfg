{ lib, pkgs, ... }:
let
  ssh_pubkeys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCYd45Y/tmUMj1GcC/QGyxlMxA3uQZE8WHu3QclgF/ha2UK1Z70CqSQVBN66S+rvSvAgrJPuEnqOeMIUGssOatSxMZupSOmUi+Wy5mUIE0gcfpZd/OfpsO7tTCCg5WPxatGMrfPGJESiQOnsJCt8Edy24x8hy/yrfARmfqsOS/CsmGagxSovcAfaqiDPiOqFoBS9eY/zJqKC3hr+bi2P8gfN0Nm76MIjOnpamlUCHW4+w30WzJkN8wvOPa1YaEoqLS6Dyvg11nywEcFUhqGI7H4gAkXYaaNU9Z0cbgPMZJf6UgJa0VNpVKTxYkliqoC0xCp4TpUK09hHJvUMrCMBUBD grwlf@greyblade"
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDnzUrsA7+Fwk+Ap91+WHlUQPfVeOt5CVpE9talGHnN0gEIrBR3jE7IbVnjvMIdTIEupQtBz41JR9eSGFLcZ0mSS7npDaq3poU9rO21uNTZx0AixANyiS34Vzzx0fl2t+sLvsBT0V6M4EjqFeRbeFyYVDl0vjH18sOdUggT/AHW130r8WYVy9XA0jWqUgwe2xKIKcc7gHrG2qLYyPOpuJT3W7kBlOUNruqTOKn2RH3T966d57EAqX0KwRH608Qpv4Lk2QrqsXbnv8jH7mU5wrVrlCPoIDJ4xLPw6sTBuH6U9CFN8T/txwV6M9ECBO96TnCzwWk3s9NJjrIdcOrNvSaP grwlf@darktower"
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCfvRFEMMOZ44QfRdScOE1YfFlOc1XM0Ly2aImmtG6jqBdJWiS13YW/wM3MhcTDbpHQdjGSOaTH95FBMOeOnShzYZ5SioPjA50Ir78ruoDY49L2Gcq+ogEqsjwS+0XY5epC7geBmqcVObnlgyyFbN2+TI8ROI7ifzk43jP4oLpgCZDacJGNE8jLSA6+xbgmPmkz/rd5N+4a2ZkAgYc8of7mIbjvTZb7sFYBisVs0xydXis4KfV7YuwnEVHtNUMdyBxunyprc0zxxBLJ6hDjf0rqO9PRBZj1EnLfD+516MatqvB+ZtAF8/2H29KNdvO0wHjER2BkXNHqi9d0VaCiLn9HCIzh2aL4Vu0GrCec0r2kv90tzn5ijtkxESW8Dla6LIWJOVoZ93kFT/k32EvwfxY6Kf5PckIVzjF4Ed8py76JZe2C+1NrwF1hrft3eWpwJUTnmQ2IHCr4sb05NDxgcNfC3oLEp6dtvQkh8Ji7qJIuryqdOxMyYajjsSWX75oFfOk= sergey@greyblade"
  ];
in

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

  users.users.nixos = {
    openssh.authorizedKeys.keys = ssh_pubkeys;
  };
  users.users.root = {
    openssh.authorizedKeys.keys = ssh_pubkeys;
  };
}
