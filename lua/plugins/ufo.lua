-- lua/plugins/ufo.lua
local status_ufo, ufo = pcall(require, "ufo")
if not status_ufo then
    return
end

ufo.setup({
    provider_selector = function(bufnr, filetype, buftype)
        -- Uses treesitter for code structures, falls back to indent folding
        return {'treesitter', 'indent'}
    end
})

-- Optional: Map 'zR' and 'zM' specifically for UFO if default behavior feels slow
vim.keymap.set('n', 'zR', ufo.openAllFolds, { desc = "Open all folds" })
vim.keymap.set('n', 'zM', ufo.closeAllFolds, { desc = "Close all folds" })

