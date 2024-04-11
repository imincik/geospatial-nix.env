{
  description = "devenv.sh - Fast, Declarative, Reproducible, and Composable Developer Environments";

  nixConfig = {
    extra-trusted-public-keys = "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
    extra-substituters = "https://devenv.cachix.org";
  };

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.pre-commit-hooks = {
    url = "github:cachix/pre-commit-hooks.nix";
    inputs = {
      nixpkgs.follows = "nixpkgs";
      flake-compat.follows = "flake-compat";
    };
  };
  inputs.flake-compat = {
    url = "github:edolstra/flake-compat";
    flake = false;
  };

  outputs = { self, nixpkgs, pre-commit-hooks, ... }@inputs:
    let
      systems = [ "x86_64-linux" "i686-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];
      forAllSystems = f: builtins.listToAttrs (map (name: { inherit name; value = f name; }) systems);
      mkDocOptions = pkgs:
        let
          inherit (pkgs) lib;
          eval = pkgs.lib.evalModules {
            modules = [
              ./modules/top-level.nix
              # { devenv.someConfiguration = value; }
            ];
            specialArgs = { inherit pre-commit-hooks pkgs inputs; };
          };
          sources = [
            { name = "${self}"; url = "https://github.com/imincik/geospatial-nix.env/blob/master"; }
            { name = "${pre-commit-hooks}"; url = "https://github.com/cachix/pre-commit-hooks.nix/blob/master"; }
          ];
          rewriteSource = decl:
            let
              prefix = lib.strings.concatStringsSep "/" (lib.lists.take 4 (lib.strings.splitString "/" decl));
              source = lib.lists.findFirst (src: src.name == prefix) { } sources;
              path = lib.strings.removePrefix prefix decl;
              url = "${source.url}${path}";
            in
            { name = url; url = url; };
          options = pkgs.nixosOptionsDoc {
            options = builtins.removeAttrs eval.options [ "_module" ];

            warningsAreErrors = false;

            transformOptions = opt: (
              opt // { declarations = map rewriteSource opt.declarations; }
            );
          };
        in
        options.optionsCommonMark;
    in
    {
      packages = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in {
          devenv-docs-options = mkDocOptions pkgs;
          geonixcli = pkgs.callPackage ./pkgs/geonixcli { };
        });

      modules = ./modules;

      flakeModule = import ./flake-module.nix self;

      lib = {
        mkConfig = args@{ pkgs, inputs, modules }:
          (self.lib.mkEval args).config;
        mkEval = { pkgs, inputs, modules }:
          let
            moduleInputs = { inherit pre-commit-hooks; } // inputs;
            project = inputs.nixpkgs.lib.evalModules {
              specialArgs = moduleInputs // {
                inherit pkgs;
                inputs = moduleInputs;
              };
              modules = [
                (self.modules + /top-level.nix)
                ({ config, ... }: {
                  # devenv.someConfiguration = value;
                })
              ] ++ modules;
            };
          in
          project;
        mkShell = args:
          let
            config = self.lib.mkConfig args;
          in
          config.shell // {
            ci = config.ciDerivation;
            inherit config;
          };
        customizePackages = import ./modules/customize-packages.nix;
      };

      overlays.default = final: prev: {
        devenv = self.packages.${prev.system}.default;
      };
    };
}
