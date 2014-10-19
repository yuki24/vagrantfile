alias gti="git"
alias gst="git status"
alias gbr="git branch"
alias glg="git log"

alias gfu="git fetch upstream"
alias gfo="git fetch origin"

alias gpo="git push origin"
alias gpu="git push upstream"

alias gd="git diff"
alias gdc="git diff --cached"

alias gs="git show"

alias gg="git grep"

alias be="bundle exec"
alias bs="bundle show"
alias bo="bundle open"

alias reloadbash="echo 'source ~/.bashrc'; source ~/.bashrc"

alias e="emacs"

if [ -f ~/.bash_yuki24 ]; then
    . ~/.bash_yuki24
fi
