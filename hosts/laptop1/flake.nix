{
  description = "A thalhalla laptop config";

  inputs = {
    nx.url = "github:joshuacox/nx";
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs.url = "nixpkgs/nixos-23.11";
    unstable.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    musnix  = { url = "github:musnix/musnix"; };
  };

  outputs = inputs@{ nx, musnix, sops-nix, nixpkgs, home-manager, ... }: {
    nixosConfigurations = {
      laptop1 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          sops-nix.nixosModules.sops
          ./configuration.nix
          ./../../nix/bash.nix
          ./../../nix/brave.nix
          ./../../nix/chromium.nix
          ./../../nix/cups.nix
          ./../../nix/font.nix
          ./../../nix/firefox.nix
          ./../../nix/guipackages.nix
          ./../../nix/gpg.nix
          ./../../nix/java.nix
          ./../../nix/mus.nix
          ./../../nix/nu.nix
          ./../../nix/nx.nix
          ./../../nix/packages.nix
          ./../../nix/steam.nix
          ./../../nix/vim.nix
          ./../../nix/virt.nix
          ./../../nix/vivaldi.nix
          ./../../nix/zsh.nix
          inputs.musnix.nixosModules.musnix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            #home-manager.users.user1 = import ./users/user1/home.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }
        ];
      };
    };
  };
}
