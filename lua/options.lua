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

-- ==========================================================================
-- 1. Optimized Async Git Branch Tracker
-- ==========================================================================
local function update_git_branch(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  -- Skip invalid or special buffers (like Neo-tree, Telescope, etc.)
  if vim.bo[bufnr].buftype ~= "" then return end

  local file_path = vim.api.nvim_buf_get_name(bufnr)
  local dir = vim.fn.fnamemodify(file_path, ':p:h')
  if dir == "" or not vim.fn.isdirectory(dir) then return end

  vim.system({ 'git', 'branch', '--show-current' }, { cwd = dir }, function(obj)
    if obj.code == 0 and obj.stdout then
      local branch = string.gsub(obj.stdout, "%s+", "")
      vim.schedule(function()
        if vim.api.nvim_buf_is_valid(bufnr) then
          if branch ~= "" then
            vim.b[bufnr].git_branch = "  " .. branch .. " "
          else
            vim.b[bufnr].git_branch = "" -- Not a git repo
          end
          -- Force a statusline redraw now that the value is updated
          vim.cmd('redrawstatus')
        end
      end)
    else
      vim.schedule(function()
        if vim.api.nvim_buf_is_valid(bufnr) then
          vim.b[bufnr].git_branch = ""
          vim.cmd('redrawstatus')
        end
      end)
    end
  end)
end

-- ==========================================================================
-- 2. Event Triggers: Catch External Changes (Tmux, Terminal Focus)
-- ==========================================================================
local timer = vim.uv.new_timer()
local git_group = vim.api.nvim_create_augroup('StatuslineGitTracker', { clear = true })

vim.api.nvim_create_autocmd({ 'BufEnter', 'FocusGained', 'BufWritePost' }, {
  group = git_group,
  callback = function(args)
    -- Debounce slightly to prevent thrashing if switching buffers rapidly
    timer:stop()
    timer:start(50, 0, function()
      vim.schedule(function()
        update_git_branch(args.buf)
      end)
    end)
  end,
})

-- ==========================================================================
-- 3. Render and Apply (Synchronous & Blazing Fast)
-- ==========================================================================
function RenderStatusLine()
  local file_name  = " %f %m"
  local git_branch = vim.b.git_branch or "" -- Just reads the cached variable instantly
  local align      = "%="
  local file_type  = " %y "
  local line_col   = " %l:%c "

  return file_name .. git_branch .. align .. file_type .. line_col
end

vim.opt.statusline = "%!v:lua.RenderStatusLine()"

