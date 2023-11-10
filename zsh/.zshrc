source /usr/local/share/antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle command-not-found
antigen bundle fzf

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
antigen theme clean

# Tell Antigen that you're done.
antigen apply

PATH_PREFIX=''
PATH_ORIG=$PATH
function pathadd() {
    if [[ -e "$1" ]]; then
        if [[ -z "$PATH_PREFIX" ]]; then
            PATH_PREFIX="$1"
        else
            PATH_PREFIX="$PATH_PREFIX:$1"
        fi
        export PATH="$PATH_PREFIX:$PATH_ORIG"
    else
        echo >&2 "$1 doesn't exist; not adding it to the path"
    fi
}

pathadd $HOME/.local/bin
pathadd $HOME/.toolbox/bin
pathadd /usr/local/lib/ruby/gems/2.6.0/bin/
pathadd /usr/local/opt/ruby/bin
pathadd /usr/local/opt/gnu-getopt/bin
pathadd /usr/local/bin

eval "$(jump shell zsh)"
eval "$(direnv hook zsh)"
eval $($(echo dGhlZnVjawo= | python3 -m base64 -d) --alias drat)

export EDITOR=$(command -v nvim)
export VISUAL="$EDITOR"

export GPG_TTY=$(tty)

[ -f "$HOME/.local/share/mechanic/complete.zsh" ] && source "$HOME/.local/share/mechanic/complete.zsh"

unset PATH_PREFIX
unset PATH_ORIG
unfunction pathadd
