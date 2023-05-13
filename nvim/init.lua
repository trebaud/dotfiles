local cmd = vim.cmd
local g = vim.g
local opt = vim.opt

g.mapleader = " "

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'tpope/vim-commentary'
  use 'mhartington/formatter.nvim'
  use 'neovim/nvim-lspconfig'
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-lua/popup.nvim'
  use 'lewis6991/gitsigns.nvim'
  use 'kyazdani42/nvim-web-devicons'
  use 'ryanoasis/vim-devicons'
  use 'kyazdani42/nvim-tree.lua'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/nvim-cmp'
  use 'David-Kunz/cmp-npm'
  use 'marko-cerovac/material.nvim'
  use 'saadparwaiz1/cmp_luasnip'
  use 'voldikss/vim-floaterm'
  use 'nvim-telescope/telescope-ui-select.nvim'
  use 'folke/tokyonight.nvim'
  use 'nvim-lualine/lualine.nvim'
  use 'akinsho/bufferline.nvim'
  use 'ellisonleao/gruvbox.nvim'
  use 'sainnhe/sonokai'
  use 'DanilaMihailov/beacon.nvim'
  use 'ggandor/leap.nvim'

  if packer_bootstrap then
    require('packer').sync()
  end
end
)

-- basic keymaps
vim.keymap.set('n', 'gq', ':bd!<CR>')
vim.keymap.set('n', '<leader>w', ':w<CR>')
vim.keymap.set('n', '<A-b>', ':bprev<CR>')
vim.keymap.set('n', '<A-n>', ':bnext<CR>')
vim.keymap.set('n', '<leader>k', ':noh<CR>')
vim.keymap.set('n', '<A-h>', '<C-w>h')
vim.keymap.set('n', '<A-j>', '<C-w>j')
vim.keymap.set('n', '<A-k>', '<C-w>k')
vim.keymap.set('n', '<A-l>', '<C-w>l')
vim.keymap.set('n', 'ss', '<kMultiply>', { noremap = true, silent = true })

-- copy / paste
vim.keymap.set('v', '<A-c>', '"+y')
vim.keymap.set('n', '<A-v>', '"+p')
vim.keymap.set('i', '<A-v>', '<c-r>+', { noremap = true })
vim.keymap.set('c', '<A-v>', '<c-r>+', { noremap = true })
vim.keymap.set('i', '<c-r>', '<c-v>', { noremap = true })

vim.wo.wrap = false
vim.wo.list = true

vim.keymap.set("v", "<leader>x", function()
  return ":w !sh >> %"
end, { expr = true })

-- default options
opt.completeopt = { 'menu', 'menuone', 'noselect' }
opt.laststatus = 3
opt.mouse = 'a'
opt.splitright = true
opt.splitbelow = true
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.number = true
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.cmdheight = 1
opt.signcolumn = 'yes'
opt.updatetime = 520
opt.undofile = true
cmd('filetype plugin on')
opt.backup = false
opt.guifont = "FiraCode Nerd Font:h16"
g.netrw_banner = false
g.netrw_liststyle = 3
g.markdown_fenced_languages = { 'javascript', 'js=javascript', 'json=javascript' }

-- neovide options
g.neovide_input_use_logo = "v:true"
g.neovide_remember_window_size = "v:true"
g.neovide_cursor_trail_length = 0
g.neovide_cursor_animation_length = 0
g.neovide_cursor_vfx_mode = "railgun"
g.neovide_window_floating_opacity = 0.85
g.neovide_floating_blur = 0.8
g.neovide_fullscreen = "v:true"

