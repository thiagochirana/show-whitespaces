
local M = {}

local namespace = vim.api.nvim_create_namespace("show_spaces")
local mode = "none"

local function highlight_spaces()
  if mode == "none" then return end

  local bufnr = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  vim.api.nvim_buf_clear_namespace(bufnr, namespace, 0, -1)

  for linenr, line in ipairs(lines) do
    if mode == "all" then
      for i = 1, #line do
        if line:sub(i, i) == " " then
          vim.api.nvim_buf_add_highlight(bufnr, namespace, "Whitespace", linenr - 1, i - 1, i)
        end
      end

    elseif mode == "lines" then
      for i = 1, #line do
        if line:sub(i, i) ~= " " then break end
        vim.api.nvim_buf_add_highlight(bufnr, namespace, "Whitespace", linenr - 1, i - 1, i)
      end

    elseif mode == "boundary" then
      local s, e = line:find("^%s+")
      if s and e then
        for i = s, e do
          vim.api.nvim_buf_add_highlight(bufnr, namespace, "Whitespace", linenr - 1, i - 1, i)
        end
      end
      s, e = line:find("%s+$")
      if s and e then
        for i = s, e do
          vim.api.nvim_buf_add_highlight(bufnr, namespace, "Whitespace", linenr - 1, i - 1, i)
        end
      end
    end
  end
end

function M.set_mode(new_mode)
  mode = new_mode
  highlight_spaces()
end

function M.setup()
  vim.api.nvim_create_user_command("Whitespaces", function(opts)
    M.set_mode(opts.args)
  end, {
    nargs = 1,
    complete = function()
      return { "all", "boundary", "lines", "none" }
    end,
  })

  vim.api.nvim_create_autocmd({ "BufEnter", "TextChanged", "TextChangedI" }, {
    callback = function() highlight_spaces() end,
  })
end

return M
