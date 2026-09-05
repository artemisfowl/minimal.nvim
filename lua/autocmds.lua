-- ===================================================================
-- 1. YANK HIGHLIGHT CONFIGURATION
-- ===================================================================
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank({
      higroup = 'IncSearch',
      timeout = 250,
    })
  end,
  group = highlight_group,
  pattern = '*',
})

-- ===================================================================
-- 2. THEME COLOR OVERRIDES (HIGH VISIBILITY LINE NUMBERS)
-- ===================================================================
local ui_group = vim.api.nvim_create_augroup('UICustomization', { clear = true })

vim.api.nvim_create_autocmd('ColorScheme', {
  callback = function()
    -- Break any hard links coal.nvim sets on gutter columns
    vim.api.nvim_set_hl(0, 'LineNr', {})
    vim.api.nvim_set_hl(0, 'CursorLineNr', {})

    -- 1. Active cursor row background tint
    vim.api.nvim_set_hl(0, 'CursorLine', { bold = true, bg = '#2A2A2A', force = true })

    -- 2. Bright active line number (Pure White)
    vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#FFFFFF', bold = true, force = true })

    -- 3. CRITICAL OVERRIDE: High-contrast silver gray relative numbers
    vim.api.nvim_set_hl(0, 'LineNr', { fg = '#C0C0C0', bold = true, force = true })
  end,
  group = ui_group,
  pattern = '*',
})

-- Force evaluate instantly for your current open session right now
vim.api.nvim_set_hl(0, 'LineNr', {})
vim.api.nvim_set_hl(0, 'CursorLineNr', {})
vim.api.nvim_set_hl(0, 'CursorLine', { bold = true, bg = '#2A2A2A', force = true })
vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#FFFFFF', bold = true, force = true })
vim.api.nvim_set_hl(0, 'LineNr', { fg = '#B0B0B0', bold = true, force = true })

-- ===================================================================
-- 3. LANGUAGE-SPECIFIC LAYOUTS AND FILETYPE SETTINGS
-- ===================================================================

-- Helper function to configure individual buffer options smoothly
local function set_buffer_options(opts)
  vim.opt_local.colorcolumn = tostring(opts.cc)
  vim.opt_local.tabstop = opts.ts
  vim.opt_local.shiftwidth = opts.ts
  vim.opt_local.expandtab = true
  vim.opt_local.cursorcolumn = false
  vim.opt_local.cursorline = true
  vim.opt_local.textwidth = opts.tw
end

-- Catch-all Default Configurations for Generic Filetypes
local any_group = vim.api.nvim_create_augroup('any', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  group = any_group,
  pattern = '*',
  callback = function()
    set_buffer_options({ cc = 200, ts = 2, tw = 199 })
  end,
})

-- Languages Settings Matrix
local lang_settings = {
  c      = { pattern = { '*.c', '*.h' },     cc = 80,  ts = 8, tw = 79 },
  cpp    = { pattern = { '*.cpp', '*.hpp' }, cc = 120, ts = 2, tw = 119 },
  python = { pattern = '*.py',                cc = 120, ts = 4, tw = 119 },
  go     = { pattern = '*.go',                cc = 80,  ts = 4, tw = 79 },
  ruby   = { pattern = '*.rb',                cc = 80,  ts = 8, tw = 79 },
  tex    = { pattern = '*.tex',               cc = 120, ts = 4, tw = 119 },
  lisp   = { pattern = '*.lisp',              cc = 120, ts = 8, tw = 119 },
}

-- Dynamically loop and establish clean, native auto-commands
for lang, config in pairs(lang_settings) do
  local group = vim.api.nvim_create_augroup('lang_' .. lang, { clear = true })

  -- Step A: Set filetype explicitly on read/new
  vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    group = group,
    pattern = config.pattern,
    command = 'set filetype=' .. lang,
  })

  -- Step B: Apply local formatting styles dynamically when that FileType mounts
  vim.api.nvim_create_autocmd('FileType', {
    group = group,
    pattern = lang,
    callback = function()
      set_buffer_options({ cc = config.cc, ts = config.ts, tw = config.tw })
    end,
  })
end


-- ===================================================================
-- 4. INTERACTIVE TIMESTAMP INSERTS (F10 MAPPINGS)
-- ===================================================================

