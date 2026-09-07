local glance = require('glance')

glance.setup({
  height = 18,
  zindex = 45,
  detached = false,

  -- FIXED HOOK SYNTAX:
  -- Parameter order is: (results, open_callback, jump_callback, method)
  hooks = {
    before_open = function(results, open, jump, method)
      open(results) -- Natively invokes the interactive peek pane every time
    end,
  },

  -- Your existing border visual accents configuration
  border = {
    enable = true,
    top_char = '─', bottom_char = '─',
    left_char = '│', right_char = '│',
    top_left_char = '╭', top_right_char = '╮',
    bottom_left_char = '╰', bottom_right_char = '╯',
  },

  preview_win_opts = {
    cursorline = true,
    number = true,
    relativenumber = true,
  },

  mappings = {
    list = {
      ['j'] = glance.actions.next,
      ['k'] = glance.actions.previous,
      ['<Down>'] = glance.actions.next,
      ['<Up>'] = glance.actions.previous,
      ['<Tab>'] = glance.actions.next_location,
      ['<S-Tab>'] = glance.actions.previous_location,

      -- Focus step-in preview bindings
      ['l'] = glance.actions.enter_win('preview'),
      ['<Right>'] = glance.actions.enter_win('preview'),

      ['<CR>'] = glance.actions.jump,
      ['v'] = glance.actions.jump_vsplit,
      ['x'] = glance.actions.jump_split,
      ['t'] = glance.actions.jump_tab,
      ['q'] = glance.actions.close,
    },
    preview = {
      ['q'] = glance.actions.close,
      ['<Tab>'] = glance.actions.next_location,
      ['<S-Tab>'] = glance.actions.previous_location,

      -- Step-out focus bindings
      ['h'] = glance.actions.enter_win('list'),
      ['<Left>'] = glance.actions.enter_win('list'),
    },
  },
})

