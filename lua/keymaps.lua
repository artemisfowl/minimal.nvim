local keymap = vim.keymap

-- space as the leader
vim.g.mapleader = " "

-- quick split navigation [normal mode]
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- cursor navigation [normal mode]
keymap.set("n", "H", "^", { desc = "Move the cursor to the start of the line in normal mode" })
keymap.set("n", "L", "$", { desc = "Move the cursor to the end of the line in normal mode" })

-- cursor navigation [visual mode]
keymap.set("v", "H", "^", { desc = "Move the cursor to the start of the line in visual mode" })
keymap.set("v", "L", "$", { desc = "Move the cursor to the end of the line in visual mode" })

-- Clear search highlights easily
keymap.set("n", "<leader>h", "<cmd>nohlsearch<CR>")

-- 1. Normal Mode Mappings
-- Pushes the current line up or down by 1 row step
keymap.set("n", "J", "<cmd>execute 'move .+' . v:count1<CR>==", { desc = "Move current line down" })
keymap.set("n", "K", "<cmd>execute 'move .-' . (v:count1 + 1)<CR>==", { desc = "Move current line up" })

-- 2. Visual / Select Mode Mappings
-- Slides highlighted blocks up/down, keeps them highlighted, and auto-indents them
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected block down", silent = true })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected block up", silent = true })

-- ===================================================================
-- FAST LINE INDENTATION / DE-INDENTATION MAPPINGS
-- ===================================================================

-- 1. Normal Mode Mappings
-- Pressing > or < twice in normal mode shifts the current line instantly
keymap.set("n", ">", ">>", { desc = "Indent current line" })
keymap.set("n", "<", "<<", { desc = "De-indent current line" })

-- 2. Visual Mode Mappings (With Persistent Selection)
-- Shifting blocks in visual mode retains your highlighted block array!
keymap.set("v", ">", ">gv", { desc = "Indent selected block and keep selection" })
keymap.set("v", "<", "<gv", { desc = "De-indent selected block and keep selection" })

-- Settings for updating the plugins and required configurations
vim.api.nvim_create_user_command("PackUpdate", function ()
	vim.pack.update()
	local plugins = vim.pack.get()
  	local names = {}

  	-- Extract names from the registered specs
  	for _, p in ipairs(plugins) do
    		if p.spec and p.spec.name then
      			table.insert(names, p.spec.name)
    		end
  	end

  	if #names > 0 then
    		-- Explicitly pass names to force vim.pack to pull/clone them
    		vim.pack.update(names)
  	else
    		print("vim.pack: No plugins are registered to update!")
  	end
end, {})

vim.api.nvim_create_user_command("PackStatus", function ()
	print(vim.inspect(vim.pack.get()))
end, {})


-- Toggle list characters
vim.keymap.set('n', '<leader>tl', ':set list!<CR>', { desc = 'Toggle invisible characters' })

-- Toggle the VS Code style code outline panel using <leader>o
vim.keymap.set("n", "<leader>o", "<cmd>AerialToggle!<CR>", { desc = "Toggle Code [O]utline panel" })

-- Keymaps to peek functions, methods, and classes inline using Glance
vim.keymap.set('n', 'gpd', '<cmd>Glance definitions<CR>', { desc = '[G]lance [D]efinitions' })
vim.keymap.set('n', 'gr', '<cmd>Glance references<CR>', { desc = '[G]lance [R]eferences' })
vim.keymap.set('n', 'gi', '<cmd>Glance implementations<CR>', { desc = '[G]lance [I]mplementations' })
vim.keymap.set('n', 'gy', '<cmd>Glance type_definitions<CR>', { desc = '[G]lance T[y]pe Definitions' })

