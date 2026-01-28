require('base')

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufNewFile' }, {
  pattern = '*.k1',
  callback = function(event)
    vim.cmd [[ set filetype=k1 ]]
    vim.cmd [[ set syntax=rust ]]
  end,
})

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

  { 'nvim-mini/mini.nvim', version = '*' },

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
  {
    "scalameta/nvim-metals",
    ft = { "scala", "sbt", "java" },
    opts = function()
      local metals_config = require("metals").bare_config()
      metals_config.on_attach = on_attach
      return metals_config
    end,
    config = function(self, metals_config)
      local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = self.ft,
        callback = function()
          require("metals").initialize_or_attach(metals_config)
        end,
        group = nvim_metals_group,
      })
    end
  },
  {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    config = function()
        local mc = require("multicursor-nvim")
        mc.setup()

        local set = vim.keymap.set

        -- Add or skip cursor above/below the main cursor.
        set({"n", "x"}, "<leader>K", function() mc.lineAddCursor(-1) end)
        set({"n", "x"}, "<leader>J", function() mc.lineAddCursor(1) end)
        set({"n", "x"}, "<leader>K", function() mc.lineSkipCursor(-1) end)
        set({"n", "x"}, "<leader>J", function() mc.lineSkipCursor(1) end)

        -- Add or skip adding a new cursor by matching word/selection
        set({"n", "x"}, "<leader>N", function() mc.matchAddCursor(1) end)
        set({"n", "x"}, "<leader>s", function() mc.matchSkipCursor(1) end)
        set({"n", "x"}, "<leader>N", function() mc.matchAddCursor(-1) end)
        set({"n", "x"}, "<leader>S", function() mc.matchSkipCursor(-1) end)

        -- Mappings defined in a keymap layer only apply when there are
        -- multiple cursors. This lets you have overlapping mappings.
        mc.addKeymapLayer(function(layerSet)

            -- Select a different cursor as the main one.
            layerSet({"n", "x"}, "<left>", mc.prevCursor)
            layerSet({"n", "x"}, "<right>", mc.nextCursor)

            layerSet({"n", "x"}, "<C-h>", mc.prevCursor)
            layerSet({"n", "x"}, "<C-l>", mc.nextCursor)
            layerSet({"n", "x"}, "<C-k>", mc.prevCursor)
            layerSet({"n", "x"}, "<C-j>", mc.nextCursor)

            -- Disable and enable cursors.
            set({"n", "x"}, "<c-q>", mc.toggleCursor)


            -- Align cursor columns.
            set("n", "<leader>a", mc.alignCursors)

            -- Delete the main cursor.
            layerSet({"n", "x"}, "<leader>x", mc.deleteCursor)

            -- Enable and clear cursors using escape.
            layerSet("n", "<esc>", function()
                if not mc.cursorsEnabled() then
                    mc.enableCursors()
                else
                    mc.clearCursors()
                end
            end)
        end)

        -- Customize how cursors look.
        local hl = vim.api.nvim_set_hl
        hl(0, "MultiCursorCursor", { reverse = true })
        hl(0, "MultiCursorVisual", { link = "Visual" })
        hl(0, "MultiCursorSign", { link = "SignColumn"})
        hl(0, "MultiCursorMatchPreview", { link = "Search" })
        hl(0, "MultiCursorDisabledCursor", { reverse = true })
        hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
        hl(0, "MultiCursorDisabledSign", { link = "SignColumn"})
    end
  }
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
