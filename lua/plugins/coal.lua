-- Apply the coal theme profile natively
local status_ok, _ = pcall(vim.cmd, "colorscheme coal")
if not status_ok then
  print("coal.nvim colorscheme could not be loaded!")
end

