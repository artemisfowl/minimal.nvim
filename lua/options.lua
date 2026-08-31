local opt = vim.opt

-- line numbering (absolute and relative)
opt.number = true			-- show the actual number of the line
opt.relativenumber = true		-- enable relative numbering

-- splitting
opt.splitright = true 			-- split vertical windows to the right
opt.splitbelow = true 			-- split horizontal windows to the bottom

-- searching
opt.ignorecase = true 			-- case in-sensitive searching 
opt.smartcase = true 			-- if upper-case alphabet used in searching, become case sensitive 
opt.hlsearch = true			-- hilight the search
opt.incsearch = true			-- enable the incremental search
opt.autochdir = false			-- automatically change the directory to the directory of the file being edited

-- gutter
opt.signcolumn = "yes"			-- LSP symbols should not shift the code

-- tabs and indentation`
opt.expandtab = true			-- expand all tabs with spaces
opt.smartindent = true			-- insert appropriate indentation when stepping inside a programmatic scope

-- terminal true color support
opt.termguicolors = true

-- cursorline and cursorcolumn
opt.cursorline = true
opt.cursorcolumn = false

-- clipboard (sync with system clipboard)
opt.clipboard = "unnamedplus"

-- fileformats, backup and permanent history
opt.swapfile = false			-- Do not create swap files
opt.backup = false			-- Do not create backups
opt.undofile = true 			-- Enable permanent undo records

-- wrapping
opt.wrap = true                         -- Automatically wrap lines

-- mouse
opt.mouse = "a"                         -- enable mouse related actions

-- mode
opt.showmode = false                    -- do not show the modw, rather handle it in the status line:w
opt.showtabline = 1                     -- always show the tabline

-- scrolling
opt.smoothscroll = true                 -- Enables smooth scrolling

-- Hides the '~' characters at the end of a buffer by replacing them with empty spaces
opt.fillchars:append({ eob = " " })

-- menu pop-up and command completions
opt.wildoptions = "pum"
opt.pumheight = 10                      -- restrict to 10 options per pop-up
opt.complete = ".,w,b,u,t,o"
opt.completeopt = "fuzzy,menu,menuone,noinsert,popup"

-- hover update time
opt.updatetime = 350
