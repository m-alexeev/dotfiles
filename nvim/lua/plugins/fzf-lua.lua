return {
  {
    "ibhagwan/fzf-lua",
    config = function()
      require("fzf-lua").setup({
        grep = {
          -- Explicitly set ripgrep options to ignore the specified directories
          rg_opts = "--hidden --column --line-number --no-heading --color=always --smart-case -g '!{.git,node_modules,.yarn}/*'",
        },
        live_grep = {
          rg_opts = "--hidden --column --line-number --no-heading --color=always --smart-case -g '!{.git,node_modules,.yarn}/*'",
        },
      })
    end,
  },
}
