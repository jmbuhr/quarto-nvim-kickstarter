# Quarto Nvim Kickstarter

Companion to <https://github.com/quarto-dev/quarto-nvim>.

This requires Neovim >= **v0.9.0** (https://github.com/neovim/neovim/releases/tag/stable)

## Videos

Check out this playlist for a full guide and walkthrough:
https://youtube.com/playlist?list=PLabWm-zCaD1axcMGvf7wFxJz8FZmyHSJ7

## Setup

Clone this repo into `~/.config/nvim/` or copy-paste just the parts you like.

If you already have your own configuration, check out `lua/plugins/quarto.lua`
for the configuration of all plugins directly relevant to your Quarto experience.

This configuration can make use of a "Nerd Font" for icons and symbols.
Download one here: <https://www.nerdfonts.com/> and set it as your terminal font.

### Unix, Linux Installation

```bash
git clone https://github.com/jmbuhr/quarto-nvim-kickstarter.git ~/.config/nvim
```

### Windows Powershell Installation

```bash
git clone https://github.com/jmbuhr/quarto-nvim-kickstarter.git "$env:LOCALAPPDATA\nvim"
```

The telescope file finder uses `fzf` for fuzzy finding via the [telescope-fzf-native](https://github.com/nvim-telescope/telescope-fzf-native.nvim) extension.
It will automatically install `fzf`, but needs some requirements which are not pre-installed on Windows.
Check out the previous link for those (or comment out the extension in `./lua/plugins/ui.lua`).

Now you are good to go!

## Updating

Certain updates to plugins may leave behind unused plugin data. If this configuration produces an error on startup, try removing those first, allowing the lazy.nvim package manager to recreate the correct plugin structure:

```bash
rm -r ~/.local/share/nvim
rm -r ~/.local/state/nvim
```

## Screenshots

![image](https://user-images.githubusercontent.com/17450586/210392216-a99815ac-1872-4c48-bf24-5a50df14c6d2.png)
![image](https://user-images.githubusercontent.com/17450586/210392419-3ee2b3e3-e805-4e36-99ab-6922abe3a66b.png)
![image](https://user-images.githubusercontent.com/17450586/210392573-57c0ad1c-5db0-4f2a-9119-608bd2398494.png)
![image](https://user-images.githubusercontent.com/17450586/210392838-1c643a65-e792-4a54-bbdb-3ae959995a79.png)

Use the integrated neovim terminal to execute code chunks:

![image](https://user-images.githubusercontent.com/17450586/211403680-c60e8e89-ea9b-48bd-881d-37df2bc924a3.png)

Or combine it with [tmux-kickstarter](https://github.com/jmbuhr/tmux-kickstarter) for an even more versatile data science experience!

![image](https://user-images.githubusercontent.com/17450586/210393754-04404e62-15ab-4cb2-afba-deeefc3fec9e.png)

## Links to the plugins

Some of the plugins included are:

- <https://github.com/folke/lazy.nvim>
- <https://github.com/jpalardy/vim-slime>
- <https://github.com/neovim/nvim-lspconfig>
- <https://github.com/nvim-treesitter/nvim-treesitter>
- <https://github.com/hrsh7th/nvim-cmp>
  - <https://github.com/hrsh7th/cmp-nvim-lsp>
  - <https://github.com/hrsh7th/cmp-buffer>
  - <https://github.com/hrsh7th/cmp-path>
  - <https://github.com/hrsh7th/cmp-calc>
  - <https://github.com/hrsh7th/cmp-emoji>
  - <https://github.com/f3fora/cmp-spell>
  - <https://github.com/kdheepak/cmp-latex-symbols>
  - <https://github.com/jc-doyle/cmp-pandoc-references>
- <https://github.com/L3MON4D3/LuaSnip>
  - <https://github.com/saadparwaiz1/cmp_luasnip>
  - <https://github.com/rafamadriz/friendly-snippets>
