# import profile environment variables
fenv source ~/.profile

# Aliases
alias lss='ranger'
alias cl='clear'

function current_branch
  set ref (git symbolic-ref HEAD 2> /dev/null); or \
  set ref (git rev-parse --short HEAD 2> /dev/null); or return
  echo ref | sed s-refs/heads--
end

function _git_log_prettily
  if ! [ -z $1 ]; then
    git log --pretty=$1
  end
end

alias ggpull='git pull origin (current_branch)'
alias ggpur='git pull --rebase origin (current_branch)'
alias ggpush='git push origin (current_branch)'
alias ggpnp='git pull origin (current_branch); and git push origin (current_branch)'
alias grhh='git reset HEAD --hard'
alias gwc='git whatchanged -p --abbrev-commit --pretty=medium'
alias glp="_git_log_prettily"

# cURL
abbr -a cpost curl -X POST -H '"Content-Type: application/json"' -H '"Authorization: Bearer "' --data '"{}"' -i
abbr -a cget curl -H '"Content-Type: application/json"' -H '"Authorization: Bearer "' -i
