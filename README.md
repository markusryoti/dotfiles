# Dotfiles

Neovim, Tmux

## Add to new machine

```bash
# 1. Clone as a bare repo
git clone --bare git@github.com:you/dotfiles.git ~/.dotfiles

# 2. Define the alias temporarily
alias dot='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

# 3. Check out — this places all tracked files into $HOME
dot checkout

# 4. Suppress untracked file noise
dot config --local status.showUntrackedFiles no

# 5. Add the alias permanently to your shell rc
echo "alias dot='git --git-dir=\$HOME/.dotfiles --work-tree=\$HOME'" >> ~/.zshrc
```

## k9s

Skin: [skin](https://github.com/catppuccin/k9s)
