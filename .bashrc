#{{{ General
export CLICOLOR=1
export LS_COLORS='rs=0:di=34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:';

OS_NAME=$(uname -s)
export IS_LINUX=1
export IS_OS_X=1
if [ "$OS_NAME" = "Darwin" ]; then
  IS_OS_X=0

  if $(which brew > /dev/null); then
    export BREW_PREFIX=$(brew --prefix)
  fi
else
  IS_LINUX=0
fi

# Completion
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
  source /etc/bash_completion
fi

if [ -f $BREW_PREFIX/etc/bash_completion ]; then
  source $BREW_PREFIX/etc/bash_completion
fi

# Path
if [ $IS_OS_X ]; then
  export PATH="/usr/local/opt/coreutils/libexec/gnubin:/usr/local/sbin:$PATH"
  export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
fi

# Misc os-specific
if [ $IS_OS_X ]; then
  export ARCHFLAGS="-Wno-error=unused-command-line-argument-hard-error-in-future"
fi
#}}}

#{{{ PS1
# get current working directory (truncated to two dirs)
function cwd() {
  if $(which ruby > /dev/null); then
    echo $(pwd | ruby -ne 'puts $_.sub(ENV["HOME"], "~").split("/").last(2).join("/")')
  else
    echo $(pwd)
  fi
}

source ~/.bashrc.d/colors.sh
source ~/.bashrc.d/git-prompt.sh

if $(which git > /dev/null); then
  GIT_PS1_SHOWDIRTYSTATE=1
  GIT_PS1_SHOWSTASHSTATE=1
  GIT_PS1_SHOWUNTRACKEDFILES=1
  GIT_PS1_SHOWUPSTREAM='auto'
  GIT_PS1_SHOWCOLORHINTS=1

  BEFORE_GIT_PROMPT="$Yellow\`cwd\`$Color_Off"
  PROMPT_COLOR=$Green
  if [ $UID -eq 0 ]; then
    PROMPT_COLOR=$Red
  fi
  AFTER_GIT_PROMPT=" $PROMPT_COLOR\\\\$ $Color_Off "
  export PROMPT_COMMAND="__git_ps1 \"$BEFORE_GIT_PROMPT\" \"$AFTER_GIT_PROMPT\""
else
  export PS1="\`cwd\` \\$ "
fi
#}}}

#{{{ Aliases
# Core
alias ls="ls -F --group-directories-first --color=auto"
alias ll="ls -lh"
alias la="ll -A"

# Git
which hub > /dev/null && alias git="hub"

# Bundler
alias bi="bundle install"
alias be="bundle exec"

# nvim
alias vim="which nvim > /dev/null && nvim || vim"

if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
  # Automatically switch to a virtualenv if it is installed
  # and the directory contains a .venv file.
  check_virtualenv() {
    if [ -e .venv ]; then
      local env=`cat .venv`

      if [ "$env" != "${VIRTUAL_ENV##*/}" ]; then
        echo "Switching to venv ${env}"
        workon $env
      fi
    fi
  }

  venv_cd() {
    builtin cd "$@" && check_virtualenv
  }

  check_virtualenv
  alias cd="venv_cd"
fi
#}}}

#{{{ Includes
# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
which rbenv > /dev/null && eval "$(rbenv init -)"

# nvm
export NVM_DIR=~/.nvm
[ -f $BREW_PREFIX/opt/nvm/nvm.sh ] && source $BREW_PREFIX/opt/nvm/nvm.sh

# virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/projects
[ -f /usr/local/bin/virtualenvwrapper.sh ] && source /usr/local/bin/virtualenvwrapper.sh
#}}}

#{{{ SSH
add_key() {
  [ -f $1 ] && ssh-add $1 2> /dev/null
}

add_key ~/.ssh/id_rsa
add_key ~/.ssh/wine4me_bitbucket.pem
#}}}

# vim: set fdm=marker ft=sh:
