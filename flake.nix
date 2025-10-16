{
  description = "An simple flake for create gleam develop environment.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    systems.url = "github:nix-systems/default";
    devenv.url = "github:cachix/devenv";
    gleam-overlay.url = "github:Comamoca/gleam-overlay";
    mcp-servers-nix = {
      url = "github:natsukium/mcp-servers-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
        inputs.treefmt-nix.flakeModule
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
          treefmt = {
            projectRootFile = "flake.nix";
            programs = {
              nixfmt.enable = true;
            };

            settings.formatter = { };
          };

          devenv.shells.default = let
            nix-ls-path = pkgs.lib.makeLibraryPath (
                with pkgs;
                [
                  openssl
                  systemd
                  glibc
                  glibc.dev
                  glib
                  cups.lib
                  cups
                  nss
                  nssTools
                  alsa-lib
                  dbus
                  at-spi2-core
                  libdrm
                  expat
                  xorg.libX11
                  xorg.libXcomposite
                  xorg.libXdamage
                  xorg.libXext
                  xorg.libXfixes
                  xorg.libXrandr
                  xorg.libxcb
                  mesa
                  libxkbcommon
                  pango
                  cairo
                  nspr
                ]
            );

	    mcp-config = inputs.mcp-servers-nix.lib.mkConfig pkgs {
              programs = {
                playwright.enable = true;
              };
            };
	    in {
              packages = with pkgs; [
                nil
		jq
                python313Packages.livereload
                inotify-tools
                watchman
                tailwindcss_4
		playwright
		playwright-test
		playwright-mcp
		esbuild
              ];

              languages = {
                gleam = {
                  enable = true;
                  package = pkgs.gleam.bin.latest;
                };
                javascript = {
                  enable = true;
                  bun.enable = true;
                };
              };

              enterShell = ''
                NIX_LD_LIBRARY_PATH = ${nix-ls-path}
		# mkdir ./.claude
		# if [ -L "./.claude/mcp.json" ] || [ -f "./.claude/mcp.json" ]; then
                #   rm -f ./.claude/mcp.json
                # fi
                # ${mcp-config} > ./.claude/mcp.json

                if [ -L ".mcp.json" ]; then
                  unlink .mcp.json
                fi
                ln -sf ${mcp-config} .mcp.json
                '';
            };
        };
    };
}
