function __ghq_vscode_open_project -d "Open a project of a git repository by vscode"
  set repo (ghq list --full-path | fzf)
  if test -n "$repo" 
    code "$repo"/.
  end
end