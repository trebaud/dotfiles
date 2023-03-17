local map = vim.api.nvim_set_keymap

map('n', '<M-n>', ':bnext<CR>', { noremap = true, silent = true })
map('n', '<M-b>', ':bprevious<CR>', { noremap = true, silent = true })
map('n', 'xx', ':noh<CR>', { noremap = true, silent = true })
map('n', 'ss', '<kMultiply>', { noremap = true, silent = true })

if vim.g.neovide == true then
  map("n", "<C-+>", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>", { silent = true })
  map("n", "<C-->", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>", { silent = true })
  map("n", "<C-0>", ":lua vim.g.neovide_scale_factor = 1<CR>", { silent = true })
end
-- map('t', '<A-w>', '<C-\\><C-n>')

-- map('n', 'gr', ':Telescope lsp_references<CR>', { noremap = true, silent = true })
