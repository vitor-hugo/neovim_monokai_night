local ok, err = pcall(function()
  vim.opt.runtimepath:prepend(vim.fn.getcwd())
  vim.opt.runtimepath:append(vim.fn.getcwd() .. "/after")
  vim.cmd("colorscheme monokai-night")
  assert(vim.g.colors_name == "monokai-night", "Colorscheme not loaded")
  assert(vim.o.background == "dark" and vim.o.termguicolors)

  local function check(group, key, hex)
    local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
    assert(hl[key] == tonumber(hex:sub(2), 16), group .. ": " .. vim.inspect(hl))
  end
  check("Normal", "bg", "#1f1f1f")
  check("Normal", "fg", "#dddddd")
  check("OutputNormal", "bg", "#1A1A1A")
  local editor = vim.api.nvim_get_current_buf()
  local log = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_name(log, "FlutterLog")
  vim.wo.winhighlight = "CursorLine:Visual"
  vim.api.nvim_win_set_buf(0, log)
  assert(vim.wo.winhighlight:find("Normal:OutputNormal", 1, true))
  assert(vim.wo.winhighlight:find("CursorLine:Visual", 1, true))
  vim.cmd("colorscheme monokai-night")
  vim.cmd("colorscheme habamax")
  assert(vim.wo.winhighlight == "CursorLine:Visual", "Restore output window on theme switch")
  vim.cmd("colorscheme monokai-night")
  assert(vim.wo.winhighlight:find("Normal:OutputNormal", 1, true))
  vim.api.nvim_win_set_buf(0, editor)
  assert(vim.wo.winhighlight == "CursorLine:Visual", "Restore editor window highlights")
  vim.cmd("enew")
  vim.fn.termopen({ vim.o.shell, "-c", "printf terminal" })
  assert(vim.wo.winhighlight:find("Normal:OutputNormal", 1, true), "Terminal background")
  vim.api.nvim_win_set_buf(0, editor)
  check("@keyword", "fg", "#f92672")
  check("@function", "fg", "#a6e22e")
  check("@string", "fg", "#e6db74")
  check("@number", "fg", "#ae81ff")
  check("@lsp.type.class", "fg", "#66d9ef")
  check("@lsp.type.parameter.dart", "fg", "#dddddd")
  check("@lsp.type.enumMember.dart", "fg", "#dddddd")
  check("DiagnosticError", "fg", "#fe413f")
  check("SnacksPickerMatch", "fg", "#66d9ef")
  assert(not vim.api.nvim_get_hl(0, { name = "@type", link = false }).underline)

  for i = 0, 15 do
    assert(vim.g["terminal_color_" .. i]:match("^#%x%x%x%x%x%x$"), "Invalid ANSI color " .. i)
  end
  local statusline = require("lualine.themes.monokai-night")
  for _, mode in ipairs({ "normal", "insert", "visual", "replace", "command", "terminal", "inactive" }) do
    assert(statusline[mode].a.bg == "#161616", mode .. " status line background")
  end

  -- The theme must load and reload without relying on another theme or plugin.
  vim.cmd("colorscheme habamax")
  vim.cmd("colorscheme monokai-night")
  check("Normal", "bg", "#1f1f1f")
  check("@type", "fg", "#66d9ef")
  assert(vim.v.errmsg == "", vim.v.errmsg)
  print("PASS: standalone colorscheme, output backgrounds, syntax/semantic highlights, integrations, ANSI colors, Lualine and reload")
end)

if not ok then
  io.stderr:write(tostring(err) .. "\n")
  vim.cmd("cquit 1")
else
  vim.cmd("qa!")
end
