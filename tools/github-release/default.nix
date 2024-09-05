{ pkgs }:

pkgs.writeShellApplication {
  name = "github-release";
  runtimeInputs = with pkgs; [ git semantic-release ];
  text = ''
    main_branch=$(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')

    semantic-release \
      --branch "$main_branch" \
      --plugins @semantic-release/github @semantic-release/commit-analyzer @semantic-release/release-notes-generator
  '';
}
