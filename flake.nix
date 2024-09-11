{
  description = "Tools flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ flake-parts, nixpkgs, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = nixpkgs.lib.systems.flakeExposed;
      perSystem = { config, pkgs, ... }:
        let
          inherit (builtins) attrValues;
          inherit (pkgs) callPackage;

          tools = {
            github-release = callPackage ./tools/github-release { };
            dev = callPackage ./tools/dev { };
            dotnet-run = callPackage ./tools/dotnet-run { };
            npm-run = callPackage ./tools/npm-run { };
            format = callPackage ./tools/format { };
            tmux = callPackage ./tools/tmux { };
          };
        in
        {
          packages = {
            inherit (tools) tmux dev;
            default = pkgs.buildEnv {
              name = "tools";
              paths = attrValues tools;
            };
          };
          devShells = {
            default = pkgs.mkShell {
              packages = attrValues tools;
            };
          };
        };
    };
}
