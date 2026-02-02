local M = {}

M.Palette = {
  black                = "#090e13",
  red                  = "#c4746e",
  green                = "#8a9a7b",
  yellow               = "#c4b28a",
  blue                 = "#8ba4b0",
  magenta              = "#a292a3",
  cyan                 = "#8ea4a2",
  white                = "#a4a7a4",
  bright_black         = "#5c6066",
  bright_red           = "#e46876",
  bright_green         = "#87a987",
  bright_yellow        = "#e6c384",
  bright_blue          = "#7fb4ca",
  bright_magenta       = "#938aa9",
  bright_cyan          = "#7aa89f",
  bright_white         = "#c5c9c7",
  background           = "#090e13",
  foreground           = "#c5c9c7",
  cursor_color         = "#c5c9c7",
  selection_background = "#22262d",
  selection_foreground = "#c5c9c7",

  background_light     = '#111a23'
}

vim.cmd [[
set fillchars=vert:│

" Optional: give split separators a highlight group
highlight WinSeparator guifg=#c5c9c7 guibg=NONE
set winhighlight=VertSplit:WinSeparator
]]

M.setup = function()
  vim.api.nvim_set_hl(0, 'User1', { fg = M.Palette.green, bg = M.background_light })
  vim.api.nvim_set_hl(0, 'User2', { fg = M.Palette.foreground, bg = M.background_light })
  vim.api.nvim_set_hl(0, 'User3', { fg = M.Palette.red, bg = M.background_light })
  vim.api.nvim_set_hl(0, 'User4', { fg = M.Palette.white, bg = M.background_light })
  vim.api.nvim_set_hl(0, 'User6', { fg = M.Palette.yellow, bg = M.background_light })
  --vim.api.nvim_set_hl(0, 'StatusLine', { bg = M.background_light })

  local inspirations = {
    'every second counts',
    'Hello, World!',
    'this is water',
    'leaf, by niggle',
    'timshel'
  }
  math.randomseed(os.time())
  local random_index = math.random(#inspirations)
  local inspiration = inspirations[random_index]
  -- local s = '%1* ' .. inspiration .. '%*'

  vim.o.laststatus = 2
  vim.o.statusline = ''
  -- set statusline+=%6*\ %<%F%*            "full path
  -- set statusline+=%3*%m%*                "modified flag
  -- set statusline+=%4*\ %y%*              "file type
  -- vim.cmd [[ ]]
  -- vim.o.statusline = vim.o.statusline .. s
  vim.cmd [[
    set statusline+=%1*%=%5l%*             "current line
    set statusline+=%2*/%L%*               "total lines
    set statusline+=%1*%4v\ %*             "virtual column number
    set statusline+=%6*0x%04B\ %*          "character under cursor
  ]]
end

return M
