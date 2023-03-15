vim.opt.number = true
vim.opt.cursorline = true
vim.opt.cursorcolumn = false
vim.wo.wrap = false
vim.wo.list = true

local g = vim.g

if g.neovide then
  -- Helper function for transparency formatting
  local alpha = function()
    return string.format("%x", math.floor(255 * g.transparency or 0.8))
  end

  g.neovide_input_use_logo = "v:true"
  g.neovide_remember_window_size = "v:true"
  g.neovide_cursor_trail_length = 0
  g.neovide_cursor_animation_length = 0
  g.neovide_cursor_vfx_mode = "railgun"
  g.neovide_window_floating_opacity = 0.85
  g.neovide_floating_blur = 0.8
  g.neovide_fullscreen = "v:true"

  -- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
  g.neovide_transparency = 0.9
  g.neovide_window_floating_transparency = 0.6
  g.transparency = 0.9
  g.neovide_background_color = "#0f1117" .. alpha()
end
