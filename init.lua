require('globals')
require('base')

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
local plugins = {
  { 'navarasu/onedark.nvim', lazy = true },
  { "catppuccin/nvim",       name = "catppuccin", lazy = true },
  {
    "shaunsingh/nord.nvim",
    lazy = true,
    -- config = function()
    --   -- Example config in lua
    --   vim.g.nord_contrast = true
    --   vim.g.nord_borders = false
    --   vim.g.nord_disable_background = false
    --   vim.g.nord_italic = false
    --   -- vim.g.nord_uniform_diff_background = true
    --   vim.g.nord_bold = true
    --
    --   -- Load the colorscheme
    --   require('nord').set()
    -- end,
  },
  -- {
  --   "neanias/everforest-nvim",
  --   lazy = false,
  --   version = false,
  --   config = function()
  --     require("everforest").setup {
  --       background = "hard",
  --       disable_italic_comments = true,
  --     }
  --   end
  -- },
  -- { "pgdouyon/vim-yin-yang",   lazy = true },
  -- { 'rebelot/kanagawa.nvim',   lazy = true },
  {
    "EdenEast/nightfox.nvim",
    opts = {
      palettes = {

      }

    },
    config = function()
      vim.cmd("colorscheme nightfox")
    end
  },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "j-hui/fidget.nvim",
    opts = {
      -- options
    },
  },

  'echasnovski/mini.nvim',
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      quickfile = { enabled = false },
      scratch = { enabled = true },
      terminal = { enabled = true },
      git = { enabled = true },
      lazygit = { enabled = true },
    },
    keys = {
      { "<leader>z",  function() Snacks.zen() end,                desc = "Toggle Zen Mode" },
      { "<leader>Z",  function() Snacks.zen.zoom() end,           desc = "Toggle Zoom" },
      { "<leader>.",  function() Snacks.scratch() end,            desc = "Toggle Scratch Buffer" },
      { "<leader>S",  function() Snacks.scratch.select() end,     desc = "Select Scratch Buffer" },
      { "<leader>bd", function() Snacks.bufdelete() end,          desc = "[d]elete Buffer" },
      { "<leader>br", function() Snacks.rename.rename_file() end, desc = "[r]ename File" },
      { "<leader>gB", function() Snacks.gitbrowse() end,          desc = "Git Browse" },
      { "<leader>gb", function() Snacks.git.blame_line() end,     desc = "Git Blame Line" },
      { "<leader>gf", function() Snacks.lazygit.log_file() end,   desc = "Lazygit Current File History" },
      { "<leader>gg", function() Snacks.lazygit() end,            desc = "Lazygit" },
      { "<leader>gl", function() Snacks.lazygit.log() end,        desc = "Lazygit Log (cwd)" },
      { "<c-\\>",     function() Snacks.terminal() end,           desc = "Toggle Terminal" },
      { "<c-_>",      function() Snacks.terminal() end,           desc = "which_key_ignore" },
    }
  },

  {
    'mikesmithgh/kitty-scrollback.nvim',
    enabled = true,
    lazy = true,
    cmd = { 'KittyScrollbackGenerateKittens', 'KittyScrollbackCheckHealth' },
    event = { 'User KittyScrollbackLaunch' },
    version = '*', -- latest stable version, may have breaking changes if major version changed
    -- version = '^6.0.0', -- pin major version, include fixes and features that do not have breaking changes
    config = function()
      require('kitty-scrollback').setup()
    end,
  },

  {
    'nvim-lualine/lualine.nvim',
    opts = {
      icons_enabled = false,
      theme = 'auto',
      sections = {
        lualine_x = { 'encoding' },
      }
    }
  },

  {
    'stevearc/dressing.nvim',
    opts = {},
  },

  { 'mg979/vim-visual-multi',                     branch = 'master', lazy = false },

  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
  },

  {
    'nanozuki/tabby.nvim',
    enabled = false,
    config = function()
      -- configs...
      local theme = {
        fill = 'TabLineFill',
        -- Also you can do this: fill = { fg='#f2e9de', bg='#907aa9', style='italic' }
        head = 'TabLine',
        current_tab = 'TabLineSel',
        tab = 'TabLine',
        win = 'TabLine',
        tail = 'TabLine',
      }
      require('tabby').setup({
        line = function(line)
          return {
            {
              { '  ', hl = theme.head },
              line.sep('', theme.head, theme.fill),
            },
            line.tabs().foreach(function(tab)
              local hl = tab.is_current() and theme.current_tab or theme.tab
              return {
                line.sep('', hl, theme.fill),
                tab.in_jump_mode() and tab.jump_key() or tab.number(),
                tab.name(),
                line.sep('', hl, theme.fill),
                hl = hl,
                margin = ' ',
              }
            end),
            line.spacer(),
            line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
              return {
                line.sep('', theme.win, theme.fill),
                win.is_current() and '' or '',
                win.buf_name(),
                line.sep('', theme.win, theme.fill),
                hl = theme.win,
                margin = ' ',
              }
            end),
            {
              line.sep('', theme.tail, theme.fill),
              { '   ', hl = theme.tail },
            },
            hl = theme.fill,
          }
        end,
        -- option = {}, -- setup modules' option,
      })
    end,
  },

  {
    'Shatur/neovim-session-manager',
    lazy = false,
    config = function()
      local config = require('session_manager.config')
      require('session_manager').setup {
        autoload_mode = { config.AutoloadMode.CurrentDir, config.AutoloadMode.LastSession }
      }
    end
  },


  {
    "nvim-telescope/telescope.nvim",
    version = "0.1.8",
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    }
  },
  { "nvim-telescope/telescope-file-browser.nvim", lazy = true },

  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    enabled = false,
    lazy = true,
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'nvim-treesitter/nvim-treesitter-context',
    },
    config = function()
      require('nvim-treesitter.configs').setup {
        -- Add languages to be installed here that you want installed for treesitter
        ensure_installed = { 'c', 'cpp', 'lua', 'python', 'rust', 'typescript', 'sql', 'scala', 'zig', 'vim', 'vimdoc' },

        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<c-=>',
            node_incremental = '<c-=>',
            scope_incremental = '<c-s>',
            node_decremental = '<c-->',
          },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              -- For now i prefer the text based ones since Scala treesitter is broken
              -- ['aa'] = '@parameter.outer',
              -- ['ia'] = '@parameter.inner',
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['ic'] = '@class.inner',
            },
          },
        },
      }

      require('treesitter-context').setup {
        enable = true,            -- Enable this plugin (Can be enabled/disabled later via commands)
        max_lines = 3,            -- How many lines the window should span. Values <= 0 mean no limit.
        min_window_height = 0,    -- Minimum editor window height to enable context. Values <= 0 mean no limit.
        line_numbers = true,
        multiline_threshold = 20, -- Maximum number of lines to collapse for a single context line
        trim_scope = 'outer',     -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        mode = 'topline',         -- Line used to calculate context. Choices: 'cursor', 'topline'
        -- Separator between context and content. Should be a single character string, like '-'.
        -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
        separator = nil,
        zindex = 20, -- The Z-index of the context window
      }
    end
  },

  'lewis6991/gitsigns.nvim',

  {
    'renerocksai/telekasten.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    lazy = true
  },

  {
    'stevearc/oil.nvim',
    lazy = false,
    enabled = true,
    opts = {
      columns = {
        "size", "mtime"
      },
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      keymaps = {
        ["<C-s>"] = false,
        ["q"] = "actions.close",
        ["<esc>"] = "actions.close",
      },
      view_options = {
        is_always_hidden = function(name, bufnr)
          return false
        end,
        sort = {
          { "mtime", "desc" }
        }
      }
    },
    keys = {
      { "-", "<cmd>lua require('oil').toggle_float()<cr>", desc = "Open file browser" }
    },
  },

  {
    'neovim/nvim-lspconfig',
    lazy = true,
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then return end
          if client.supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({
                  bufnr = args.buf,
                  id = client.id,
                  async = false
                })
              end
            })
          end
        end
      })
    end
  },
  'rrethy/vim-illuminate',
  {
    'folke/trouble.nvim',
    cmd = "Trouble",
    opts = {
      auto_preview = false
    },
    keys = {
      {
        "<leader>d",
        "<cmd>Trouble diagnostics toggle filter.severity=vim.diagnostic.severity.ERROR focus=true<cr>",
        desc =
        "Buffer [D]iagnostics (Trouble)"
      }
    }
  },
  {
    'stevearc/overseer.nvim',
    event = "VeryLazy",
    keys = {
      { "<leader>tr", "<cmd>OverseerRunCmd<cr>",      desc = "[T]ask [R]un" },
      { "<leader>2",  "<cmd>OverseerToggle<cr>",      desc = "[T]oggle [t]asks" },
      { "<leader>tt", "<cmd>OverseerToggle<cr>",      desc = "[T]oggle [t]asks" },
      { "<leader>ta", "<cmd>OverseerQuickAction<cr>", desc = "[T]ask [a]ction" },
      { "<leader>t.", "<cmd>OverseerRestartLast<cr>", desc = "[T]ask repeat" },
    },
    config = function()
      local overseer = require("overseer")
      overseer.setup({
        task_list = {
          direction = "left",
          bindings = {
            ["r"] = "<CMD>OverseerQuickAction restart<CR>",
            ["<leader>tt"] = "<cmd>OverseerToggle<cr>",
          },
        },
        component_aliases = {
          default = {
            { "display_duration", detail_level = 2 },
            "on_output_summarize",
            "on_exit_set_status",
            "on_complete_notify",
          }
        }
      })
      overseer.load_task_bundle('k1', { autostart = false })
      vim.api.nvim_create_user_command("OverseerRestartLast", function()
        local overseer = require("overseer")
        local tasks = overseer.list_tasks({ recent_first = true })
        if vim.tbl_isempty(tasks) then
          vim.notify("No tasks found", vim.log.levels.INFO)
        else
          overseer.run_action(tasks[1], "restart")
        end
      end, {})
    end
  },

  {
    'saghen/blink.cmp',
    lazy = false,
    -- dependencies = 'rafamadriz/friendly-snippets',

    -- use a release tag to download pre-built binaries
    version = 'v0.*',
    -- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = 'enter'
      },
      appearance = {
        -- Sets the fallback highlight groups to nvim-cmp's highlight groups
        -- Useful for when your theme doesn't support blink.cmp
        -- will be removed in a future release
        use_nvim_cmp_as_default = true,
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono'
      },
      completion = {
        trigger = {
          show_on_keyword = false,
          show_on_trigger_character = false,
        },
        accept = { auto_brackets = { enabled = true } },
        ghost_text = { enabled = false },
        menu = {
          auto_show = true,
        },
      },
      sources = {
        default = { "lazydev", "lsp", "path" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,
          },
        },
      },

      signature = {
        enabled = true,
        trigger = {
          show_on_insert = true
        }
      }
    }
  },
  { 'scalameta/nvim-metals', dependencies = { 'nvim-lua/plenary.nvim' }, lazy = true },

  {
    'zbirenbaum/copilot.lua',
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = false,
          keymap = {
            accept = "<C-CR>",
            accept_word = false,
            accept_line = false,
            next = "<tab>",
            prev = false,
            dismiss = "<C-e>",
          }
        }
      })
    end,
  },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {
      highlight = {
        backdrop = false,
        matches = false,
      },
      label = {
        style = "overlay"
      }
    },
    -- stylua: ignore
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,   desc = "Flash" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end, desc = "Toggle Flash Search" },
      -- { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      -- { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      -- { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    },
  }

}

require("lazy").setup(plugins, opts)

-- todo: finish setting up copilot https://github.com/zbirenbaum/copilot.lua?ref=tamerlan.dev

-- require("bufferchad").setup({
--   mapping = "<leader>bb",       -- Map any key, or set to NONE to disable key mapping
--   mark_mapping = "<leader>bm",  -- The keybinding to display just the marked buffers
--   order = "LAST_USED_UP",       -- LAST_USED_UP (default)/ASCENDING/DESCENDING/REGULAR
--   style = "default",            -- default, modern (requires dressing.nvim and nui.nvim), telescope (requires telescope.nvim)
--   close_mapping = "<Esc><Esc>", -- only for the default style window.
-- })
