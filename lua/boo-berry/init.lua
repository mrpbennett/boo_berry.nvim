-- boo-berry.nvim
-- A Neovim colorscheme ported from Helix editor's boo_berry theme (by bootra)

local g = vim.g
local nvim_set_hl = vim.api.nvim_set_hl
local tbl_deep_extend = vim.tbl_deep_extend

---@class BooberryConfig
---@field italic_comment? boolean
---@field transparent_bg? boolean
---@field show_end_of_buffer? boolean
---@field lualine_bg_color? string?
---@field colors? BooberryPalette
---@field overrides? table<string, vim.api.keyset.highlight> | fun(colors: BooberryPalette): table<string, vim.api.keyset.highlight>

local DEFAULT_CONFIG = {
	italic_comment = false,
	transparent_bg = false,
	show_end_of_buffer = false,
	lualine_bg_color = nil,
	colors = require("boo-berry.palette"),
	overrides = {},
}

local TRANSPARENTS = {
	"Normal",
	"SignColumn",
	"NvimTreeNormal",
	"NvimTreeVertSplit",
	"NeoTreeNormal",
	"NeoTreeNormalNC",
}

local function apply_term_colors(colors)
	g.terminal_color_0 = colors.black
	g.terminal_color_1 = colors.red
	g.terminal_color_2 = colors.green
	g.terminal_color_3 = colors.yellow
	g.terminal_color_4 = colors.purple
	g.terminal_color_5 = colors.pink
	g.terminal_color_6 = colors.cyan
	g.terminal_color_7 = colors.white
	g.terminal_color_8 = colors.gutter_fg
	g.terminal_color_9 = colors.bright_red
	g.terminal_color_10 = colors.bright_green
	g.terminal_color_11 = colors.bright_yellow
	g.terminal_color_12 = colors.bright_blue
	g.terminal_color_13 = colors.bright_magenta
	g.terminal_color_14 = colors.bright_cyan
	g.terminal_color_15 = colors.bright_white
end

---@type BooberryConfig
local user_config = {}

local M = {}

--- Return the current resolved palette
---@return BooberryPalette
function M.colors()
	local config = tbl_deep_extend("force", DEFAULT_CONFIG, user_config)
	return config.colors
end

--- Configure the theme (call before `colorscheme boo-berry`)
---@param config? BooberryConfig
function M.setup(config)
	user_config = config or {}
end

--- Apply the colorscheme
function M.load()
	if vim.version().minor < 8 then
		vim.notify("boo-berry.nvim requires Neovim >= 0.8", vim.log.levels.ERROR)
		return
	end

	-- Reset existing highlights
	vim.api.nvim_command("hi clear")
	if vim.fn.exists("syntax_on") then
		vim.api.nvim_command("syntax reset")
	end

	vim.o.background = "dark"
	vim.o.termguicolors = true
	g.colors_name = "boo-berry"

	local config = tbl_deep_extend("force", DEFAULT_CONFIG, user_config)
	local colors = config.colors
	local highlights = require("boo-berry.highlights").setup(colors, config)

	-- Apply user overrides
	local overrides = config.overrides
	if type(overrides) == "function" then
		overrides = overrides(colors)
	end
	highlights = tbl_deep_extend("force", highlights, overrides or {})

	-- Set all highlight groups
	for group, hl in pairs(highlights) do
		nvim_set_hl(0, group, hl)
	end

	-- Handle transparent background
	if config.transparent_bg then
		for _, group in ipairs(TRANSPARENTS) do
			nvim_set_hl(0, group, { bg = "NONE" })
		end
	end

	apply_term_colors(colors)
end

return M
