local c = require("monokai-night").palette

local function mode(accent)
  return {
    a = { fg = c.fg, bg = c.sidebar, gui = "bold" },
    b = { fg = accent, bg = c.sidebar },
    c = { fg = c.fg, bg = c.sidebar },
  }
end

return {
  normal = mode(c.blue),
  insert = mode(c.green),
  visual = mode(c.purple),
  replace = mode(c.pink),
  command = mode(c.yellow),
  terminal = mode(c.cyan),
  inactive = {
    a = { fg = c.muted, bg = c.sidebar },
    b = { fg = c.muted, bg = c.sidebar },
    c = { fg = c.muted, bg = c.sidebar },
  },
}
