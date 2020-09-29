
autoload -U compinit promptinit zcalc zsh-mime-setup colors zstyle+
compinit
promptinit
zsh-mime-setup
colors

setopt PUSHDSILENT
alias dv="dirs -v"
source ~/ws-journal
cdd() { cd ~$1 }

alias brc='BRAZIL_VERBOSE=true brazil-recursive-cmd'

setopt AUTO_NAME_DIRS # use named dirs when possible
setopt RM_STAR_WAIT # 10 sec wait if you rm *
setopt ZLE # usually this is default, making sure
setopt NO_HUP # must type exit No Ctrl-D for you!
setopt NO_FLOW_CONTROL # less likely to Ctrl-S freeze yourself
setopt NO_BEEP

# nice globs
setopt NO_CASE_GLOB
setopt NUMERIC_GLOB_SORT
setopt EXTENDED_GLOB

# I like vim the editor, but emacs on the cmd-line
export EDITOR=vim
bindkey -e

eval $(thefuck --alias drat)

[ -f "$HOME/.local/share/mechanic/complete.zsh" ] && source "$HOME/.local/share/mechanic/complete.zsh"

#{{{ Prompt!

#TODO what are all these?

host_color=cyan
history_color=yellow
user_color=green
root_color=red
directory_color=magenta
error_color=red
jobs_color=green

host_prompt="%{$fg_bold[$host_color]%}%m%{$reset_color%}"

jobs_prompt1="%{$fg_bold[$jobs_color]%}(%{$reset_color%}"

jobs_prompt2="%{$fg[$jobs_color]%}%j%{$reset_color%}"

jobs_prompt3="%{$fg_bold[$jobs_color]%})%{$reset_color%}"

jobs_total="%(1j.${jobs_prompt1}${jobs_prompt2}${jobs_prompt3} .)"

history_prompt1="%{$fg_bold[$history_color]%}[%{$reset_color%}"

history_prompt2="%{$fg[$history_color]%}%h%{$reset_color%}"

history_prompt3="%{$fg_bold[$history_color]%}]%{$reset_color%}"

history_total="${history_prompt1}${history_prompt2}${history_prompt3}"

error_prompt1="%{$fg_bold[$error_color]%}<%{$reset_color%}"

error_prompt2="%{$fg[$error_color]%}%?%{$reset_color%}"

error_prompt3="%{$fg_bold[$error_color]%}>%{$reset_color%}"

error_total="%(?..${error_prompt1}${error_prompt2}${error_prompt3} )"

case "$TERM" in
  (screen)
   # this is currently handled at the bottom of the file
   # function precmd() { print -Pn "\033]0;S $TTY:t{%100<...<%~%<<}\007" }
  ;;
  (xterm)
    directory_prompt=""
  ;;
  (*)
    directory_prompt="%{$fg[$directory_color]%}%~%{$reset_color%} "
  ;;
esac

if [[ $USER == root ]]; then
    post_prompt="%{$fg_bold[$root_color]%}%#%{$reset_color%}"
else
    post_prompt="%{$fg_bold[$user_color]%}%#%{$reset_color%}"
fi
 
PS1="${host_prompt} ${jobs_total}${history_total} ${directory_prompt}${error_total}${post_prompt} "
 
#}}}
 
#{{{ History
 
 
HISTFILE=~/.history # Where it gets saved
 
# Remember about a years worth of history (AWESOME)
SAVEHIST=10000
HISTSIZE=10000
 
setopt APPEND_HISTORY # Don't overwrite, append!
setopt INC_APPEND_HISTORY # Write after each command
setopt SHARE_HISTORY # Killer: share history between multiple shells
setopt HIST_REDUCE_BLANKS # Pretty    Obvious.  Right?
setopt HIST_IGNORE_SPACE # If a line starts with a space, don't save it.
setopt HIST_NO_STORE # TODO ???
setopt HIST_VERIFY # When using a hist thing, make a newline show the change before executing it.
setopt EXTENDED_HISTORY # Save the time and how long a command ran
 
setopt HIST_IGNORE_DUPS # If I type cd and then cd again, only save the last one
setopt HIST_IGNORE_ALL_DUPS # Even if there are commands inbetween commands that are the same, still only save the last one
setopt HIST_SAVE_NO_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
 
#}}}

# Faster! (?)
zstyle ':completion::complete:*' use-cache 1

# case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' completer _expand _force_rehash _complete _approximate _ignored
_force_rehash() {
  (( CURRENT == 1 )) && rehash
  return 1  # Because we didn't really complete anything
}

