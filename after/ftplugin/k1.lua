local stdlib_dir = "/Users/knix/dev/k1/k1lib"
-- local lsp_binary = "/Users/knix/dev/k1/target/release/lsp"
local lsp_binary = "/Users/knix/dev/k1/target/debug/lsp"

-- vim.diagnostic.config({
--   update_in_insert = true
-- })

function Start_K1(reuse)
  -- vim.cmd [[ colorscheme carbonfox  ]]
  local opts = nil
  if reuse then
    opts = {
      reuse_client = function(client, config)
        return false
      end
    }
  end
  local buf = vim.api.nvim_get_current_buf()
  local file = vim.api.nvim_buf_get_name(buf)
  local root_dir = vim.fs.dirname(file)
  vim.lsp.start({
    name = 'k1-lsp',
    cmd = { lsp_binary },
    cmd_env = { K1_LIB_DIR = stdlib_dir, RUST_BACKTRACE = '1' },
    -- root_dir = vim.fs.dirname(vim.buf),
    root_dir = root_dir
  }, opts)
end

Start_K1()

local function named_opts(desc)
  return { noremap = true, silent = true, desc = desc }
end

vim.api.nvim_create_user_command("K1reload", function(args)
  local c = vim.system({ './build_lsp.sh' }):wait()
  if c.code ~= 0 then
    vim.cmd.echomsg('Failed')
    return
  end
  local k1_clients = vim.lsp.get_clients({ name = 'k1-lsp' })
  for i, client in ipairs(k1_clients) do
    -- Only detaches the current buffer, good enough for now
    vim.lsp.buf_detach_client(0, client.id)
  end
  vim.lsp.stop_client(k1_clients)
  Start_K1()
end, { desc = "Re-compile and reload K1 lsp server" })

-- LSP
vim.keymap.set('n', 'gs', require('telescope.builtin').lsp_dynamic_workspace_symbols,
  named_opts('[G]oto [S]ymbols lsp'))
vim.keymap.set('n', '<leader>k', vim.lsp.buf.hover, named_opts('LSP Hover'))
vim.keymap.set('n', 'K', vim.lsp.buf.hover, named_opts('LSP Hover'))
vim.keymap.set('n', 'g.', vim.lsp.buf.code_action, named_opts('[G]oto Edits (.)'))
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, named_opts('[G]o [I]mplementation'))
vim.keymap.set('n', 'gd', vim.lsp.buf.declaration, named_opts('[G]o [I]mplementation'))
vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, named_opts('[G]o [R]eference'))
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