-- Native strftime generator function
local function get_timestamp()
  return vim.fn.strftime("%Y-%m-%d %H:%M:%S %z") .. " : "
end

-- Normal Mode: Paste timestamp right above or before the cursor position
vim.keymap.set('n', '<F10>', function()
  local pos = vim.api.nvim_win_get_cursor(0)
  vim.api.nvim_put({ get_timestamp() }, 'c', false, true)
end, { desc = "Insert system timestamp layout" })

-- Insert Mode: Stream timestamp string cleanly straight into current typing frame
vim.keymap.set('i', '<F10>', function()
  vim.api.nvim_feedkeys(get_timestamp(), 'n', true)
end, { desc = "Insert system timestamp string" })

-- ===================================================================
-- 5. NATIVE LSP ASYNC AUTOTRIGGER COMPLETION (NEOVIM 0.12 API)
-- ===================================================================
-- local completion_group = vim.api.nvim_create_augroup('LspAutocompleteTrigger', { clear = true })
--
-- vim.api.nvim_create_autocmd('LspAttach', {
--   group = completion_group,
--   callback = function(args)
--     local client_id = args.data.client_id
--     if not client_id then return end
--
--     local client = vim.lsp.get_client_by_id(client_id)
--     if client and client:supports_method("textDocument/completion") then
--       -- Explicitly register native completion client binding for this specific file buffer
--       vim.lsp.completion.enable(true, client_id, args.buf, {
--         autotrigger = true
--       })
--     end
--   end,
-- })

-- ===================================================================
-- 6. AUTOMATIC DIAGNOSTIC HOVER POPUPS (NEOVIM NATIVE)
-- ===================================================================
local diagnostic_group = vim.api.nvim_create_augroup('DiagnosticHover', { clear = true })

vim.api.nvim_create_autocmd('CursorHold', {
  group = diagnostic_group,
  callback = function()
    -- Only trigger if the popup menu or another floating window isn't active
    if vim.fn.pumvisible() == 0 then
      vim.diagnostic.open_float(nil, {
        focusable = false,      -- Prevents your cursor from jumping inside the popup card
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        border = "rounded",    -- Smooth modern borders matching dressing/mason looks
        source = "always",     -- Explicitly shows WHICH engine threw the error (e.g., Pyright)
        prefix = " ",
      })
    end
  end,
})


-- ===================================================================
-- 7. VIRTUAL TEXT DIAGNOSTICS WITH SMART ELLIPSIS
-- ===================================================================

vim.diagnostic.config({
  virtual_text = {
    -- Clean separator between your code and the diagnostic text
    spacing = 4,
    prefix = "■",

    -- Custom format function to truncate long error messages
    format = function(diagnostic)
      local max_length = 50 -- Maximum character width before cutting off
      local message = diagnostic.message

      -- Clean up message formatting (replace newlines with spaces)
      message = message:gsub("\n", " ")

      if #message > max_length then
        -- Cut the string down and append a clean ellipsis symbol
        return string.sub(message, 1, max_length) .. "..."
      end

      return message
    end,
  },

  -- Keep these standard diagnostic layouts running smoothly alongside virtual text
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- Dynamically disable mini.completion if no LSP is attached to the buffer
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    -- If an LSP attaches, explicitly ensure completion is enabled
    vim.b[args.buf].minicompletion_disable = false
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    -- Wait a tiny moment for LSP to initialize, then check if any clients are active
    vim.defer_fn(function()
      local clients = vim.lsp.get_clients({ bufnr = 0 })
      if #clients == 0 then
        vim.b.minicompletion_disable = true
      end
    end, 50) -- 50ms delay gives LSP time to handshake
  end,
})

-- Trim the newline/trailing space on save
local autoclean = vim.api.nvim_create_augroup("RemoteTrailingSpace", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
  group = autoclean,
  pattern = "*",
  callback = function()
    -- Save the current cursor position
    local save_cursor = vim.fn.getpos(".")
    -- Remove trailing spaces globally without throwing errors if none are found
    vim.cmd([[%s/\s\+$//e]])
    -- Restore the cursor position so it doesn't jump
    vim.fn.setpos(".", save_cursor)
  end,
})

