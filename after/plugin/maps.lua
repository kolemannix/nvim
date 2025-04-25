-- Telescope

--local ts_actions = require("telescope.actions")
local ts_open_with_trouble = require("trouble.sources.telescope").open
-- Use this to add more results without clearing the trouble list
--local ts_add_to_trouble = require("trouble.sources.telescope").add

local lga_actions = require("telescope-live-grep-args.actions")
require('telescope').setup {
  theme = "ivy",
  pickers = {
    colorscheme = {
      enable_preview = true
    },
    lsp_references = {
      show_line = false,
      fname_width = 60
    }
  },
  defaults = {
    mappings = {
      i = {
        ["<c-t>"] = ts_open_with_trouble,
        ["<esc>"] = require('telescope.actions').close
      },
      n = { ["<c-t>"] = ts_open_with_trouble },
    },
    file_ignore_patterns = { ".git/", "node_modules/" },
    layout_config = {
      horizontal = {
        prompt_position = "top"
      }
    }
  },
  extensions = {
    fzf = {},
    extensions = {
      live_grep_args = {
        auto_quoting = true, -- enable/disable auto-quoting
        -- define mappings, e.g.
        mappings = {         -- extend mappings
          i = {
            ["<C-k>"] = lga_actions.quote_prompt(),
            ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
            -- freeze the current list and start a fuzzy search in the frozen list
            ["<C-space>"] = lga_actions.to_fuzzy_refine,
          },
        },
        -- ... also accepts theme settings, for example:
        theme = "ivy", -- use ivy theme
        -- theme = { }, -- use own theme spec
        -- layout_config = { mirror=true }, -- mirror preview pane
      }
    }
  }
}

require('telescope').load_extension('fzf')
require('telescope').load_extension("live_grep_args")

require('gitsigns').setup()

require('mini.basics').setup({
  options = {
    extra_ui = true,
  },
})
-- require('mini.comment')
require('mini.surround').setup({
  mappings = {
    add = 'ys',
    delete = 'ds',
    find = '',
    find_left = '',
    highlight = '',
    replace = 'cs',
    update_n_lines = '',
  },
  search_method = 'cover_or_next'
})
--require('mini.operators').setup({})

require('mini.ai').setup({})
require('mini.bufremove').setup({})
require('mini.bracketed').setup({})
require('mini.clue').setup({
  window = {
    delay = 0,
    width = 'auto'
  },
  triggers = {
    -- Leader triggers
    { mode = 'n', keys = '\\' },
    { mode = 'n', keys = '<Leader>' },
    { mode = 'x', keys = '<Leader>' },
    -- Bracketed
    { mode = 'n', keys = '[' },
    { mode = 'n', keys = ']' },

    -- Built-in completion
    { mode = 'i', keys = '<C-x>' },

    -- `g` key
    { mode = 'n', keys = 'g' },
    { mode = 'x', keys = 'g' },

    -- Marks
    { mode = 'n', keys = "'" },
    { mode = 'n', keys = '`' },
    { mode = 'x', keys = "'" },
    { mode = 'x', keys = '`' },

    -- Registers
    { mode = 'n', keys = '"' },
    { mode = 'x', keys = '"' },
    { mode = 'i', keys = '<C-r>' },
    { mode = 'c', keys = '<C-r>' },

    -- Window commands
    { mode = 'n', keys = '<C-w>' },

    -- `z` key
    { mode = 'n', keys = 'z' },
    { mode = 'x', keys = 'z' },
  },

  clues = {
    -- Enhance this by adding descriptions for <Leader> mapping groups
    require('mini.clue').gen_clues.builtin_completion(),
    require('mini.clue').gen_clues.g(),
    require('mini.clue').gen_clues.marks(),
    require('mini.clue').gen_clues.registers(),
    require('mini.clue').gen_clues.windows(),
    require('mini.clue').gen_clues.z(),
    { mode = 'n', keys = '<leader>b', desc = '+Buffers' },
    { mode = 'n', keys = '<leader>t', desc = '+Tasks' },
    { mode = 's', keys = '<leader>s', desc = '+Show' },
    { mode = 'n', keys = ']',         desc = '+Next' },
    { mode = 'n', keys = '[',         desc = '+Prev' },
  },
})

