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
  vim.keymap.set('n', 'gs', require('telescope.builtin').lsp_dynamic_workspace_symbols,
    named_opts('[G]oto [S]ymbols lsp'))
  vim.keymap.set('n', 'gd', vim.lsp.buf.declaration, named_opts('[G]o [I]mplementation'))
  vim.keymap.set("n", "[e", function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end,
    named_opts("Prev [E]rror"))
  vim.keymap.set("n", "]e", function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end,
    named_opts("Next [E]rror"))
  vim.keymap.set("n", "<leader>d", function()
    vim.fn.setqflist({}, 'r', { title = "Diagnostics" })
    vim.diagnostic.setqflist({ severity = { min = vim.diagnostic.severity.WARN } })
  end, named_opts("[D]iagnostics"))
  vim.keymap.set("n", "<leader>D",
    function()
      vim.fn.setqflist({}, 'r', { title = "Diagnostics" })
      vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.ERROR })
    end,
    named_opts("[D]iagnostics"))
  vim.keymap.set("n", "gfb", vim.lsp.buf.format, named_opts("[G]o [F]ormat [B]uffer"))
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    -- Enable underline, use default values
    underline = false,
    -- Enable virtual text only on Warning or above, override spacing to 2
    virtual_text = false,
    -- virtual_text = {
    --   spacing = 2,
    --   min = "Error",
    -- },
  }
)

--vim.lsp.config('lua_ls', {
--  settings = {
--    Lua = {
--      diagnostics = {
--        globals = { 'vim' }
--      }
--    }
--  },
--  capabilities = capabilities,
--  on_attach = on_attach,
--})
--vim.lsp.enable('lua_ls')
