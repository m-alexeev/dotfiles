return {
  {
    "metalelf0/base16-black-metal-scheme",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("base16-black-metal-bathory")
    end,
  },
  {
    "sainnhe/everforest",
    lazy = true,
    config = function()
      vim.g.everforest_transparent_background = 2
      vim.g.everforest_enable_italic = true
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "base16-black-metal-bathory",
    },
  },
}
