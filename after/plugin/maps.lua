vim.g.mapleader = ' '
require('which-key')
-- Telescope
local telescope = require('telescope')
local saga = require("lspsaga")

require("mason").setup()

require('gitsigns').setup()

require('toggleterm').setup({
  open_mapping = [[<c-\>]],
  direction = 'horizontal'
})
require("nvim-autopairs").setup({})
require('mini.comment').setup({})
require('mini.surround').setup({})
require('mini.ai').setup({

})
require('mini.bufremove').setup({})

local dap = require("dap")
require("dapui").setup()

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

saga.init_lsp_saga({
  custom_kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
  border_style = "rounded",
  code_action_icon = "⌁",
  code_action_lightbulb = {
    enable = true,
    enable_in_insert = false,
    cache_code_action = true,
    sign = true,
    update_time = 150,
    sign_priority = 20,
    virtual_text = true,
  },
})

require("lsp_signature").setup({
  bind = true, -- This is mandatory, otherwise border config won't get registered.
  handler_opts = {
    border = "rounded",
  },
  max_width = 120,
  max_height = 30,
  doc_lines = 20,
  wrap = true,
  -- hi_parameter = "DiagnosticHint", -- Highlight group name to use for active param
  hint_enable = false,
  toggle_key = '<C-x>'
})

telescope.setup {
  pickers = {
    lsp_references = {
      show_line = false,
      fname_width = 60
    }
  },
  defaults = {
    file_ignore_patterns = { ".git/" },
    layout_config = {
      horizontal = {
        prompt_position = "top"
      }
    }
  },
  extensions = {
    file_browser = {
      hijack_netrw = true,
      -- mappings = {
      --   ["i"] = {
      --     -- remap to going to home directory
      --     ["<C-CR>"] = filebrowser_actions.create_from_prompt
      --   },
      -- }
    }
  }
}
telescope.load_extension("file_browser")

local function named_opts(desc)
  return { noremap = true, silent = true, desc = desc }
end

local opts = { noremap = true, silent = true }
local keymap = vim.keymap

-- Colemak essentials
-- keymap.set('n', 'n', 'j')
-- keymap.set('v', 'n', 'j')
-- keymap.set('n', 'e', 'k')
-- keymap.set('v', 'e', 'k')
-- keymap.set('n', 'i', 'l')
-- keymap.set('v', 'i', 'l')
local colemak_mode = false
local function colemak_toggle()
  if colemak_mode then
    keymap.set('n', 'n', 'n')
    keymap.set('v', 'n', 'n')
    keymap.set('n', 'e', 'e')
    keymap.set('v', 'e', 'e')
    keymap.set('n', 'i', 'i')
    keymap.set('v', 'i', 'i')
    colemak_mode = false
  else
    keymap.set('n', 'n', 'j')
    keymap.set('v', 'n', 'j')
    keymap.set('n', 'e', 'k')
    keymap.set('v', 'e', 'k')
    keymap.set('n', 'i', 'l')
    keymap.set('v', 'i', 'l')
    colemak_mode = true
  end
  print('Toggled Colemak to ' .. tostring(colemak_mode))
end

-- Navigate a bit in insert mode
keymap.set('i', '<C-h>', '<left>')
keymap.set('i', '<C-j>', '<down>')
keymap.set('i', '<C-k>', '<up>')
keymap.set('i', '<C-l>', '<right>')

-- Swap lines up and down
keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