--require('mini.files').setup {
--
--}

-- Gutter Symbols
local signs = {
  Error = "E",
  Warn = "W",
  Hint = "H",
  Info = "I"
}
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

function named_opts(desc)
  return { noremap = true, silent = true, desc = desc }
end

local opts = { noremap = true, silent = true }

-- Colemak essentials
-- vim.keymap.set('n', 'n', 'j')
-- vim.keymap.set('v', 'n', 'j')
-- vim.keymap.set('n', 'e', 'k')
-- vim.keymap.set('v', 'e', 'k')
-- vim.keymap.set('n', 'i', 'l')
-- vim.keymap.set('v', 'i', 'l')
local colemak_mode = false
local function colemak_toggle()
  if colemak_mode then
    vim.keymap.set('n', 'n', 'n')
    vim.keymap.set('v', 'n', 'n')
    vim.keymap.set('n', 'e', 'e')
    vim.keymap.set('v', 'e', 'e')
    vim.keymap.set('n', 'i', 'i')
    vim.keymap.set('v', 'i', 'i')
    colemak_mode = false
  else
    vim.keymap.set('n', 'n', 'j')
    vim.keymap.set('v', 'n', 'j')
    vim.keymap.set('n', 'e', 'k')
    vim.keymap.set('v', 'e', 'k')
    vim.keymap.set('n', 'i', 'l')
    vim.keymap.set('v', 'i', 'l')
    colemak_mode = true
  end
  print('Toggled Colemak to ' .. tostring(colemak_mode))
end

-- Navigate a bit in insert mode
vim.keymap.set('i', '<C-h>', '<left>')
vim.keymap.set('i', '<C-j>', '<down>')
vim.keymap.set('i', '<C-k>', '<up>')
vim.keymap.set('i', '<C-l>', '<right>')

vim.keymap.set('n', '<C-h>', '<left>')
vim.keymap.set('n', '<C-j>', '<down>')
vim.keymap.set('n', '<C-k>', '<up>')
vim.keymap.set('n', '<C-l>', '<right>')

-- Swap lines up and down

