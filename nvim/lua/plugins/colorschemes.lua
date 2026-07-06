return {
  {
    "metalelf0/base16-black-metal-scheme",
    lazy = true,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("base16-black-metal-bathory")
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    init = function()
      require("kanagawa").setup({
        compile = true,
        theme = "dragon",
        background = { dark = "dragon", light = "lotus" },
        colors = {
          theme = {
            dragon = {
              ui = {
                bg_visual = "#282727",  -- dragonBlack4
                bg_search = "#393836",  -- dragonBlack5
                pmenu = {
                  fg = "#c5c9c5",       -- dragonWhite
                  fg_sel = "none",
                  bg = "#282727",       -- dragonBlack4
                  bg_sel = "#393836",   -- dragonBlack5
                  bg_thumb = "#625e5a", -- dragonBlack6
                  bg_sbar = "#282727",  -- dragonBlack4
                },
                float = {
                  fg_border = "#7a8382", -- dragonGray3
                },
              },
            },
          },
        },
      })
    end,
    config = function()
      vim.cmd.colorscheme("kanagawa-dragon")
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
      colorscheme = "kanagawa-dragon",
    },
  },
}
