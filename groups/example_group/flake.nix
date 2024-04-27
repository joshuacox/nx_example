{
  inputs = {
    sops-nix.url = "github:Mic92/sops-nix";
    nixpkgs.url = "nixpkgs/nixos-23.11";
    unstable.url = "nixpkgs/nixos-unstable";
    colmena.url = "github:zhaofengli/colmena";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { self, nixpkgs, sops-nix, colmena, ... } @ inputs: {
    colmena = {
      meta = {
        nixpkgs = import nixpkgs {
          system = "x86_64-linux";
          config.allowUnsupportedSystem = true;
        };
      };
      defaults = { pkgs, ... }: {
        imports = [
          inputs.sops-nix.nixosModules.sops
          ../../nix/user1.nix
          ../../nix/k3s.nix
          ../../nix/vim.nix
          ../../nix/server.nix
          ../../nix/system.nix
          ../../nix/zsh.nix
        ];
      };
      pihost1 = { pkgs, name, nodes, ... }: {
        imports = [
          inputs.nixos-hardware.nixosModules.raspberry-pi-4
          ../../nix/rpi.nix
        ];
        nixpkgs = {
          system = "aarch64-linux";
        };
        deployment = {
          targetHost = "192.168.1.13";
          targetPort = 22;
          buildOnTarget = true;
          targetUser = "root";
          tags = [ "dc1" "rpi" "rpi4" ];
        };
        networking = {
          hostName = name;
        };
        services.k3s = {
          role = "agent";
          serverAddr = "https://192.168.1.17:6443";
        };
      };
      pihost2 = { pkgs, name, nodes, ... }: {
        imports = [
          inputs.nixos-hardware.nixosModules.raspberry-pi-4
          ../../nix/rpi.nix
        ];
        nixpkgs = {
          system = "aarch64-linux";
        };
        deployment = {
          targetHost = "192.168.1.14";
          targetPort = 22;
          buildOnTarget = true;
          targetUser = "root";
          tags = [ "dc1" "rpi" "rpi4" ];
        };
        networking = {
          hostName = name;
        };
        services.k3s = {
          role = "agent";
          serverAddr = "https://192.168.1.17:6443";
        };
      };
      x86host3 = { pkgs, name, nodes, ... }: {
        imports = [
          ../../hosts/nickers/configuration.nix
        ];
        nixpkgs = {
          system = "x86_64-linux";
        };
        deployment = {
          targetHost = "192.168.1.17";
          targetPort = 22;
          buildOnTarget = true;
          targetUser = "root";
          tags = [ "dc1" ];
        };
        networking = {
          hostName = name;
        };
      };
    };
  };
}
