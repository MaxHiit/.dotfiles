# Entry point — load all zsh config files
source ~/.config/zsh/rc

# bun completions
[ -s "/Users/pirrex/.bun/_bun" ] && source "/Users/pirrex/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Vite+ bin (https://viteplus.dev)
. "$HOME/.vite-plus/env"
