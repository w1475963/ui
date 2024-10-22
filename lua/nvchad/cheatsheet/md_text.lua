local function push_lines(buf, lines)
  vim.api.nvim_buf_set_lines(buf, -1, -1, false, lines)
end
return function()
  local buf = vim.api.nvim_create_buf(false, true)
  local keymappings = require("nvchad.cheatsheet").organize_mappings()
  local sections = vim.tbl_keys(keymappings)
  table.sort(sections)
  push_lines(buf, { "# NvCheatsheet List" })
  for _, title in ipairs(sections) do
    push_lines(buf, { "", "## " .. title, "" })
    for i, val in ipairs(keymappings[title]) do
      local line = ""
      line = line .. string.format("%d", i) .. ". `" .. val[2] .. "`" .. " " .. val[1]
      push_lines(buf, { line })
    end
  end
  vim.api.nvim_set_current_buf(buf)
  vim.api.nvim_set_option_value("filetype", "markdown", { buf = buf })
end
