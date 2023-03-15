local map = vim.api.nvim_set_keymap

map('n', '<M-n>', ':bnext<CR>', { noremap = true, silent = true })
map('n', '<M-b>', ':bprevious<CR>', { noremap = true, silent = true })
map('n', 'xx', ':noh<CR>', { noremap = true, silent = true })
map('n', 'ss', '<kMultiply>', { noremap = true, silent = true })
-- map('t', '<A-w>', '<C-\\><C-n>')

-- map('n', 'gr', ':Telescope lsp_references<CR>')
