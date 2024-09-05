{ pkgs }:

pkgs.writeShellApplication {
  name = "npm-run";
  runtimeInputs = with pkgs; [ fzf jq ];
  text = ''
    if ! command -v npm &> /dev/null; then
        exit 1
    fi

    if [ ! -f package.json ]; then
        exit 1
    fi

    scriptNames=$(jq -r '.scripts | keys[]' package.json)

    if [ -z "$scriptNames" ]; then
        exit 1
    fi

    selectedScript=$(echo "$scriptNames" | fzf)

    if [ -z "$selectedScript" ]; then
        exit 1
    fi

    npm run "$selectedScript"
  '';
}
