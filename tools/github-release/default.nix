{ pkgs }:

pkgs.writeShellApplication {
  name = "github-release";
  runtimeInputs = with pkgs; [ git semantic-release ];
  text = ''
    main_branch=$(git remote show origin | grep "HEAD branch:" | sed "s/HEAD branch://" | tr -d " \t\n\r")

    semantic-release \
      --branch "$main_branch" \
      --plugins @semantic-release/github @semantic-release/commit-analyzer @semantic-release/release-notes-generator
  '';
}
