-- Based on bashbunni/dotfiles
local ok, catppuccin = pcall(require, "catppuccin")
if not ok then return end
vim.g.catppuccin_flavour = "frappe"
catppuccin.setup()
vim.cmd [[colorscheme catppuccin]]

require('me.options')
require('me.globals')
require('me.lualine')
require('me.keymap')
require('me.lsp')
require('me.telescope')
require('me.autocmds')
