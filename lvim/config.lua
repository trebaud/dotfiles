require("user.options")
require("user.plugins")
require("user.autocommands")
require("user.keybindings")

lvim.colorscheme = "tokyonight"
lvim.transparent_window = false
lvim.leader = "space"
lvim.log.level = "warn"
lvim.format_on_save.enabled = true

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
