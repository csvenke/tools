{ pkgs }:

pkgs.writeShellApplication {
  name = "dotnet-run";
  runtimeInputs = with pkgs; [ fzf findutils ];
  text = ''
    if ! command -v dotnet &> /dev/null; then
        exit 1
    fi

    project_dirs=$(find . -type f -name "*.csproj" -exec dirname {} \; | sort -u | sed 's#^\./##')

    if [ -z "$project_dirs" ]; then
      exit 1
    fi

    selected_dir=$(echo "$project_dirs" | fzf)

    if [ -z "$selected_dir" ]; then
      exit 1
    fi

    dotnet run --project "$selected_dir"
  '';
} 
