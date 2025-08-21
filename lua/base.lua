vim.cmd('autocmd!')

vim.g.mapleader = ' '

vim.keymap.set({ 'n', 'x' }, 's', '<Nop>')
vim.keymap.set("n", "`", "<nop>")
vim.keymap.set("n", "R", "<nop>")

vim.cmd [[ set clipboard+=unnamedplus ]]

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

vim.opt.showtabline = 0
vim.opt.sessionoptions = 'curdir,folds,globals,help,tabpages,terminal,winsize'

vim.opt.completeopt = menu, menuone, noselect


vim.wo.number = true
vim.opt.winborder = "rounded"

vim.opt.title = true
vim.opt.autoindent = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.hidden = true
vim.opt.errorbells = false
vim.opt.backup = false
vim.opt.showcmd = true
vim.opt.cmdheight = 1
vim.opt.laststatus = 2
vim.opt.expandtab = true
vim.opt.scrolloff = 10
vim.opt.shell = 'zsh'
vim.opt.backupskip = '/tmp/*,/private/tmp/*'
vim.opt.swapfile = false
vim.opt.inccommand = 'split'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.smarttab = true
vim.opt.breakindent = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.ai = true -- Auto indent
vim.opt.si = true -- Smart indent
vim.opt.wrap = false
vim.opt.backspace = 'start,eol,indent'
vim.opt.path:append { '**' } -- Finding files, search into subfolders
vim.opt.wildignore:append { '*/node_modules/*', '*/target/*' }
vim.opt.relativenumber = false
vim.opt.termguicolors = true
vim.opt.showmode = false
vim.opt.cursorline = true
vim.opt.cmdwinheight = 15

vim.opt.timeoutlen = 100
vim.opt.updatetime = 50

-- Add asterisks in block comments
vim.opt.formatoptions:append { 'r' }

vim.opt.signcolumn = 'yes'

vim.opt.grepprg = "rg --type-add 'k1:*.k1' --vimgrep --smart-case"

-- For Neovide
vim.opt.guifont = { "JetBrainsMonoNL Nerd Font", ":h12" }
vim.g.neovide_scale_factor = 1.5

vim.cmd [[ au BufRead,BufNewFile *.k1 set syntax=rust ]]

vim.cmd [[ autocmd QuickFixCmdPost [^l]* nested cwindow ]]
vim.cmd [[ autocmd QuickFixCmdPost    l* nested lwindow ]]
