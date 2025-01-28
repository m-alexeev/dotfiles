-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("i", "jk", "<ESC>", { silent = true })

vim.keymap.set("n", "<leader>rp", function()
  local filepath = vim.fn.expand("%:p") -- Get the full path of the current file
  local term = require("toggleterm.terminal").get(1) -- Get the first terminal
  if term then
    term:send("python3 " .. filepath, false) -- Send the command to the terminal
  else
    vim.notify("No active terminal found!", vim.log.levels.WARN)
  end
end, { desc = "Run Python file in ToggleTerm" })
