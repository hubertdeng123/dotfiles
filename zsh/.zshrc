# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ---------- Oh My Zsh ----------
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
POWERLEVEL9K_MODE='nerdfont-complete'

plugins=(
	git
	zsh-syntax-highlighting
	zsh-autosuggestions
	docker
	docker-compose
)

source "$ZSH/oh-my-zsh.sh"

# ---------- PATH ----------
export PATH="/opt/homebrew/bin:$PATH"
export PATH="$HOME/.local/bin:$HOME/.local/share/sentry-devenv/bin:$PATH"
export PATH="$HOME/.local/share/sentry-devtools/bin:$PATH"

export VOLTA_HOME="$HOME/.volta"
grep --silent "$VOLTA_HOME/bin" <<< $PATH || export PATH="$VOLTA_HOME/bin:$PATH"

# ---------- Environment ----------
export EDITOR='vim'
export DOCKER_BUILDKIT=1
export SENTRY_INSTRUMENTATION=1
export SENTRY_POST_MERGE_AUTO_UPDATE=1
export SENTRY_USE_COLIMA=1
export SENTRY_SPA_DSN=https://863de587a34a48c4a4ef1a9238fdb0b1@o19635.ingest.sentry.io/5270453

# librdkafka headers (use brew prefix for version resilience)
if command -v brew &>/dev/null; then
  _rdkafka_prefix="$(brew --prefix librdkafka 2>/dev/null)"
  [[ -n "$_rdkafka_prefix" ]] && export C_INCLUDE_PATH="$_rdkafka_prefix/include"
  unset _rdkafka_prefix
fi

# ---------- History ----------
HISTSIZE=50000
SAVEHIST=50000
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY

# ---------- Aliases ----------
# Git
alias gs='git status'
alias gb='git branch'
alias gp='git push'
alias gpu='git push -u'
alias gd='git diff'
alias main='git checkout main 2>/dev/null || git checkout master'
alias pull='git pull'

# Files
alias la='ls -la'

# Docker
alias kd='docker kill $(docker ps -q) && docker rm $(docker ps -a -f status=exited -q)'
alias dps='docker ps --format "table {{.Image}}\t{{.Names}}\t{{.Status}}"'
alias dpp='docker ps --format "table {{.Names}}\t{{.Ports}}"'

# Shell config
alias vizp='vi ~/.zshrc'
alias szp='source ~/.zshrc'

# ---------- iTerm2 badge ----------
badge() {
	printf "\e]1337;SetBadgeFormat=%s\a" $(echo -n "$1" | base64)
}

# ---------- Integrations ----------
eval "$(direnv hook zsh)"

# Google Cloud SDK
if [ -f "$HOME/Downloads/google-cloud-sdk/path.zsh.inc" ]; then
  source "$HOME/Downloads/google-cloud-sdk/path.zsh.inc"
fi
if [ -f "$HOME/Downloads/google-cloud-sdk/completion.zsh.inc" ]; then
  source "$HOME/Downloads/google-cloud-sdk/completion.zsh.inc"
fi

# Lazy load NVM (faster shell startup)
export NVM_DIR="$HOME/.nvm"
_nvm_lazy_load() {
  unset -f nvm node npm npx
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
}
nvm()  { _nvm_lazy_load; nvm "$@"; }
node() { _nvm_lazy_load; node "$@"; }
npm()  { _nvm_lazy_load; npm "$@"; }
npx()  { _nvm_lazy_load; npx "$@"; }

# Powerlevel10k config
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
