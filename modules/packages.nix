let
  imports = import ../nix/sources.nix;
in { pkgs, config, lib, ... }: {
  
  nixpkgs.pkgs = import imports.nixpkgs { config.allowUnfree = true; }
    // config.nixpkgs.config;

  home-manager.users.jamie.nixpkgs.config = {
    allowUnfree = true;
  };

  environment.etc.nixpkgs.source = imports.nixpkgs;
  nix = rec {
    nixPath = lib.mkForce [
      "nixpkgs=/etc/nixpkgs"
      "nixos-config=/etc/nixos/configuration.nix"
    ];

    trustedUsers = [ "root" "jamie" "@wheel" ];

    optimise.automatic = true;
  };
}