# 🫐 boo-berry.nvim

A Neovim colorscheme ported from Helix editor's **boo_berry** theme (originally by [bootra](https://github.com/helix-editor/helix/blob/master/runtime/themes/boo_berry.toml)).

![visual](assets/visual.png)

## Why You'll Love This Theme

Some themes are _berry_ boring. Others are just _boo_-ring. But boo-berry? It's got **bubblegum** for your keywords, **mint** fresh highlights for your functions, and a **berry** dark background that won't spook your eyes at 2am.

It's not just a colorscheme—it's a **lilac**-dream for your code. The **violet** types will make you feel fancy, the **gold** strings will make you feel rich (mentally, at least), and the **mint** green will remind you to breathe.

Still not convinced? That's okay—we won't take it **bubblegum**-ographically. But once you go **berry** dark, you never go back.

_Warning: May cause excessive "ooh, pretty" moments. Side effects include showing your screen to coworkers and saying "look at my colors" unprompted._

## Palette

| Name              | Hex       | Role                               |
| ----------------- | --------- | ---------------------------------- |
| berry             | `#3A2A4D` | Background                         |
| berry_saturated   | `#2B1C3D` | Deep background (menus)            |
| berry_dim         | `#47345E` | Non-text, cursor line              |
| berry_fade        | `#5A3D6E` | Selection, visual                  |
| berry_desaturated | `#886C9C` | Comments, gutter                   |
| lilac             | `#C7B8E0` | Foreground, variables, punctuation |
| bubblegum         | `#D678B5` | Keywords, operators, macros        |
| gold              | `#E3C0A8` | Constants, strings, tags, labels   |
| mint              | `#7FC9AB` | Functions, diff add                |
| violet            | `#C78DFC` | Types, builtins                    |

## Requirements

- Neovim >= 0.8
- Treesitter (optional, recommended)

## Installation

### lazy.nvim

```lua
{
  "mrpbennet/boo-berry.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("boo-berry").setup({})
    vim.cmd([[colorscheme boo-berry]])
  end,
}
```

### LazyVim

```lua
return {
  { "mrpbennet/boo-berry.nvim" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "boo-berry",
    },
  },
}
```

### packer.nvim

```lua
use {
  "mrpbennet/boo-berry.nvim",
  config = function()
    vim.cmd([[colorscheme boo-berry]])
  end,
}
```

## Usage

```lua
vim.cmd([[colorscheme boo-berry]])
```

## Configuration

Call `setup()` **before** setting the colorscheme:

```lua
require("boo-berry").setup({
  -- Set italic comments
  italic_comment = true, -- default: false

  -- Use transparent background
  transparent_bg = false, -- default: false

  -- Show '~' after end of buffer
  show_end_of_buffer = false, -- default: false

  -- Custom lualine background
  lualine_bg_color = nil, -- default: nil (uses berry_dim)

  -- Override any palette colour
  colors = {
    bg = "#3A2A4D",
    -- ... see lua/boo-berry/palette.lua for all keys
  },

  -- Override any highlight group
  overrides = {},
  -- or as a function:
  -- overrides = function(colors)
  --   return {
  --     Normal = { fg = colors.fg },
  --   }
  -- end,
})
```

## Lualine

```lua
require("lualine").setup({
  options = {
    theme = "boo-berry",
  },
})
```

## Importing colours

```lua
local colors = require("boo-berry").colors()
-- colors.bg, colors.fg, colors.pink, etc.
```

## Supported plugins

- LSP / Diagnostics
- Treesitter
- Telescope
- NvimTree / NeoTree
- Gitsigns
- BufferLine
- indent-blankline / ibl
- nvim-cmp / blink.cmp
- nvim-dap-ui
- mini.nvim (icons, statusline, indentscope)
- which-key
- lazy.nvim
- mason.nvim
- noice.nvim
- nvim-notify

## Credits

- **boo_berry** helix theme by [bootra](https://github.com/helix-editor/helix/blob/master/runtime/themes/boo_berry.toml)
- Plugin architecture from [Mofiqul/dracula.nvim](https://github.com/Mofiqul/dracula.nvim)

## License

MIT
