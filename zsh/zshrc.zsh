# Path to your oh-my-zsh configuration.
ZSH=DOTFILES_DIR/zsh/oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="zack"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git node npm)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

#ssh keymanager
if [ "$PS1" ]; then
  if [ -e /usr/bin/keychain ]; then
    keychain ~/.ssh/id_rsa
    if [ -e ~/.ssh-agent-${HOSTNAME} ]; then
      . ~/.ssh-agent-${HOSTNAME}
    fi
    if [ -e ~/.keychain/${HOSTNAME}-sh ]; then
      . ~/.keychain/${HOSTNAME}-sh
    fi
  fi
fi

export P4CONFIG=.p4config
export P4DIFF="diff -du"
