return {
  "stevearc/conform.nvim",
  opts = function(_, opts)
    local conform = require("conform")

    opts.formatters = vim.tbl_extend("force", opts.formatters or {}, {
      jsonnetfmt = {
        command = "jsonnetfmt",
        args = { "-" },
        stdin = true,
      },
      csharpier = {
        command = "csharpier",
        args = { "format", "--write-stdout" },
        stdin = true,
      },
    })

    -- Specify which formatter to use for jsonnet filetype
    opts.formatters_by_ft = vim.tbl_extend("force", opts.formatters_by_ft or {}, {
      jsonnet = { "jsonnetfmt" },
      c = { "clang_format" },
      cpp = { "clang_format" },
      cs = { "csharpier" },
    })
  end,
}
