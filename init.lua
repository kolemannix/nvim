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
  {
    "webhooked/kanso.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("kanso").setup {
        bold = true,
        italics = false,
        keywordStyle = { italic = false },
        background = {
          dark = "zen",
          light = "pearl"
        },
        foreground = {
          -- dark = "saturated",
          -- light = "saturated"
        }
      }
      vim.cmd("colorscheme kanso")
      vim.defer_fn(function() 
        for _, group in ipairs({
          "DiagnosticUnderlineError",
          "DiagnosticUnderlineWarn",
          "DiagnosticUnderlineInfo",
          "DiagnosticUnderlineHint",
        }) do
          local hl = vim.api.nvim_get_hl(0, { name = group })
          hl.undercurl = false
          hl.underline = true
          hl.bold = false
          vim.api.nvim_set_hl(0, group, hl)
        end
      end, 50)
      vim.defer_fn(function() require('knixstatusline').setup() end, 100)
    end
  },
  {
    "j-hui/fidget.nvim",
    opts = {
      -- options
    },
  },

  'echasnovski/mini.nvim',

  {
    "nvim-telescope/telescope.nvim",
    -- version = "0.1.8",
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      {
        "nvim-telescope/telescope-live-grep-args.nvim",
        -- This will not install any breaking changes.
        -- For major updates, this must be adjusted manually.
        version = "^1.0.0",
      },
    }
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
      local format_on_save = false
      if format_on_save then
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
    end
  },

  {
    'saghen/blink.cmp',
    lazy = false,
    -- dependencies = 'rafamadriz/friendly-snippets',

    -- use a release tag to download pre-built binaries
    version = '1.*',
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
          auto_show = false,
        },
      },
      sources = {
        default = { "lsp", "path" },
      },

      signature = {
        enabled = true,
        trigger = {
          show_on_insert = true
        }
      }
    }
  },
  { 'scalameta/nvim-metals',          dependencies = { 'nvim-lua/plenary.nvim' }, lazy = true },

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
  },
  { "ntpeters/vim-better-whitespace", lazy = false },
  {
    'rebelot/kanagawa.nvim',
    enabled = false,
    lazy = false,
    config = function()
      require('kanagawa').setup {
        keywordStyle = { italic = false },
        commentStyle = { italic = false },
        statementStyle = { bold = true },
        transparent = false,
        background = {
          dark = "dragon"
        }
      }
      -- vim.cmd [[ colorscheme kanagawa-dragon ]]
    end
  },
}

require("lazy").setup(plugins, opts)

require('globals')

vim.lsp.enable('rust_analyzer')
vim.lsp.enable('clangd')

vim.api.nvim_create_user_command("R", function(opts)
  -- Expand % and # BEFORE opening new buffer
  local current = vim.fn.expand "%:p"
  local alt = vim.fn.expand "#:p"
  local cmd = opts.args:gsub("%%:p", current):gsub("%%", current):gsub("#", alt)
  vim.cmd "new"
  vim.bo.buftype = "nofile"
  vim.bo.bufhidden = "hide"
  vim.bo.swapfile = false
  vim.b.no_auto_close = true
  vim.fn.termopen(cmd, {
    on_stdout = function()
      vim.schedule(function()
        vim.cmd [[ stopinsert ]]
        vim.api.nvim_feedkeys("G", "t", false)
      end)
    end,
  })
  vim.api.nvim_buf_set_keymap(0, "n", "q", ":q!<CR>", { noremap = true, silent = true })
end, { nargs = "+", complete = "shellcmdline" })
