return {
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup({
        direction = "horizontal", -- Terminal will open in a horizontal split
        size = 15, -- Height of the terminal when using horizontal split
        open_mapping = [[<leader>t]], -- Bind ToggleTerm to <leader>/
      })
    end,
  },
}
