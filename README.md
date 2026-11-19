# Monokai Night

A Neovim adaptation of [Monokai Night for VSCode](https://github.com/fabiospampinato/vscode-monokai-night), using its charcoal backgrounds and Monokai palette.

## Requirements

- Neovim 0.10 or newer and a terminal with true color support.
- No required plugins. Treesitter and LSP highlighting use the integrations already present in your editor.

## Install with lazy.nvim

For a local checkout, add this plugin specification (replace `dir` with your checkout path):

```lua
{
  dir = "/Volumes/DevSSD/Torugo/SideProjects/neovim_monokai_night",
  name = "monokai-night",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("monokai-night")
  end,
}
```

### LazyVim

Add the local plugin specification above to a file under `lua/plugins/` and also select the theme in LazyVim:

```lua
{
  "LazyVim/LazyVim",
  opts = { colorscheme = "monokai-night" },
}
```

Once the plugin is installed and on the runtime path, you can switch to it with:

```vim
:colorscheme monokai-night
```

### Lualine

Lualine is optional. Select the included status line theme with:

```lua
require("lualine").setup({
  options = { theme = "monokai-night" },
})
```

For LazyVim, override its existing Lualine configuration instead:

```lua
{
  "nvim-lualine/lualine.nvim",
  opts = { options = { theme = "monokai-night" } },
}
```

## Features

- Charcoal editor, panels, menus, selections, and status line.
- Pink keywords, green functions, yellow strings, cyan types, and purple numbers.
- Treesitter and LSP semantic highlighting, including Dart/Flutter refinements.
- Diagnostics, diffs, GitSigns, and all sixteen terminal ANSI colors.
- `#1A1A1A` backgrounds for terminals and non-floating output buffers, including FlutterLog and quickfix.
- Snacks picker, dashboard and indentation, Blink completion, Bufferline, WhichKey, Noice, Trouble, Lazy, and Mason highlights.
- Optional Lualine theme.

The Dart query extension keeps `void` cyan and named arguments neutral even when semantic tokens would override their syntax colors. It requires an installed Dart Treesitter parser and its standard highlight queries; no parser is installed by this theme.

This plugin only supplies appearance. Editor shortcuts, Flutter commands, file-search sorting, panel sizes, and color-preview behavior are not included.

## Customize

Edit `lua/monokai-night/init.lua` to adjust the palette and highlights. The palette can also be inspected programmatically:

```lua
local palette = require("monokai-night").palette
```

For custom highlights that survive theme reloads, register a `ColorScheme` autocmd after your plugin setup:

```lua
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "monokai-night",
  callback = function()
    vim.api.nvim_set_hl(0, "Comment", { fg = "#888888" })
  end,
})
```

VSCode and Neovim use different syntax and semantic token systems, so some language-specific coloring can differ. Terminal font and italic rendering also depend on the terminal configuration.

## Development

From this project's root:

```sh
make test
make format-check # requires StyLua
```

The headless checks load the theme without a user configuration or third-party plugins, verify highlight links and terminal colors, load the optional Lualine palette, and switch away from and back to the theme.

## License and attribution

MIT. The original palette and token styles come from Fabio Spampinato's [vscode-monokai-night](https://github.com/fabiospampinato/vscode-monokai-night), specifically `themes/default.json`. The original copyright and license are preserved in [LICENSE](LICENSE).
