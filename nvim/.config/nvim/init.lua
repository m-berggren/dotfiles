-- indentation settings
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.softtabstop = 4

vim.opt.mouse = "a"
vim.opt.mousemodel = "popup_setpos"
vim.opt.mousemoveevent = true
vim.opt.mousescroll = "ver:3,hor:3"

-- bootstrap lazy.vim, LazyVim and your plugins
require("config.lazy")
