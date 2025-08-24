{
  description = "An simple flake for create gleam develop environment.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    systems.url = "github:nix-systems/default";
    devenv.url = "github:cachix/devenv";
    gleam-overlay.url = "github:Comamoca/gleam-overlay";
  };

  outputs =
    inputs@{
      self,
      systems,
      nixpkgs,
      flake-parts,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.devenv.flakeModule
      ];
      systems = import inputs.systems;

      perSystem =
        {
          config,
          pkgs,
          system,
          ...
        }:
        {
          _module.args.pkgs = import inputs.nixpkgs {
              inherit system;
              overlays = [
		inputs.gleam-overlay.overlays.default
              ];
              config = { };
            };

          devenv.shells.default = {
            packages = with pkgs; [
	      nil
	      python313Packages.livereload
	      inotify-tools
              watchman
	    ];

            languages = {
              gleam = {
                enable = true;
		package = pkgs.gleam.bin.latest;
              };
              javascript = {
                enable = true;
		bun.enable  = true;
              };
            };

            enterShell = '''';
          };
        };
    };
}
