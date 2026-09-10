local status_ok, minicompleting = pcall(require, "mini.completion")
if not status_ok then return end

minicompleting.setup({
  -- Force an immediate popup delay when typing a character (in milliseconds)
  delay = { popup = 50, info = 100 },

  -- Configure windows properties to match your look
  window = {
    info = { border = 'rounded' },
    signature = { border = 'rounded' },
  },

  -- Automatically falls back to LSP suggestions seamlessly
  fallback_action = function() vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-x><C-o>', true, true, true), 'n', true) end
})

-- Optional: Map Tab and Shift-Tab to cleanly navigate the dropdown choices!
vim.keymap.set('i', '<Tab>', [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true })
vim.keymap.set('i', '<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { expr = true })
