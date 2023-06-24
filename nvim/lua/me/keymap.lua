local keymap = function(tbl)
	local opts = { noremap = true, silent = true }
	local mode = tbl['mode']
	tbl['mode'] = nil
	local bufnr = tbl['bufnr']
	tbl['bufnr'] = nil

	for k, v in pairs(tbl) do
		if tonumber(k) == nil then
			opts[k] = v
		end
	end

	if bufnr ~= nil then
		vim.api.nvim_buf_set_keymap(bufnr, mode, tbl[1], tbl[2], opts)
	else
		vim.api.nvim_set_keymap(mode, tbl[1], tbl[2], opts)
	end
end

nmap = function(tbl)
	tbl['mode'] = 'n'
	keymap(tbl)
end

imap = function(tbl)
	tbl['mode'] = 'i'
	keymap(tbl)
end


local ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not ok then return end
treesitter.setup { ensure_installed = "all", highlight = { enable = true } }

-- keymaps
vim.keymap.set("n", "<leader>p", "<cmd>Glow<cr>")
nmap{"<C-f>", "<cmd>Telescope current_buffer_fuzzy_find sorting_strategy=ascending prompt_position=top<CR>"}
nmap{"<leader>lg", "<cmd>Telescope live_grep<CR>"}
nmap{"<leader>dl", "<cmd>Telescope diagnostics<cr>"}
nmap{"<leader>ff", "<cmd>Telescope find_files<cr>"}
nmap{"<leader>fb", "<cmd>Telescope buffers<cr>"}
nmap{"<A-p>", "<cmd>Telescope git_files<cr>"}

-- navigation
nmap{"L", "<cmd>bnext<cr>"}
nmap{"H", "<cmd>bprevious<cr>"}
nmap{"F", "<cmd>HopPattern<cr>"}
nmap{'<A-h>', '<C-w>h'}
nmap{'<A-j>', '<C-w>j'}
nmap{'<A-k>', '<C-w>k'}
nmap{'<A-l>', '<C-w>l'}

-- festivities
nmap{"<leader>;", "<cmd>lua require('duck').hatch('🎅', 1)<cr>"}
nmap{"<leader>'", "<cmd>lua require('duck').cook()<cr>"}

-- nvim-tree
nmap{"<leader>e", "<cmd>NvimTreeToggle<cr>"}

-- terminal
vim.keymap.set('t', '<A-w>', '<C-\\><C-n>')
nmap{"<leader>te", "<cmd>tabnew | terminal<cr>"}
