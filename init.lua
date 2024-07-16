-- NOTE: Throughout this config, some plugins are
-- disabled by default. This is because I don't use
-- them on a daily basis, but I still want to keep
-- them around as examples.
-- You can enable them by changing `enabled = false`
-- to `enabled = true` in the respective plugin spec.
-- Some of these also have the
-- PERF: (performance) comment, which
-- indicates that I found them to slow down the config.
-- (may be outdated with newer versions of the plugins,
-- check for yourself if you're interested in using them)

require 'config.global'
require 'config.lazy'
require 'config.autocommands'
require 'config.redir'

vim.api.nvim_create_autocmd({ "BufReadPost" }, {
    desc = "Activate Otter on Buf Enter",
    pattern = "*.norg",
    group = vim.api.nvim_create_augroup("NorgOtter", {}),
    callback = function(_)
      require'otter'.activate()
    end,
})
