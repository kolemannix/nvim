local metals_config = require("metals").bare_config()

-- Example of settings
metals_config.settings = {
  showImplicitArguments = true,
}

-- *READ THIS*
-- I *highly* recommend setting statusBarProvider to true, however if you do,
-- you *have* to have a setting to display this in your statusline or else
-- you'll not see any messages from metals. There is more info in the help
-- docs about this
metals_config.init_options.statusBarProvider = "on"

-- Example if you are using cmp how to make sure the correct capabilities for snippets are set
-- metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Autocmd that will actually be in charging of starting the whole thing
local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  -- NOTE: You may or may not want java included here. You will need it if you
  -- want basic Java support but it may also conflict if you are using
  -- something like nvim-jdtls which also works on a java filetype autocmd.
  pattern = { "scala", "sbt", "java" },
  callback = function()
    require("metals").initialize_or_attach(metals_config)

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
  end,
  group = nvim_metals_group,
})
