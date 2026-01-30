-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function toggle_comment_folds()
  local bufnr = vim.api.nvim_get_current_buf()
  local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
  if not ok or parser == nil then
    vim.notify("Treesitter parser not available", vim.log.levels.WARN)
    return
  end

  local tree = parser:parse()[1]
  if not tree then
    vim.notify("Could not parse buffer", vim.log.levels.WARN)
    return
  end

  local query_ok, query = pcall(vim.treesitter.query.parse, parser:lang(), "(comment) @comment")
  if not query_ok then
    vim.notify("Could not create query for comments", vim.log.levels.WARN)
    return
  end

  local comment_rows = {}
  for _, node in query:iter_captures(tree:root(), bufnr) do
    local start_row = node:range()
    table.insert(comment_rows, start_row + 1)
  end

  if #comment_rows == 0 then
    vim.notify("No comment blocks found", vim.log.levels.INFO)
    return
  end

  table.sort(comment_rows)

  local blocks = {}
  local current_block = comment_rows[1]

  for i = 2, #comment_rows do
    if comment_rows[i] > comment_rows[i - 1] + 1 then
      table.insert(blocks, current_block)
      current_block = comment_rows[i]
    end
  end
  table.insert(blocks, current_block)

  local cursor_pos = vim.api.nvim_win_get_cursor(0)

  for _, row in ipairs(blocks) do
    vim.api.nvim_win_set_cursor(0, { row, 0 })
    pcall(vim.cmd, "normal! za")
  end

  vim.api.nvim_win_set_cursor(0, cursor_pos)
end

vim.keymap.set("n", "zfc", toggle_comment_folds, { desc = "Toggle comment folds" })
vim.keymap.set("n", "<leader>w", "<cmd>w<cr><esc>", { desc = "Save buffer" })
