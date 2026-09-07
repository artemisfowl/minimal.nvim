local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local builtin = require("telescope.builtin")

-- 1. General Setup Configuration
telescope.setup({
  defaults = {
    -- Clean up UI look (puts prompt on top, results below)
    sorting_strategy = "ascending",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
      },
    },
    -- Clear standard layout borders to look modern
    border = true,
    extensions = {
            symbols = {
                    -- Tell telescope to source all Unicode ranges, math symbols, and Nerd Fonts
                    sources = { 'emoji', 'nerd', 'math', 'gucharmap', 'gitmojis' }
            }
    },
  },
})

-- SAFE LOADING: Only load the extension if the package module actually exists on disk
status_ok, _ = pcall(telescope.load_extension, 'symbols')
-- if status_ok then
--   telescope.load_extension('symbols')
-- else
--   vim.notify("telescope-symbols plugin is missing! Run your package sync command.", vim.log.levels.WARN)
-- end

-- 2. Global Picker Keymaps
-- Fast project searching and workspace navigation
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope Find Files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope Live Grep (Search Text)" })
vim.keymap.set("n", "<leader>fh", builtin.oldfiles, { desc = "Telescope Recent Files History" })

-- Search by Grep (Space + s + g)
vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "Search Project by Grep" })

-- 3. Fast Buffer Switching
-- Instantly brings up an overlay menu of active tabs to jump between files
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope Active Buffers" })

-- 4. Tree-sitter Code Symbol Lookups
-- This scans the active buffer using Tree-sitter so you can fuzzy-search
-- and jump straight to specific functions, methods, or variable hooks.
vim.keymap.set("n", "<leader>fs", builtin.treesitter, { desc = "Telescope Tree-sitter Code Symbols" })

-- Show Diagnostics (Space + s + d)
-- This pulls all active LSP errors, warnings, and hints into a filterable list
vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "Search Diagnostics list via Telescope" })

-- Search ALL system glyphs, emojis, and nerd fonts under <Space>si
vim.keymap.set('n', '<leader>si', '<cmd>Telescope symbols<CR>', { desc = '[S]earch Universal [I]cons & Glyphs' })
