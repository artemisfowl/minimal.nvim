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

-- Show the list characters
vim.opt.list = false
vim.opt.listchars = {
  tab = "» ",
  trail = "·",
  nbsp = "‿",
  eol = "↵",
  extends = "…",
  precedes = "…",
  multispace = "￮",
  lead = " ",
  space = "␣",
}

vim.o.winborder = "rounded"

-- 1. Helper to fetch the current Git branch asynchronously
local function get_git_branch()
  if vim.b.git_branch then
    return vim.b.git_branch
  end

  local dir = vim.fn.expand('%:p:h')
  if dir == "" then return "" end

  vim.system({ 'git', 'branch', '--show-current' }, { cwd = dir }, function(obj)
    if obj.code == 0 and obj.stdout then
      local branch = string.gsub(obj.stdout, "%s+", "")
      if branch ~= "" then
        vim.schedule(function()
          -- Add a branch icon (requires a Nerd Font installed in your terminal)
          vim.b.git_branch = "  " .. branch .. " "
        end)
      end
    end
  end)

  return vim.b.git_branch or ""
end

-- 2. Build the statusline layout
function RenderStatusLine()
  local file_name = " %f %m"
  local git_branch = get_git_branch()
  local align = "%="
  local file_type = " %y "
  local line_col = " %l:%c "

  return file_name .. git_branch .. align .. file_type .. line_col
end

-- 3. Apply it to Neovim
vim.opt.statusline = "%!v:lua.RenderStatusLine()"

