-- vim.api.nvim_set_hl(0, 'IlluminatedWordText', vim.api.nvim_get_hl_by_name('Search', false))
-- vim.cmd [[ hi IlluminatedWordText NONE ]]
-- vim.cmd [[ hi! link IlluminatedWordText Search ]]
-- vim.cmd [[ hi! link IlluminatedWordRead Search ]]
-- vim.cmd [[ hi! link IlluminatedWordWrite guibg=#6c7086 ]]


-- Highlight instead of underline for illuminate
-- vim.cmd [[ hi! IlluminatedWordText  guibg=#38384d gui=NONE]]
-- vim.cmd [[ hi! IlluminatedWordRead  guibg=#38384d gui=NONE]]
-- vim.cmd [[ hi! IlluminatedWordWrite guibg=#38384d gui=NONE]]

-- require('ayu')
-- ayu.setup {
--   mirage = true,
-- }
--

-- require("catppuccin").setup({
--   no_italic = true,
--   no_underline = true,
-- })
-- vim.cmd [[ colorscheme catppuccin ]]

-- require('onedark').setup {
--   style = 'darker'
-- }
-- require('onedark').load()

-- Available values: 'hard', 'medium'(default), 'soft'

-- vim.o.background = "dark" -- or "light" for light mode
-- vim.cmd [[ let g:everforest_background = 'hard' ]]
-- vim.cmd [[ colorscheme everforest ]]
-- vim.cmd [[ highlight Normal ctermbg=NONE guibg=NONE ]]
-- vim.cmd [[ highlight Normal ctermbg=NONE guibg=NONE ]]
