require("user.options")
require("user.plugins")
require("user.autocommands")
require("user.keybindings")

lvim.colorscheme = "material"
lvim.transparent_window = true
lvim.leader = "space"
lvim.log.level = "warn"
lvim.format_on_save.enabled = true

lvim.builtin.telescope = {
  active = true,
  defaults = {
    layout_strategy = "horizontal",
    path_display = { truncate = 2 }
  }
}

lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "yaml",
}

-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "eslint_d", filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" } },
-- }

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    command = "prettier",
    filetypes = { "typescript" },
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
    -- args = { "--print-width", "100" },
  },
}
