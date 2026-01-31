# Enable persistent history
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_SAVE_NO_DUPS
setopt HIST_IGNORE_SPACE

# Configure the push directory stack (most people don't need this)
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT

# Emacs keybindings
bindkey -e
# Enable Ctrl+arrow key bindings for word jumping
bindkey '^[[1;5C' forward-word   # Ctrl+right arrow
bindkey '^[[1;5D' backward-word  # Ctrl+left arrow

# Use the up and down keys to navigate the history
#bindkey "\e[A" history-beginning-search-backward
#bindkey "\e[B" history-beginning-search-forward

# Move to directories without cd
setopt autocd

# Initialize completion
autoload -U compinit; compinit

# Function run before every prompt (when the terminal is idle)
function set_title_precmd() {
    # %n = username, %m = hostname, %~ = current directory (with ~ replacement)
    # \e]0;... \a is the escape sequence to set the window title
    print -Pn "\e]0;%n@%m: %~\a"
}

# Function run before executing a command
function set_title_preexec() {
    # $1 is the full command line string
    # We take the first word (the command name) to keep it short,
    # but you can use "$1" if you want the full command with arguments.
    local cmd_name=${1[(w)1]}

    # Set title to: command_name (username@hostname: directory)
    print -Pn "\e]0;$cmd_name (%n@%m: %~)\a"
}

# Register the functions to the zsh hooks
autoload -Uz add-zsh-hook
add-zsh-hook precmd set_title_precmd
add-zsh-hook preexec set_title_preexec

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

find_files="fdfind --type f --hidden --strip-cwd-prefix --follow --exclude .git --color=always"
find_directories="fdfind --type d --hidden --strip-cwd-prefix --follow --exclude .git --color=always"
export FZF_DEFAULT_COMMAND="$find_files"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$find_directories"
export FZF_CTRL_R_OPTS="--exact"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  eval "$find_files" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  eval "$find_directories" . "$1"
}

export FZF_DEFAULT_OPTS='--ansi'
show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else batcat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

rfv() (
  RELOAD='reload:rg --column --color=always --smart-case {q} || :'
  OPENER='if [[ $FZF_SELECT_COUNT -eq 0 ]]; then
            nvim {1} +{2}     # No selection. Open the current line in Vim.
          else
            nvim +cw -q {+f}  # Build quickfix list for the selected items.
          fi'
  fzf --disabled --ansi --multi \
      --bind "start:$RELOAD" --bind "change:$RELOAD" \
      --bind "enter:become:$OPENER" \
      --bind "ctrl-o:execute:$OPENER" \
      --bind 'alt-a:select-all,alt-d:deselect-all,ctrl-/:toggle-preview' \
      --delimiter : \
      --preview 'batcat --style=full --color=always --highlight-line {2} {1}' \
      --preview-window '~4,+{2}+4/3,<80(up)' \
      --query "$*"
)



rf() (
  RELOAD='reload:rg --column --color=always --smart-case {q} || :'
  fzf --disabled --ansi --multi \
      --bind "start:$RELOAD" --bind "change:$RELOAD" \
      --bind 'alt-a:select-all,alt-d:deselect-all,ctrl-/:toggle-preview' \
      --delimiter : \
      --preview 'batcat --style=full --color=always --highlight-line {2} {1}' \
      --preview-window '~4,+{2}+4/3,<80(up)' \
      --query "$*"
)

export EDITOR="nvim"

# Set up zoxide to move between folders efficiently
eval "$(zoxide init zsh)"

# Set up the Starship prompt
eval "$(starship init zsh)"

export BAT_THEME="Dracula"

eval $(keychain --eval --agents ssh id_rsa id_ed25519)

# The most important aliases
alias bat='batcat'
alias cd='z'
alias fd='fdfind'
alias grep='grep --color'
alias ls='eza -F -gh --icons --group-directories-first --hyperlink'
alias lsg='eza -F -gh --icons --group-directories-first --hyperlink --git'
alias ll='ls -l'
alias la='ls -a'
alias l='la -a -l'
alias tree='eza --tree'
alias vmwk='uv run --project /home/zack/src/vcf/vmwk/ /home/zack/src/vcf/vmwk/vmwk.py'


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

rfe() (
  emulate -L zsh
  setopt pipefail

  # 1. Auto-detect bat or batcat (Ubuntu uses batcat)
  local batcmd=${commands[batcat]:-bat}

  # 2. Define the Ripgrep command (sorted by path for stability)
  local rg_cmd="rg --vimgrep --color=always --smart-case --sort path"

  # 3. The Opener Logic
  # We run this inside `zsh -c`. It iterates over "$@" (the selected lines from fzf).
  # We strip the quotes from the definition to pass it cleanly into the fzf bind.
  local opener_script='
    local -a args
    for line in "$@"; do
      # Parse string "file:line:col:text" into variables
      IFS=: read -r file lnum col rest <<< "$line"

      # Validate that we actually have a file and numbers
      if [[ -n "$file" && "$lnum" == <-> && "$col" == <-> ]]; then
        # Safety: Prefix filenames starting with "-"
        [[ "$file" == -* ]] && file="./$file"
        # Build the emacsclient args: +line:col filename
        args+=( "+${lnum}:${col}" "$file" )
      fi
    done

    # Execute emacsclient if we have valid arguments
    if (( ${#args} )); then
      emacsclient -n -c -a "" "${args[@]}"
    fi
  '

  # 4. Run FZF
  # We use `zsh -c "script" -- {+}`.
  # {+} expands to the selected lines (quoted), which become $1, $2, etc. in the script.
  fzf --disabled --ansi --multi --layout=reverse \
      --bind "start:reload:$rg_cmd {q} || :" \
      --bind "change:reload:$rg_cmd {q} || :" \
      --bind "enter:become(zsh -c '$opener_script' -- {+})" \
      --bind "ctrl-o:execute(zsh -c '$opener_script' -- {+})" \
      --bind 'alt-a:select-all,alt-d:deselect-all,ctrl-/:toggle-preview' \
      --delimiter : \
      --preview "$batcmd --style=full --color=always --highlight-line {2} {1}" \
      --preview-window '~4,+{2}+4/3,<80(up)' \
      --query "$*"
)

source ~/src/dotfiles/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
