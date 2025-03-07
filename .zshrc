# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# Path to your oh-my-zsh installation.
export ZSH="/Users/hubertdeng/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"
POWERLEVEL9K_MODE='nerdfont-complete'
GITSTATUS_LOG_LEVEL=DEBUG

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git 
	zsh-syntax-highlighting 
	zsh-autosuggestions 
	docker 
	docker-compose
)	

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"
export PATH=/opt/homebrew/bin:$PATH

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"
export DOCKER_BUILDKIT=0

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


### iTerm2 settings
# Profiles -> Keys -> alt + ->/<- : select escape sequence, in text box add f/b
# Profiles -> Keys -> Left Option key from Normal -> Esc+
# Keys -> Navigation Shortcuts -> alt/cmd + number for tab/pane navigation
# Appearance -> Theme, Dark
# Appearance -> Tabs, check Show tab bar when only one tab, uncheck stretch tabs to fill bar, show tab bar in fullscreen

### Terminal session badge, iTerm2 only
badge() {
	printf "\e]1337;SetBadgeFormat=%s\a" $(echo -n "$1" | base64)
}


### Sublime
alias subl='open -a "Sublime Text"'
alias zp='subl ~/.zshrc'
alias sublzp='subl ~/.zshrc'

# Git and misc

alias gs='git status'
alias gb='git branch'
alias gp='git push'
alias gpu='git push -u'
alias gd='git diff'
alias master='git checkout master'
alias pull='git pull'
alias la='ls -la'
alias ll='ls -la'
alias vizp='vi ~/.zshrc'
alias szp='source ~/.zshrc'

# Docker
alias kd='docker kill $(docker ps -q) && docker rm $(docker ps -a -f status=exited -q)'
alias dps='docker ps --format "table {{.Image}}\t{{.Names}}\t{{.Status}}"'
alias dpp='docker ps --format "table {{.Names}}\t{{.Ports}}"'


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

eval "$(direnv hook zsh)"


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/hubertdeng/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/hubertdeng/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/hubertdeng/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/hubertdeng/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
export SENTRY_INSTRUMENTATION=1
export SENTRY_POST_MERGE_AUTO_UPDATE=1
export SENTRY_USE_COLIMA=1
export SENTRY_SPA_DSN=https://863de587a34a48c4a4ef1a9238fdb0b1@o19635.ingest.sentry.io/5270453
export VOLTA_HOME="$HOME/.volta"
grep --silent "$VOLTA_HOME/bin" <<< $PATH || export PATH="$VOLTA_HOME/bin:$PATH"

export C_INCLUDE_PATH=/opt/homebrew/Cellar/librdkafka/1.9.2/include


export PATH="/Users/hubertdeng/.local/bin:/Users/hubertdeng/.local/share/sentry-devenv/bin:$PATH"

. "$HOME/.cargo/env"

# Created by `pipx` on 2024-09-19 18:14:55
export PATH="$PATH:/Users/hubertdeng/.local/bin"
