
-- this file is not being used for now but will be when i switch to init.lua
-- local function lowercaseMode()
-- 	return require('lualine.components.mode'):lower()
-- end
require'lualine'.setup {
  options = {
	icons_enabled = true,
	theme = 'oceanicnext', -- vim.g.colors_name,
	component_separators = {'', ''},
	section_separators = {'', ''},
	disabled_filetypes = {}
  },
  tabline = {
	lualine_a = {'mode'},
	lualine_b = {'branch'},
	lualine_c = {'filename'},
	lualine_x = {'encoding', 'fileformat', 'filetype'},
	lualine_y = {'progress'},
	lualine_z = {'location'}
  },
  -- inactive_sections = {
	-- lualine_a = {},
	-- lualine_b = {},
	-- lualine_c = {'filename'},
	-- lualine_x = {'location'},
	-- lualine_y = {},
	-- lualine_z = {}
  -- },
  sections = {},
  inactive_sections = {},
  extensions = {}
}
