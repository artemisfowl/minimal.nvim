-- Simply bind a quick toggle command for normal mode mapping
vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<CR>", { desc = "Toggle File Explorer Sidebar" })

local status_ok, neotree = pcall(require, "neo-tree")
if not status_ok then return end

neotree.setup({
  -- Force all interactive text fields out of the tight sidebar drawer
  popup_border_style = "rounded", -- Adds elegant rounded borders to dialog blocks
  
  window = {
    position = "left",
    width = 30,
    mappings = {
      ["<leader>e"] = "close_window",
    },
  },
  filesystem = {
    -- THIS IS THE TRICK: Maps creation/renaming tasks directly to centered window overlays
    use_popups_for_input = true, 
  }
})

