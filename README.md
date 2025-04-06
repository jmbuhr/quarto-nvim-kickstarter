# Neovim Config

> [!IMPORTANT]
> The ecosystem around Neovim has changed in such a way that there are on one hand better batteries-included configs – such as LazyVim (https://www.lazyvim.org/) – and on the other hand better starting points that go through making your own config step by step – such as kickstart.nvim (https://github.com/nvim-lua/kickstart.nvim) – that I would recommend for different types of newcomers instead of using this repo as is. As such I'm changing the name from `quarto-nvim-kickstarter` to just my `nvim-config`, because it is most sustainable for this to be the place where I publicly (and recklessly) experiment with my own config and people can can take inspiration from that for their own. And only when I find something to be of general use for more people I incorporate it into one of my plugins (or it's own plugin).

## Plugins written by me

If you are a user of one or multiple of my plugins (listed below),
you might benefit from my config in this repo to see how I personally use them.

- <https://github.com/quarto-dev/quarto-nvim>
- <https://github.com/jmbuhr/otter.nvim>
- <https://github.com/jmbuhr/cmp-pandoc-references>
- <https://github.com/jmbuhr/telescope-zotero.nvim>

## Videos

You might also benefit from seing this config (or older versions of it) in action.

https://youtube.com/playlist?list=PLabWm-zCaD1axcMGvf7wFxJz8FZmyHSJ7

## Setup

Clone this repo into `~/.config/nvim/` or copy-paste just the parts you like.

This configuration can make use of a "Nerd Font" for icons and symbols.
Download one here: <https://www.nerdfonts.com/> and set it as your terminal font.

For displaying images in your terminal a recent version of [kitty](https://sw.kovidgoyal.net/kitty/) or [wezterm](https://wezfurlong.org/wezterm/index.html) is required
as well as the dependecies of [image.nvim](https://github.com/3rd/image.nvim) (see `./lua/plugins/ui.lua`).
Additionally, if you plan to use this through [tmux](https://github.com/tmux/tmux) make sure to have version >= 3.3a.

If you are unable to install those in your enviroment, disable the plugin by setting `enabled = false`.

Example dependencies install on ubuntu-based systems:

```bash
sudo apt install imagemagick
sudo apt install libmagickwand-dev
sudo apt install liblua5.1-0-dev
sudo apt install luajit
sudo apt install tree-sitter-cli
```

Manually installing luarocks and the magick rock is no longer required, this is handled by [luarocks.nvim](https://github.com/vhyrro/luarocks.nvim).

> [!NOTE] Do this before opening nvim, otherwise `luarocks.nvim`
> might pick up the wrong luarocks version.
> If you forgot this step, you can do `:Lazy build luarocks.nvim` again manually after installation
> to fix it.

