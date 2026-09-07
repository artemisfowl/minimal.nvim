require("aerial").setup({
  layout = {
    max_width = { 40, 0.2 },
    width = 30,
    default_direction = "right",
  },
  close_on_select = false,
  update_events = "CursorMoved,CursorMovedI",
  backends = { "treesitter", "lsp", "markdown", "man" },

  -- ADD THIS SECTION TO SHOW VARIABLES AND MORE:
  -- filter_kind = {
  --   "Class",
  --   "Constructor",
  --   "Enum",
  --   "Function",
  --   "Interface",
  --   "Module",
  --   "Method",
  --   "Struct",
  --   "Variable",  -- Shows variables
  --   "Constant",  -- Shows constants (like capital/global definitions)
  --   "Field",     -- Shows object fields/properties
  -- },
	filter_kind = false,
})