vim.keymap.set('v', '<C-j>', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', '<C-k>', ":m '<-2<CR>gv=gv")

vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

vim.keymap.set("n", "<leader>sub", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("x", "<leader>ss", [[:%s/\%V\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set('i', 'jk', '<esc>', opts)

vim.keymap.set('x', '<leader>p', '"_dP', named_opts('Paste preserving register'))

-- Does not play nice with mini.animate scroll, use one or the other
-- I'm using neovide now so ditching these and using mini.animate for now!
vim.keymap.set('n', '<C-d>', '<C-d>zz', named_opts("Page down (centered)"))
vim.keymap.set('n', '<C-u>', '<C-u>zz', named_opts("Page up (centered)"))

-- Do not yank with x
vim.keymap.set('n', 'x', '"_x', opts)

function ts_grep_from_dir(dir)
  require('telescope.builtin').live_grep({ cwd = dir })
end

function ts_grep_from_buffer_dir()
  local buf_dir = require('telescope.utils').buffer_dir()
  ts_grep_from_dir(buf_dir)
end

local tk = require('telekasten')
tk.setup({
  home = vim.fn.expand("~/vim_notes"), -- Put the name of your notes directory here
})

vim.keymap.set('n', '<leader>n<space>', '<cmd>Telekasten panel<cr>')
vim.keymap.set('n', '<leader>nd', '<cmd>Telekasten goto_today<cr>')
vim.keymap.set('n', '<leader>nw', '<cmd>Telekasten goto_thisweek<cr>')
vim.keymap.set('n', '<leader>nv', '<cmd>Telekasten paste_img_and_link<cr>')
vim.keymap.set('n', '<leader>nx', '<cmd>Telekasten toggle_todo<cr>')

vim.keymap.set('n', '<leader>M', require('telescope').extensions.metals.commands, named_opts('Metals command picker'))
vim.keymap.set('n', '<leader>f', function()
  local opts = require('telescope.themes').get_ivy {
    previewer = false,
  }
  require('telescope.builtin').find_files(opts)
end, named_opts('[F]ind [f]ile'))

vim.keymap.set('n', '<leader>/', function()
  local opts = require('telescope.themes').get_ivy {
    previewer = true,
  }
  require('telescope').extensions.live_grep_args.live_grep_args(opts)
end, named_opts('Grep Workspace'))

vim.keymap.set('v', '<leader>*', function()
  local opts = require('telescope.themes').get_ivy {
    previewer = true,
  }
  require("telescope-live-grep-args.shortcuts").grep_visual_selection(opts)
end, named_opts('Grep visual selection'))

vim.keymap.set('n', '<bs>', "<C-o>", named_opts('Go back'))

-- <leader>s for Show
vim.keymap.set('n', '<leader>sg', '<cmd>Gitsigns preview_hunk_inline<cr>', named_opts('Show diff'))
vim.keymap.set('n', '<leader>sb', '<Cmd>Gitsigns toggle_current_line_blame<CR>', named_opts('Blame'))
vim.keymap.set('n', '<leader>sl', vim.diagnostic.open_float, named_opts('Line diagnostics'))

vim.keymap.set('n', '<leader><tab>',
  function() require('telescope.builtin').buffers({ sort_mru = true }) end,
  named_opts('Open buffer picker'))

-- d for debug
-- vim.keymap.set('n', '<leader>Dc', dap.continue, named_opts('Go (continue)'))
-- vim.keymap.set('n', '<leader>Dt', dap.repl.toggle, named_opts('Toggle debug repl'))

-- <leader>h for help
function edit_neovim()
  require('telescope.builtin').find_files {
    hidden = true,
    cwd = vim.fn.stdpath("config"),
    layout_strategy = 'horizontal',
  }
end

vim.keymap.set('n', '<leader>ho', '<cmd>lua edit_neovim()<cr>', named_opts('[O]pen config dir'))
vim.keymap.set('n', '<leader>hs', '<cmd>source %<cr>', named_opts('Source current buffer'))
vim.keymap.set('n', '<leader>hx', ':.lua<cr>', named_opts('e[x]ecute line lua'))
vim.keymap.set('v', '<leader>hx', ':.lua<cr>', named_opts('e[x]ecute selection lua'))
-- vim.keymap.set('n', '<leader>hr', '<cmd>lua <c-r>*<cr>', named_opts('Run yanked'))
vim.keymap.set('n', '<leader>h/', function() ts_grep_from_dir('~/.config/nvim') end, named_opts('Grep config dir'))
vim.keymap.set('n', '<leader>htc', colemak_toggle, named_opts('Toggle -> Colemak'))
vim.keymap.set('n', '<leader>hh', require('telescope.builtin').help_tags, named_opts('Help'))

-- Goto

vim.keymap.set('n', ']t', '<Cmd>tabn<CR>', named_opts('Next Tab'))
vim.keymap.set('n', '[t', '<Cmd>tabp<CR>', named_opts('Previous Tab'))

-- Forward / Back
vim.keymap.set("n", "] ", "o<esc>", named_opts("New line down"))
vim.keymap.set("n", "[ ", "O<esc>", named_opts("New line up"))
vim.keymap.set("n", "]g", "<cmd>Gitsigns next_hunk<cr>", named_opts("Next hunk"))
vim.keymap.set("n", "[g", "<cmd>Gitsigns prev_hunk<cr>", named_opts("Prev hunk"))
vim.keymap.set("n", "<leader>gz", '<cmd>Gitsigns reset_hunk<CR>')
vim.keymap.set("n", "<leader>?", require('telescope.builtin').command_history, named_opts("Command history"))
--
-- Tabs!
vim.keymap.set("n", "<leader>tn", "<cmd>tabnew<cr>", named_opts("[N]ew [t]ab"))
vim.keymap.set("n", "<leader>tx", "<cmd>tabclose<cr>", named_opts("Kill [t]ab"))
vim.keymap.set("n", "gt", "<cmd>Tabby jump_to_tab<cr>", named_opts("[G]oto [T]ab"))
