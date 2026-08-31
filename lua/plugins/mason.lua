local mason_ok, mason = pcall(require, "mason")
local lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")

if not (mason_ok and lspconfig_ok) then
  return
end

-- 1. Initialize the Mason package manager UI
mason.setup({
  ui = { border = "rounded" }
})

-- 2. Define universal callback rules via an autocmd
-- (Native Neovim 0.11+ uses LspAttach to globally inject keymaps/settings)
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  end,
})

-- 3. Statically inject any custom overrides BEFORE enabling them
-- (Nvim automatically pulls default cmd/root_markers from nvim-lspconfig)
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } }
    }
  }
})

-- 4. Let mason-lspconfig automatically link and enable everything
mason_lspconfig.setup({
  ensure_installed = { "lua_ls", "pyright" },
  
  -- This single setting completely removes the need to manually invoke vim.lsp.enable()
  automatic_enable = true, 
})

-- 5. Global Management Dashboard Keymap
vim.keymap.set("n", "<leader>cm", "<cmd>Mason<CR>", { desc = "Open Mason Packages Dashboard" })
