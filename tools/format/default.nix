{ pkgs }:

let
  inherit (pkgs.lib) pipe;
  inherit (builtins) readFile toFile;

  prettierrc = pipe ./.prettierrc [
    readFile
    (toFile "prettierrc")
  ];
in

pkgs.writeShellApplication {
  name = "format";
  runtimeInputs = with pkgs; [
    nodePackages.prettier
  ];
  text = ''
    prettier --config ${prettierrc} --write .
  '';
}

