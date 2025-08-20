return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  ---@module "ibl"
  ---@type ibl.config
  config = function()
    local hooks = require("ibl.hooks")

    local highlight = {
      "RainbowRed",
      "RainbowYellow",
      "RainbowBlue",
      "RainbowOrange",
      "RainbowGreen",
      "RainbowViolet",
      "RainbowCyan",
    }

    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E67E80" })
      vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#DBBC7F" })
      vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#7fbbb3" })
      vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#E69875" })
      vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#A7C080" })
      vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#D699B6" })
      vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#83C092" })
    end)
    require("ibl").setup({
      indent = {
        highlight = highlight,
      },
    })
  end,
  opts = {},
}
