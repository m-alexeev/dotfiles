-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("jenkinsfile_detect", { clear = true }),
  pattern = { "Jenkinsfile" },
  callback = function()
    vim.cmd.setfiletype("groovy")
  end,
})

-- WezTerm tab titles: show project folder, not buffer name
if vim.env.WEZTERM_PANE and vim.fn.executable("wezterm") == 1 then
  local group = vim.api.nvim_create_augroup("wezterm_tab_title", { clear = true })

  local function project_folder_name()
    local cwd = vim.fn.getcwd()
    local root = vim.fs.root(cwd, { ".git", "package.json", "Cargo.toml", "go.mod", "pyproject.toml" })
    return vim.fs.basename(root or cwd)
  end

  vim.api.nvim_create_autocmd("BufEnter", {
    group = group,
    callback = function()
      vim.fn.system({ "wezterm", "cli", "set-tab-title", project_folder_name() })
    end,
  })

  vim.api.nvim_create_autocmd("VimLeave", {
    group = group,
    callback = function()
      -- Clear explicit title so WezTerm format-tab-title uses cwd again
      vim.fn.system({ "wezterm", "cli", "set-tab-title", "" })
    end,
  })
end
