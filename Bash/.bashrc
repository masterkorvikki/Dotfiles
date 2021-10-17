#############
## Aliases ##
#############

source ~/.bash_aliases

#############
## Exports ##
#############

# Adding colors to grep

export GREP_OPTIONS='-—color=auto'

# Set emacs as my default editor
if [[ $(uname) == "Darwin" ]]; then
    alias emacs="/Applications/Emacs.app/Contents/MacOS/Emacs"
    alias emacsclient="/Applications/Emacs.app/Contents/MacOS/bin/emacsclient -a /Applications/Emacs.app/Contents/MacOS/Emacs $@ "
    alias daemon="/Applications/Emacs.app/Contents/MacOS/Emacs --daemon"
    export EDITOR="/Applications/Emacs.app/Contents/MacOS/Emacs"
else
    alias daemon="emacs --daemon"
    export EDITOR="emacs"
fi

# getting proper colors 

export TERM="xterm-256color"

###############
## Functions ##
###############

# Go up a number of directories I input

up() {
    if [ -z "$1" ]
    then
        GO_UP=1 # default go up one
    else
        GO_UP="$1"
    fi

    NEW_DIR=""

    for i in `seq 1 $GO_UP`;
    do
	NEW_DIR="$NEW_DIR"'../'
    done

    cd $NEW_DIR
    pwd # print final directory
}

# Open a man page in the Skim pdf reader using PostScript format

manp() {
    man -t "${1}" | open -f -a Skim
}

# Make a directory and cd into it

mkcd ()
{
  mkdir -p -- "$1" && cd -P -- "$1"
}

##############
## Niceties ##
##############

# Adding autocomplete

set show-all-if-ambiguous on
set completion-ignore-case on
set menu-complete-display-prefix on
set colored-completion-prefix on
if [ -z $INSIDE_EMACS ]
   then
   bind '\C-i:menu-complete'
   bind '"\e[Z":menu-complete-backward'
   bind '\C-j:complete'
   
   # Cycle through history based on characters already typed on the line
   
   bind '"\er":history-search-backward'
   bind '"\es":history-search-forward'
fi

# Disable START/STOP characters

stty -ixon

# Large history

HISTSIZE=1000000
HISTFILESIZE=1000000

# Making pyenv do the work of giving me the right Python version

if command -v pyenv 1>/dev/null 2>&1; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init --path)"
fi

# Shopt options

shopt -s autocd
shopt -s dirspell

############
## Prompt ##
############

# Credit to /u/cpbills from /r/linux for the git status and the exit status parts
# url: https://www.reddit.com/r/linux/comments/2uf5uu/this_is_my_bash_prompt_which_is_your_favorite/co8zgso/?context=8&depth=9

_show_git_status() {
  # Get the current git branch and colorize to indicate branch state
  # branch_name+ indicates there are stash(es)
  # branch_name? indicates there are untracked files
  # branch_name! indicates your branches have diverged
  local unknown untracked stash clean ahead behind staged dirty diverged
  unknown='0;34'      # blue
  untracked='0;32'    # green
  stash='0;32'        # green
  clean='0;32'        # green
  ahead='0;33'        # yellow
  behind='0;33'       # yellow
  staged='0;96'       # cyan
  dirty='0;31'        # red
  diverged='0;31'     # red

  if [[ $TERM = *256color ]]; then
    unknown='38;5;20'     # dark blue
    untracked='38;5;76'   # mid lime-green
    stash='38;5;76'       # mid lime-green
    clean='38;5;82'       # brighter green
    ahead='38;5;226'      # bright yellow
    behind='38;5;142'     # darker yellow-orange
    staged='38;5;214'     # orangey yellow
    dirty='38;5;202'      # orange
    diverged='38;5;196'   # red
  fi

  branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  if [[ -n "$branch" ]]; then
    git_status=$(git status 2> /dev/null)
    # If nothing changes the color, we can spot unhandled cases.
    color=$unknown
    if [[ $git_status =~ 'Untracked files' ]]; then
      color=$untracked
      branch="${branch}?"
    fi
    if git stash show &>/dev/null; then
      color=$stash
      branch="${branch}+"
    fi
    if [[ $git_status =~ 'working directory clean' ]]; then
      color=$clean
    fi
    if [[ $git_status =~ 'Your branch is ahead' ]]; then
      color=$ahead
      branch="${branch}>"
    fi
    if [[ $git_status =~ 'Your branch is behind' ]]; then
      color=$behind
      branch="${branch}<"
    fi
    if [[ $git_status =~ 'Changes to be committed' ]]; then
	color=$staged
    fi
    if [[ $git_status =~ 'Changed but not updated' ||
              $git_status =~ 'Changes not staged'      ||
              $git_status =~ 'Unmerged paths' ]]; then
	color=$dirty
    fi
    if [[ $git_status =~ 'Your branch'.+diverged ]]; then
	color=$diverged
	branch="${branch}!"
    fi
    echo -n "\[\033[${color}m\]${branch}\[\033[0m\]"
  fi
  return 0
}

_show_last_exit_status() {
    # Display the exit status of the last run command
    exit_status=$?
    if [[ "$exit_status" -ne 0 ]]; then
	echo "Exit $exit_status"
    fi
}

_color_my_directories() {
    # Color directories according to my personal preferences
    local dcolor
    dcolor="$(basename "$(pwd)")"
    if [[ $(pwd) =~ 'Math' ]]; then
	dcolor="\[\e[1;31m\]$(basename "$(pwd)")\[\e[m\]"
    elif [[ $(pwd) =~ 'English' ]]; then
	dcolor="\[\e[0;34m\]$(basename "$(pwd)")\[\e[m\]"
    elif [[ $(pwd) =~ 'Class' ]]; then
	dcolor="\[\e[33m\]$(basename "$(pwd)")\[\e[m\]"
    elif [[ $(pwd) =~ 'Anarchis' ||
		$(pwd) =~ 'Communis' ]] ; then
	dcolor="\[\033[38;5;196m\]$(basename "$(pwd)")\[\033[0m\]"
    elif [[ $(pwd) =~ 'Philosophy' ]]; then
	dcolor="\[\033[38;5;20m\]$(basename "$(pwd)")\[\033[0m\]"
    elif [[ $(pwd) =~ '.dotfiles' ]]; then
	dcolor="\[\e[35m\]$(basename "$(pwd)")\[\033[0m\]" 
    elif [[ $(pwd) = $HOME ]]; then
 	dcolor="\[\e[1;36m\]~\[\e[m\]"
    fi
    echo $dcolor
}

_build_prompt() {
    local git_status username colored_dir
    git_status=$(_show_git_status)
    if [[ -n "$git_status" ]]; then
	git_status=":${git_status}"
    fi
    username=""
    if [[ $(whoami) =~ 'alice' ]]; then
	username="\[\e[36m\]$(whoami)\[\e[m\]"
    elif [[ $(whoami) =~ 'root' ]]; then
	username="\[\e[31m\]$(whoami)\[\e[m\]"
    else
	username="$(whoami)"
    fi
    colored_dir=$(_color_my_directories)
    PS1="${username}\[\e[36m\][\[\e[m\]${colored_dir}${git_status}\[\e[36m\]]\[\e[m\]\\\$ "
  return 0
}

PROMPT_COMMAND="_show_last_exit_status; _build_prompt;"

PS2='> '