keymap.set("n", "<leader>sub", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

keymap.set('n', '<C-s>', ':w<CR>', opts)
keymap.set('i', '<C-s>', '<esc>:w<CR>', opts)
keymap.set('v', '<C-s>', '<esc>:w<CR>', opts)
keymap.set('i', 'jk', '<esc>', opts)

keymap.set('n', '<leader>p', '"+p', named_opts('Paste from clipboard'))
keymap.set('x', '<leader>p', '"_dP', named_opts('Paste preserving register'))

-- leader yank to clipboard
keymap.set('n', '<leader>y', '"+y', named_opts("Yank to clipboard"))
keymap.set('n', '<leader>Y', '"+Y', named_opts("Yank to clipboard"))
keymap.set('v', '<leader>y', '"+y', named_opts("Yank to clipboard"))
keymap.set('v', '<leader>Y', '"+Y', named_opts("Yank to clipboard"))

keymap.set('n', '<C-d>', '<C-d>zz', named_opts("Page down (centered)"))
keymap.set('n', '<C-u>', '<C-u>zz', named_opts("Page up (centered)"))

keymap.set('n', '<C-J>', "<cmd>cnext<cr>")
keymap.set('n', '<C-K>', "<cmd>cprev<cr>")

-- Do not yank with x
keymap.set('n', 'x', '"_x', opts)

-- Increment/decrement
keymap.set('n', '+', '<C-a>', opts)
keymap.set('n', '-', '<C-x>', opts)

keymap.set('n', '<leader>M', telescope.extensions.metals.commands, named_opts('Metals command picker'))
keymap.set('n', '<leader>f', '<cmd>Telescope file_browser path=%:p:h<cr>', named_opts('Open file browser'))
keymap.set('n', '<leader> ', '<cmd>Telescope find_files hidden=true<cr>', named_opts('Find file'))
keymap.set('n', '<leader>/', require('telescope.builtin').live_grep, named_opts('Search Workspace'))

-- LSP
keymap.set('n', '<leader>r', "<cmd>Lspsaga rename<cr>", named_opts('Rename'))
keymap.set('n', '<leader>e', require('telescope.builtin').lsp_dynamic_workspace_symbols,
  named_opts('LSP Workspace Symbols'))
keymap.set('n', '<leader>k', "<cmd>Lspsaga hover_doc<CR>", named_opts('LSP Hover (docs)'))
keymap.set('n', '<leader>.', "<cmd>Lspsaga code_action<CR>", named_opts('Code Action'))
keymap.set('n', 'gi', vim.lsp.buf.implementation, named_opts('[G]o [I]mplementation'))
keymap.set('n', 'gr', require('telescope.builtin').lsp_references, named_opts('Find references'))
keymap.set("n", "[d", vim.diagnostic.goto_next, named_opts("Next Diagnostic"))
keymap.set("n", "]d", vim.diagnostic.goto_prev, named_opts("Prev Diagnostic"))
keymap.set("n", "[e", function()
  require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, { silent = true })
keymap.set("n", "]e", function()
  require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
end, { silent = true })
keymap.set("n", "<tab>", vim.lsp.buf.format, named_opts("Format buffer"))
-- Enter and Backspace for navigation
-- TODO: this is messing up qflist and loclist
keymap.set('n', '<cr>', vim.lsp.buf.definition, named_opts('Go to definition'))
keymap.set('n', '<bs>', "<C-o>", named_opts('Go back'))

-- <leader>s for Show
keymap.set('n', '<leader>sg', '<cmd>Gitsigns preview_hunk_inline<cr>', named_opts('Show diff'))
keymap.set('n', '<leader>sb', '<Cmd>Gitsigns toggle_current_line_blame<CR>', named_opts('Blame'))
keymap.set('n', '<leader>sl', vim.diagnostic.open_float, named_opts('Line diagnostics'))

-- B for buffers
keymap.set('n', '<leader>bd', '<cmd>bdelete<cr>', named_opts('Close buffer'))
keymap.set('n', '<leader>bl', require('telescope.builtin').buffers, named_opts('Open buffer picker'))

-- d for debug
keymap.set('n', '<leader>dc', dap.continue, named_opts('Go (continue)'))
keymap.set('n', '<leader>dt', dap.repl.toggle, named_opts('Toggle debug repl'))

keymap.set('n', '<leader>w', "<C-w>", named_opts('+window'))
keymap.set('n', '<C-w><cr>', "<cmd>only<cr>", named_opts('Close other windows'))

keymap.set('n', '<leader>1', '<Cmd>NvimTreeFindFileToggle<CR>', named_opts("Tree"))

keymap.set('n', '<leader>q', '<cmd>q<cr>', named_opts('Quit window'))

-- <leader>h for help
function edit_neovim()
  require('telescope.builtin').find_files {
    hidden = true,
    cwd = "~/.config/nvim",
    layout_strategy = 'horizontal',
  }
end

keymap.set('n', '<leader>ho', '<cmd>lua edit_neovim()<cr>', named_opts('Open config dir'))
keymap.set('n', '<leader>hr', '<cmd>source<cr>', named_opts('Source current buffer'))
keymap.set('n', '<leader>htc', colemak_toggle, named_opts('Toggle -> Colemak'))

keymap.set('n', '<leader>x', require('telescope.builtin').diagnostics, named_opts('Workspace Diagnostics'))

-- Goto
local harpoon_ui = require('harpoon.ui')
local harpoon_mark = require('harpoon.mark')
local harpoon_tmux = require('harpoon.tmux')

keymap.set('n', 'gn', '<Cmd>bnext<CR>', named_opts('Next Buffer'))
keymap.set('n', 'gp', '<Cmd>bprevious<CR>', named_opts('Previous Buffer'))

-- <leader>m for 'mark'
keymap.set('n', 'gl', harpoon_ui.toggle_quick_menu, named_opts('Harpoon UI'))
keymap.set('n', 'ga', harpoon_mark.add_file, named_opts('Harpoon Add'))
keymap.set('n', 'g1', function() harpoon_ui.nav_file(1) end, named_opts('Harpoon 1'))
keymap.set('n', 'g2', function() harpoon_ui.nav_file(2) end, named_opts('Harpoon 2'))
keymap.set('n', 'g3', function() harpoon_ui.nav_file(3) end, named_opts('Harpoon 3'))
keymap.set('n', 'g4', function() harpoon_ui.nav_file(4) end, named_opts('Harpoon 3'))

-- Forward / Back
keymap.set("n", "] ", "o<esc>", named_opts("New line down"))
keymap.set("n", "[ ", "O<esc>", named_opts("New line up"))
keymap.set("n", "]g", "<cmd>Gitsigns next_hunk<cr>", named_opts("Next hunk"))
keymap.set("n", "[g", "<cmd>Gitsigns prev_hunk<cr>", named_opts("Prev hunk"))
keymap.set("n", "<leader>z", '<cmd>Gitsigns reset_hunk<CR>')

local Terminal = require('toggleterm.terminal').Terminal
local lazygit  = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })

function Lazygit_Toggle()
  lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua Lazygit_Toggle()<CR>",
  { noremap = true, silent = true, desc = "lazygit" })

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local default_autogroup = augroup('HighlightYank', {})

autocmd('TextYankPost', {
  group = default_autogroup,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({
      higroup = 'IncSearch',
      timeout = 50,
    })
  end,
})

--Format async on Save
require("lsp-format").setup()
local on_attach = function(client)
  require("lsp-format").on_attach(client)

  -- ... custom code ...
end

-- Important
require("duck").setup {
  character = "🦆",
  winblend = 100, -- 0 to 100
  speed = 1, -- optimal: 1 to 99
  width = 2
}

keymap.set('n', '<leader>Dk', function() require("duck").cook('🎄') end, named_opts("Kill tree"))
