-- Helper function to expand GitHub shorthands properly
local function clean_specs(specs)
  local processed = {}
  
  for _, spec in ipairs(specs) do
    if type(spec) == "string" then
      -- Plain string expansion
      local url = spec
      if not url:match("^https?://") then
        url = "https://github.com/" .. url
      end
      table.insert(processed, { src = url })
      
    elseif type(spec) == "table" then
      -- Table spec parsing (e.g. { "nvim-telescope/telescope.nvim" })
      local target = spec.src or spec[1]
      
      if target and type(target) == "string" then
        if not target:match("^https?://") then
          target = "https://github.com/" .. target
        end
        
        -- Explicitly bind to the native 'src' key and clear array index [1]
        spec.src = target
        spec[1] = nil
      end
      table.insert(processed, spec)
    end
  end
  
  return processed
end

-- Custom wrapper that allows shorthand plugin specs
local function pack_add(plugins)
  vim.pack.add(clean_specs(plugins))
end

-- Declare your plugins using a table structure inside vim.pack.add
pack_add({
  -- Treesitter for advanced syntax highlighting
  { 
    "nvim-treesitter/nvim-treesitter", 
    hooks = { 
      post_checkout = function() vim.cmd("TSUpdate") end 
    } 
  },
  -- Dependencies for neo-tree UI
  "nvim-lua/plenary.nvim",
  "nvim-tree/nvim-web-devicons",
  "MunifTanjim/nui.nvim",
  
  -- The core file tree explorer module
  { 
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x"
  },

  -- For loading files, switching buffers and the like
  "nvim-telescope/telescope.nvim",

  -- The package manager core
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",

  -- Add this for lightning-fast auto popup behaviors
  "echasnovski/mini.completion",

  -- lspconfig handler for nvim
  "neovim/nvim-lspconfig",

  -- The minimalist monochrome dark theme
  "cranberry-clockworks/coal.nvim",
})

-- Load individual plugin configurations from the plugins folder
require("plugins.neotree")
require("plugins.telescope")
require("plugins.coal")
require("plugins.mason")
require("plugins.mini")
