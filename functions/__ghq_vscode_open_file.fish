function __ghq_vscode_open_file -d "Open a file in a git repository by vscode" 
  # ref: __ghq_repository_search.fish Thanks!
  set -l selector
  [ -n "$GHQ_SELECTOR" ]; and set selector $GHQ_SELECTOR; or set selector fzf

  set -l selector_options
  [ -n "$GHQ_SELECTOR_OPTS" ]; and set selector_options $GHQ_SELECTOR_OPTS

  if not type -qf $selector
    printf "\nERROR: '$selector' not found.\n"
    return 1
  end

  switch "$selector"
    case fzf fzf-tmux peco percol fzy sk
      set repo (ghq list --full-path | "$selector" $selector_options)
    case \*
      printf "\nERROR: fish-ghq and fish-ghq-vscode is not support '$selector'.\n"
  end

  if test -n "$repo" 
    cd 
    # ref: kentaro/fish-ghq-vscode Thanks!
    cd $repo
    set file (git ls-files | "$selector" $selector_options)
    if test -n "$file"
      code "$repo"/"$file"
    end
  end
end