# generate descriptions with magic.
zstyle ':completion:*' auto-description 'specify: %d'

# Don't prompt for a huge list, page it!
zstyle ':completion:*:default' list-prompt '%S%M matches%s'

# Don't prompt for a huge list, menu it!
zstyle ':completion:*:default' menu 'select=0'

# Have the newer files last so I see them first
zstyle ':completion:*' file-sort modification reverse

# color code completion!!!!  Wohoo!
zstyle ':completion:*' list-colors "=(#b) #([0-9]#)*=36=31"

unsetopt LIST_AMBIGUOUS
setopt  COMPLETE_IN_WORD

# Separate man page sections.  Neat.
zstyle ':completion:*:manuals' separate-sections true

# Egomaniac!
#zstyle ':completion:*' list-separator 'fREW'

# complete with a menu for xwindow ids
zstyle ':completion:*:windows' menu on=0
zstyle ':completion:*:expand:*' tag-order all-expansions

# more errors allowed for large words and fewer for small words
zstyle ':completion:*:approximate:*' max-errors 'reply=(  $((  ($#PREFIX+$#SUFFIX)/3  ))  )'

# Errors format
zstyle ':completion:*:corrections' format '%B%d (errors %e)%b'

# Don't complete stuff already on the line
zstyle ':completion::*:(rm|vi):*' ignore-line true

# Don't complete directory we are already in (../here)
zstyle ':completion:*' ignore-parents parent pwd

zstyle ':completion::approximate*:*' prefix-needed false

#}}}


autoload -U compinit promptinit zcalc zsh-mime-setup
compinit
promptinit
zsh-mime-setup




# if using GNU screen, let the zsh tell screen what the title and hardstatus
# of the tab window should be.
if [[ $TERM == "screen" ]]; then
  _GET_PATH='echo $PWD | sed "s/^\/Users\//~/;s/^~$USER/~/"'

  # use the current user as the prefix of the current tab title (since that's
  # fairly important, and I change it fairly often)
  TAB_TITLE_PREFIX='"`'$_GET_PATH' | sed "s:..*/::"`$PROMPT_CHAR"'
  # when at the shell prompt, show a truncated version of the current path (with
  # standard ~ replacement) as the rest of the title.
  TAB_TITLE_PROMPT='$SHELL:t'
  # when running a command, show the title of the command as the rest of the
  # title (truncate to drop the path to the command)
  TAB_TITLE_EXEC='$cmd[1]:t'

  # use the current path (with standard ~ replacement) in square brackets as the
  # prefix of the tab window hardstatus.
  TAB_HARDSTATUS_PREFIX='"[`'$_GET_PATH'`] "'
  # when at the shell prompt, use the shell name (truncated to remove the path to
  # the shell) as the rest of the title
  TAB_HARDSTATUS_PROMPT='$SHELL:t'
  # when running a command, show the command name and arguments as the rest of
  # the title
  TAB_HARDSTATUS_EXEC='$cmd'

  # tell GNU screen what the tab window title ($1) and the hardstatus($2) should be
  function screen_set()
  {
    # set the tab window title (%t) for screen
    print -nR $'\033k'$1$'\033'\\\

    # set hardstatus of tab window (%h) for screen
    print -nR $'\033]0;'$2$'\a'
  }
  # called by zsh before executing a command
  function preexec()
  {
    local -a cmd; cmd=(${(z)1}) # the command string
    eval "tab_title=$TAB_TITLE_PREFIX$TAB_TITLE_EXEC"
    eval "tab_hardstatus=$TAB_HARDSTATUS_PREFIX$TAB_HARDSTATUS_EXEC"
    screen_set $tab_title $tab_hardstatus
  }
  # called by zsh before showing the prompt
  function precmd()
  {
    eval "tab_title=$TAB_TITLE_PREFIX$TAB_TITLE_PROMPT"
    eval "tab_hardstatus=$TAB_HARDSTATUS_PREFIX$TAB_HARDSTATUS_PROMPT"
    screen_set $tab_title $tab_hardstatus
  }
fi

export PATH=$PATH:/usr/local/bin  # MIDWAY PATH: Path changed for ssh
export PATH=/Users/mdearde/bin:$PATH
export PATH=$HOME/.toolbox/bin:$PATH
export PATH="/usr/local/opt/gnu-getopt/bin:$PATH"
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="/usr/local/lib/ruby/gems/2.6.0/bin/:$PATH"
eval "$(rbenv init -)"