-- opt.path:append({ "**" })
vim.cmd([[set path=$PWD/**]])
vim.keymap.set('n', '<leader>v', ':e $MYVIMRC<CR>')

-- lualine
require("lualine").setup {}

-- bufferline
require("bufferline").setup {}


-- lewis6991/gitsigns.nvim
function diffThisBranch()
  local branch = vim.fn.input("Branch: ", "")
  require "gitsigns".diffthis(branch)
end

require('gitsigns').setup({
  current_line_blame = true,
  on_attach = function(bufnr)
    -- Navigation
    vim.keymap.set('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true })
    vim.keymap.set('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true })

    -- Actions
    vim.keymap.set('n', '<leader>hs', ':Gitsigns stage_hunk<CR>')
    vim.keymap.set('v', '<leader>hs', ':Gitsigns stage_hunk<CR>')
    vim.keymap.set('n', '<leader>hr', ':Gitsigns reset_hunk<CR>')
    vim.keymap.set('v', '<leader>hr', ':Gitsigns reset_hunk<CR>')
    vim.keymap.set('n', '<leader>hS', '<cmd>Gitsigns stage_buffer<CR>')
    vim.keymap.set('n', '<leader>hu', '<cmd>Gitsigns undo_stage_hunk<CR>')
    vim.keymap.set('n', '<leader>hR', '<cmd>Gitsigns reset_buffer<CR>')
    vim.keymap.set('n', '<leader>hp', '<cmd>Gitsigns preview_hunk<CR>')
    vim.keymap.set('n', '<leader>hb', function() require "gitsigns".blame_line { full = true } end)
    vim.keymap.set('n', '<leader>tb', '<cmd>Gitsigns toggle_current_line_blame<CR>')
    vim.keymap.set('n', '<leader>hd', '<cmd>Gitsigns diffthis<CR>')
    vim.keymap.set('n', '<leader>hD', function() require "gitsigns".diffthis("~") end)
    vim.keymap.set('n', '<leader>hm', function() require "gitsigns".diffthis("master") end)
    vim.keymap.set('n', '<leader>hM', diffThisBranch)
    vim.keymap.set('n', '<leader>td', '<cmd>Gitsigns toggle_deleted<CR>')

    -- Text object
    vim.keymap.set('o', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    vim.keymap.set('x', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
})

-- formatter
local format = require("formatter")

local prettier = function()
  return {
    exe = "prettier",
    args = { "--stdin-filepath", vim.fn.shellescape(vim.api.nvim_buf_get_name(0)), "--single-quote" },
    stdin = true,
  }
end

format.setup {
  logging = false,
  filetype = {
    css = { prettier },
    scss = { prettier },
    html = { prettier },
    javascript = { prettier },
    javascriptreact = { prettier },
    typescript = { prettier },
    typescriptreact = { prettier },
    markdown = { prettier },
    json = { prettier },
    jsonc = { prettier },
    rust = {
      function()
        return {
          exe = "rustfmt",
          stdin = true
        }
      end
    },
    lua = {
      -- stylua
      function()
        return {
          exe = "stylua",
          args = { "--config-path", "~/.config/.stylua.toml", "-" },
          stdin = true,
        }
      end,
    },
  },
}

-- format on save
vim.api.nvim_exec(
  [[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.js,*.jsx,*.ts,*.tsx,*.vue,*.html,*css,*json FormatWrite
augroup END
]],
  true
)

local telescope_actions = require("telescope.actions.set")

local fixfolds = {
  hidden = true,
  attach_mappings = function(_)
    telescope_actions.select:enhance({
      post = function()
        vim.cmd(":normal! zx")
      end,
    })
    return true
  end,
}

local actions = require("telescope.actions")

require('telescope').setup {
  pickers = {
    buffers = fixfolds,
    find_files = fixfolds,
    git_files = fixfolds,
    grep_string = fixfolds,
    live_grep = fixfolds,
    oldfiles = fixfolds,
  }
}

-- nvim-telescope/telescope.nvim
_G.telescope_find_files_in_path = function(path)
  local _path = path or vim.fn.input("Dir: ", "", "dir")
  require("telescope.builtin").find_files({ search_dirs = { _path } })
end
_G.telescope_live_grep_in_path = function(path)
  local _path = path or vim.fn.input("Dir: ", "", "dir")
  require("telescope.builtin").live_grep({ search_dirs = { _path } })
end
_G.telescope_files_or_git_files = function()
  local utils = require('telescope.utils')
  local builtin = require('telescope.builtin')
  local _, ret, _ = utils.get_os_command_output({ 'git', 'rev-parse', '--is-inside-work-tree' })
  if ret == 0 then
    builtin.git_files()
  else
    builtin.find_files()
  end
end

vim.keymap.set('n', '<leader>fD', function() telescope_live_grep_in_path() end)
vim.keymap.set('n', '<leader><space>', function() telescope_files_or_git_files() end)
vim.keymap.set('n', '<leader>fd', function() telescope_find_files_in_path() end)
vim.keymap.set('n', '<leader>ff', ':Telescope find_files<CR>')
vim.keymap.set('n', '<leader>fG', ':Telescope git_branches<CR>')
vim.keymap.set('n', '<leader>fg', ':Telescope git_bcommits<CR>')
vim.keymap.set('n', '<leader>fb', ':Telescope buffers<CR>')
vim.keymap.set('n', '<leader>fs', ':Telescope lsp_document_symbols<CR>')
vim.keymap.set('n', '<leader>fr', ':Telescope live_grep<CR>')
vim.keymap.set('n', '<leader>FF', ':Telescope grep_string<CR>')

-- David-Kunz/cmp-npm
require('cmp-npm').setup({ ignore = { "beta", "rc" } })

local nvim_lsp = require 'lspconfig'
local servers = { 'tsserver', 'rust_analyzer' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
  }
end

vim.keymap.set('n', 'gt', ':Telescope lsp_type_definitions<CR>')
vim.keymap.set('n', 'gr', ':Telescope lsp_references<CR>')
vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end)
vim.keymap.set('n', 'gh', function() vim.lsp.buf.hover() end)
vim.keymap.set('n', 'gD', function() vim.lsp.buf.implementation() end)
vim.keymap.set('n', '<c-k>', function() vim.lsp.buf.signature_help() end)
vim.keymap.set('n', 'gR', function() vim.lsp.buf.rename() end)
vim.keymap.set('n', 'ga', function() vim.lsp.buf.code_action() end)
vim.keymap.set('n', 'gA', ':Telescope lsp_range_code_actions<CR>')

vim.keymap.set('n', '<leader><esc><esc>', ':tabclose<CR>')

vim.g.material_style = "darker"
vim.cmd 'colorscheme material'

vim.g.floaterm_width = 0.95
vim.g.floaterm_height = 0.95
vim.keymap.set('n', '<leader>g', ':FloatermNew lazygit<CR>')
vim.keymap.set('n', '<leader>r', ':FloatermNew ranger<CR>')
vim.keymap.set('n', '<leader>t', ':FloatermNew top<CR>')

require 'nvim-treesitter.configs'.setup {
  ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'typescript', 'vim' },
  highlight = {
    enable = true,
  },
}

-- custom folder icon
require 'nvim-web-devicons'.setup({
  override = {
    lir_folder_icon = {
      icon = "",
      color = "#7ebae4",
      name = "LirFolderNode"
    },
  }
})
-- use visual mode
function _G.LirSettings()
  vim.api.nvim_buf_set_keymap(0, 'x', 'J', ':<C-u>lua require"lir.mark.actions".toggle_mark("v")<CR>',
    { noremap = true, silent = true })

  -- echo cwd
  vim.api.nvim_echo({ { vim.fn.expand('%:p'), 'Normal' } }, false, {})
end

vim.cmd [[augroup lir-settings]]
vim.cmd [[  autocmd!]]
vim.cmd [[  autocmd Filetype lir :lua LirSettings()]]
vim.cmd [[augroup END]]

-- global mark I for last edit
vim.cmd [[autocmd InsertLeave * execute 'normal! mI']]

-- highlight on yank
vim.cmd([[au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=150, on_visual=true}]])

-- kyazdani42/nvim-tree.lua
require('nvim-tree').setup({
  hijack_cursor = true,
  update_focused_file = { enable = true },
  view = {
    width = 35
  }
})
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { silent = true })

vim.cmd('iabbrev :tup: 👍')
vim.cmd('iabbrev :tdo: 👎')
vim.cmd('iabbrev :smi: 😊')
vim.cmd('iabbrev :sad: 😔')
vim.cmd('iabbrev darkred #8b0000')
vim.cmd('iabbrev darkgreen #006400')

-- terminal
vim.keymap.set('t', '<A-w>', '<C-\\><C-n>')

_G.term_buf_of_tab = _G.term_buf_of_tab or {}
_G.term_buf_max_nmb = _G.term_buf_max_nmb or 0

function spawn_terminal()
  local cur_tab = vim.api.nvim_get_current_tabpage()
  vim.cmd('vs | terminal')
  local cur_buf = vim.api.nvim_get_current_buf()
  _G.term_buf_max_nmb = _G.term_buf_max_nmb + 1
  vim.api.nvim_buf_set_name(cur_buf, "Terminal " .. _G.term_buf_max_nmb)
  table.insert(_G.term_buf_of_tab, cur_tab, cur_buf)
  vim.cmd(':startinsert')
end

function toggle_terminal()
  local cur_tab = vim.api.nvim_get_current_tabpage()
  local term_buf = term_buf_of_tab[cur_tab]
  if term_buf ~= nil then
    local cur_buf = vim.api.nvim_get_current_buf()
    if cur_buf == term_buf then
      vim.cmd('q')
    else
      local win_list = vim.api.nvim_tabpage_list_wins(cur_tab)
      for _, win in ipairs(win_list) do
        local win_buf = vim.api.nvim_win_get_buf(win)
        if win_buf == term_buf then
          vim.api.nvim_set_current_win(win)
          vim.cmd(':startinsert')
          return
        end
      end
      vim.cmd('vert sb' .. term_buf)
      vim.cmd(':startinsert')
    end
  else
    spawn_terminal()
    vim.cmd(':startinsert')
  end
end

vim.keymap.set('n', '<c-y>', toggle_terminal)
vim.keymap.set('i', '<c-y>', '<ESC>:lua toggle_terminal()<CR>')
vim.keymap.set('t', '<c-y>', '<c-\\><c-n>:lua toggle_terminal()<CR>')
-- cmd([[
-- if has('nvim')
--    au! TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
-- endif]])

_G.send_line_to_terminal = function()
  local curr_line = vim.api.nvim_get_current_line()
  local cur_tab = vim.api.nvim_get_current_tabpage()
  local term_buf = term_buf_of_tab[cur_tab]
  if term_buf == nil then
    spawn_terminal()
    term_buf = term_buf_of_tab[cur_tab]
  end
  for _, chan in pairs(vim.api.nvim_list_chans()) do
    if chan.buffer == term_buf then
      chan_id = chan.id
    end
  end
  vim.api.nvim_chan_send(chan_id, curr_line .. '\n')
end

-- vim.keymap.set('n', '<leader>x', ':lua send_line_to_terminal()<CR>')

require "nvim-treesitter.configs".setup {
  playground = {
    enable = true,
  }
}

vim.keymap.set('n', '<c-o>', '<c-o>zz')
vim.keymap.set('n', '<c-i>', '<c-i>zz')


-- nvim-telescope/telescope-ui-select.nvim
require("telescope").load_extension("ui-select")

vim.keymap.set('i', '<c-o>', '<esc><s-o>')
vim.keymap.set('n', '<leader>p', ':PackerSync<CR>')

vim.keymap.set('n', '<leader>?', 'orequire("/usr/local/lib/node_modules/derive-type/")(...arguments)<esc>')

require('leap').set_default_keymaps()
