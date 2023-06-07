# Changelog

## [0.14.1](https://github.com/jmbuhr/quarto-nvim-kickstarter/compare/v0.14.0...v0.14.1) (2023-06-07)


### Bug Fixes

* properly use vim slime ipython pause ([378b376](https://github.com/jmbuhr/quarto-nvim-kickstarter/commit/378b3761a74480d6fe05fd5bc83609d38670e49b))

## [0.14.0](https://github.com/jmbuhr/quarto-nvim-kickstarter/compare/v0.13.0...v0.14.0) (2023-06-06)


### Features

* revert to only completing curly code chunks, but also add html ([fa372b6](https://github.com/jmbuhr/quarto-nvim-kickstarter/commit/fa372b68dded03e08735a0c7786c62110c6b91a1))

## [0.13.0](https://github.com/jmbuhr/quarto-nvim-kickstarter/compare/v0.12.0...v0.13.0) (2023-06-05)


### Features

* enable completion for all chunks by default ([15023f2](https://github.com/jmbuhr/quarto-nvim-kickstarter/commit/15023f25b68930db951e15f478d0082ccfb2ce72))


### Bug Fixes

* remove (deprecated?) vim-slime option ([896c432](https://github.com/jmbuhr/quarto-nvim-kickstarter/commit/896c432ba0ad5676bf36c918f050f9193a87586b))
* respect .ignore file for finding files ([1bf09f2](https://github.com/jmbuhr/quarto-nvim-kickstarter/commit/1bf09f2e9d16c0c398d7bebb4b5965b15fe2e98c))

## [0.12.0](https://github.com/jmbuhr/quarto-nvim-kickstarter/compare/v0.11.0...v0.12.0) (2023-06-03)


### Features

* add leap.nvim ([ef6fdde](https://github.com/jmbuhr/quarto-nvim-kickstarter/commit/ef6fdde2c011d7703bc7e345c4cf1d5f5cf9887d))


### Performance Improvements

* disable slower plugins by default ([7912423](https://github.com/jmbuhr/quarto-nvim-kickstarter/commit/7912423229bc360b1673b65e3743397a85200103))

## [0.11.0](https://github.com/jmbuhr/quarto-nvim-kickstarter/compare/v0.10.0...v0.11.0) (2023-05-26)


### Features

* set up keymap for rename and references in qmd ([4ce8272](https://github.com/jmbuhr/quarto-nvim-kickstarter/commit/4ce8272e8bd9a6f6dccf96ebf5e09306e5855fda))


### Bug Fixes

* overwrite less markdown queries ([2594395](https://github.com/jmbuhr/quarto-nvim-kickstarter/commit/2594395789a7e4080ff8e4381aa6a53de8a79f3e))
* **r:** disable rich documentation (=&gt; pure markdown) ([9ed4a37](https://github.com/jmbuhr/quarto-nvim-kickstarter/commit/9ed4a3734ffbaeb17bd9948ff26dc2e2fd1558bf))
* resume showing gitignored files for find files ([102fdf3](https://github.com/jmbuhr/quarto-nvim-kickstarter/commit/102fdf3a1140729b382a3b7950604b8270b795e7))

## [0.10.0](https://github.com/jmbuhr/quarto-nvim-kickstarter/compare/v0.9.1...v0.10.0) (2023-05-05)


### Features

* make pyright less hungry ([57b1d7b](https://github.com/jmbuhr/quarto-nvim-kickstarter/commit/57b1d7b702ece0a32af2143ced163da31134252f))

## [0.9.1](https://github.com/jmbuhr/quarto-nvim-kickstarter/compare/v0.9.0...v0.9.1) (2023-05-01)


### Bug Fixes

* more robust vim-slime cell delimiter detection ([fa7f21c](https://github.com/jmbuhr/quarto-nvim-kickstarter/commit/fa7f21c5ccd4ac9b1deb034851a9f7bf7f9115b2))

## [0.9.0](https://github.com/jmbuhr/quarto-nvim-kickstarter/compare/v0.8.1...v0.9.0) (2023-04-24)


### Features

* **opt:** ltex ([e17573d](https://github.com/jmbuhr/quarto-nvim-kickstarter/commit/e17573dfbc708918442b9b7b2015d501cff72029))

Thanks to @sondalex for the suggestion!

## [0.8.1](https://github.com/jmbuhr/quarto-nvim-kickstarter/compare/v0.8.0...v0.8.1) (2023-04-22)


### Bug Fixes

* add coj keybinding to insert julia code chunk ([64fdafd](https://github.com/jmbuhr/quarto-nvim-kickstarter/commit/64fdafde61a438f654f186c38f9f431fb0f778a2))

## [0.8.0](https://github.com/jmbuhr/quarto-nvim-kickstarter/compare/v0.7.0...v0.8.0) (2023-04-20)


### Features

* add &lt;leader&gt;qr keybindings to run code with vim-slime ([8959d0d](https://github.com/jmbuhr/quarto-nvim-kickstarter/commit/8959d0d4b468394ee901348d424a7e9d0d8d8e37))
* be less verbose ([9385099](https://github.com/jmbuhr/quarto-nvim-kickstarter/commit/93850996bbc58f74e29a276b3293c55fddc5d650))

## [0.7.0](https://github.com/jmbuhr/quarto-nvim-kickstarter/compare/v0.6.0...v0.7.0) (2023-04-20)


### Features

* add keybindings to add different code chunks ([f2cd9d6](https://github.com/jmbuhr/quarto-nvim-kickstarter/commit/f2cd9d619b7a6efdcaa04e939382df78f1b73b5c))
* re-introduce codechunk textobjects to jump to ([cb06ff7](https://github.com/jmbuhr/quarto-nvim-kickstarter/commit/cb06ff7e16b31ebcf26271905dd0c1e477e4d3f9))


### Bug Fixes

* don't autopair backticks ([5b0ed1f](https://github.com/jmbuhr/quarto-nvim-kickstarter/commit/5b0ed1f214fc7f160aaedda85d2bacb03686d990))

## [0.6.0](https://github.com/jmbuhr/quarto-nvim-kickstarter/compare/v0.5.0...v0.6.0) (2023-04-09)


### Features

* add kebinding to mark and switch between terminal targets ([d2492ef](https://github.com/jmbuhr/quarto-nvim-kickstarter/commit/d2492efa67779466fee95beb1c61b9ba899ce0d3))
* show optional features ([1487088](https://github.com/jmbuhr/quarto-nvim-kickstarter/commit/148708815987bf41e88f918a45eda64247db094b))
* use ipython cpaste when in python code chunk ([0756a76](https://github.com/jmbuhr/quarto-nvim-kickstarter/commit/0756a76273420edf78c9919ef9a58c180fd07f54))

## [0.5.0](https://github.com/jmbuhr/quarto-nvim-kickstarter/compare/v0.4.0...v0.5.0) (2023-03-28)


### Features

* spellchecking exceptions for links ([55b62ae](https://github.com/jmbuhr/quarto-nvim-kickstarter/commit/55b62ae3a7cff76b30cb1b3243c69aa023a6cb8d))

## [0.4.0](https://github.com/jmbuhr/quarto-nvim-kickstarter/compare/v0.3.1...v0.4.0) (2023-03-16)


### Features

* add bash language server ([96af1a1](https://github.com/jmbuhr/quarto-nvim-kickstarter/commit/96af1a13b97881d1b9334d5b3c7791c84c4b73b9))

## [0.3.1](https://github.com/jmbuhr/quarto-nvim-kickstarter/compare/v0.3.0...v0.3.1) (2023-03-11)


### Bug Fixes

* also add marksman config example ([126937d](https://github.com/jmbuhr/quarto-nvim-kickstarter/commit/126937dbc0770512142a5171c6f711c357adb4f3))

## [0.3.0](https://github.com/jmbuhr/quarto-nvim-kickstarter/compare/v0.2.0...v0.3.0) (2023-03-11)


### Features

* add ci with autorelease ([1d53ef5](https://github.com/jmbuhr/quarto-nvim-kickstarter/commit/1d53ef5d86b6dc5b1e9b3482483e9efc00cdaf74))
* add DAP configuration ([eb48da3](https://github.com/jmbuhr/quarto-nvim-kickstarter/commit/eb48da3b897b4bf885fa9f2d51fdd173a54ac8f2))
* ignore python .venv folder in telescope search ([071183a](https://github.com/jmbuhr/quarto-nvim-kickstarter/commit/071183a0bcdc3f095e7325d6d305e7e7f481f6d1))
* update plugins ([5af0945](https://github.com/jmbuhr/quarto-nvim-kickstarter/commit/5af094561492d0a6ff9cfb6613d9c200148c282c))
