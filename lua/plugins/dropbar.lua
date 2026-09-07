-- Initialize breadcrumbs
require('dropbar').setup({
  bar = {
    -- Automatically attach the breadcrumb bar to all standard code buffers
    attach = function(buf, win)
      return vim.bo[buf].ft ~= 'neo-tree'
         and vim.bo[buf].buftype == ''
         and vim.api.nvim_win_get_config(win).relative == ''
    end,
    -- Configuration for formatting your path names and symbol names
    pick = {
      pivots = 'abcdefghijklmnopqrstuvwxyz'
    }
  },
  icons = {
    kinds = {
      symbols = {
        File = ' ',
        Module = ' ',
        Namespace = ' ',
        Class = '𝓒 ',
        Method = '󰡱 ',
        Function = '󰊕 ',
        Variable = '󰫧 ',
      }
    }
  }
})

