vim.api.nvim_create_autocmd({ 'BufEnter', 'BufNewFile' }, {
  pattern = '*.k1',
  callback = function(event)
    vim.cmd [[ set filetype=k1 ]]
    vim.cmd [[ set syntax=rust ]]
  end,
})

on_attach = function(client, bufnr)
  vim.lsp.inlay_hint.enable(true, { 0 })

  local function named_opts(desc)
    return { noremap = true, silent = true, desc = desc, buffer = bufnr }
  end

  -- LSP
  vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, named_opts('Rename'))
  vim.keymap.set('n', 'gs', require('telescope.builtin').lsp_dynamic_workspace_symbols,
    named_opts('[G]oto [S]ymbols lsp'))
  vim.keymap.set('n', '<leader>k', vim.lsp.buf.hover, named_opts('LSP Hover'))
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, named_opts('LSP Hover'))
  vim.keymap.set('n', 'g.', vim.lsp.buf.code_action, named_opts('[G]oto Edits (.)'))
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, named_opts('[G]o [I]mplementation'))
  vim.keymap.set('n', 'gd', vim.lsp.buf.declaration, named_opts('[G]o [I]mplementation'))
  vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, named_opts('[G]o [R]eference'))
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, named_opts("Next [D]iagnostic"))
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, named_opts("Prev [D]iagnostic"))
  vim.keymap.set("n", "[e", function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end,
    named_opts("Prev [E]rror"))
  vim.keymap.set("n", "]e", function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end,
    named_opts("Next [E]rror"))
  -- Enter and Backspace for navigation
  vim.keymap.set('n', '<cr>', vim.lsp.buf.definition, named_opts('Go to definition'))
end

-- require("lsp_signature").setup({
--   bind = true, -- This is mandatory, otherwise border config won't get registered.
--   handler_opts = {
--     border = "single",
--   },
--   max_width = 120,
--   max_height = 30,
--   doc_lines = 20,
--   wrap = true,
--   -- hi_parameter = "DiagnosticHint", -- Highlight group name to use for active param
--   hint_enable = true,
--   hint_prefix = " ",
--   toggle_key = '<C-x>'
-- })
--


require("illuminate").configure {
  delay = 0,
  filetypes_denylist = {
    'NvimTree', 'TelescopePrompt'
  },

}
--vim.cmd [[ hi! IlluminatedWordText  gui=underline]]
--vim.cmd [[ hi! IlluminatedWordRead  gui=underline]]
--vim.cmd [[ hi! IlluminatedWordWrite gui=underline]]

vim.keymap.set('n', '<leader>th', require('illuminate').toggle)

-- local capabilities = require('cmp_nvim_lsp').default_capabilities()
local capabilities = {}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    -- Enable underline, use default values
    underline = true,
    -- Enable virtual text only on Warning or above, override spacing to 2
    virtual_text = false,
    -- virtual_text = {
    --   spacing = 2,
    --   min = "Error",
    -- },
  }
)

require('lspconfig')['rust_analyzer'].setup {
  -- Server-specific settings...
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        features = { "lsp" }
      },
      -- enable clippy on save
      checkOnSave = {
        command = "clippy"
      },
      diagnostics = {
        enable = true,
      },
      inlayHints = {
        chainingHints = {
          enable = false
        },
        parameterHints = {
          enable = false
        }
      },
    }
  },
  capabilities = capabilities,
  on_attach = on_attach
}

-- require("typescript").setup({
--   disable_commands = false, -- prevent the plugin from creating Vim commands
--   debug = false, -- enable debug logging for commands
--   go_to_source_definition = {
--     fallback = true, -- fall back to standard LSP definition on failure
--   },
--   server = { -- pass options to lspconfig's setup method
--     capabilities = capabilities,
--     on_attach = on_attach
--   },
-- })
--

require('lspconfig').ocamllsp.setup {
  capabilities = capabilities,
  on_attach = on_attach
}

require('lspconfig').clangd.setup {
  capabilities = capabilities,
  on_attach = on_attach
}

require 'lspconfig'.lua_ls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

-- require('lspconfig').tailwindcss.setup {
--
-- }
--
-- require('lspconfig').terraformls.setup {
--
-- }

-- require('lspconfig').clangd.setup {
--   capabilities = capabilities,
--   on_attach = on_attach
-- }
--
-- require('lspconfig').zls.setup {
--   capabilities = capabilities,
--   on_attach = on_attach
-- }

--Format async on Save
-- require("lsp-format").setup()
