return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- Merge with LazyVim's built-in server configs
      opts.servers = vim.tbl_deep_extend("force", opts.servers or {}, {
        tsserver = {
          on_attach = function(client, bufnr)
            client.server_capabilities.documentFormattingProvider = false
          end,
        },
        cssls = {
          filetypes = { "css", "scss", "uss" },
        },
        clangd = {
          cmd = { "clangd", "--background-index", "--clang-tidy" },
          filetypes = { "c", "cpp", "objc", "objcpp" },
          root_dir = require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
        },
        gh_actions_ls = {
          cmd = { "gh-actions-language-server", "--stdio" },
        },
        bashls = {
          cmd = { "bash-language-server", "start" },
          filetypes = { "sh" },
        },
        terraformls = {},
        omnisharp = {
          filetypes = { "cs", "csx", "cake" },
          cmd = { "omnisharp-mono", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
          enable_editorconfig_support = true,
          enable_ms_build_load_projects_on_demand = false,
          enable_roslyn_analyzers = true,
          organize_imports_on_format = true,
          enable_import_completion = true,
          on_attach = function(client, bufnr)
            client.server_capabilities.documentFormattingProvider = true
          end,
        },
        jsonnet_ls = {
          settings = {
            ext_vars = {
              foo = "bar",
            },
            formatting = {
              Indent = 2,
              MaxBlankLines = 2,
              StringStyle = "single",
              CommentStyle = "slash",
              PrettyFieldNames = true,
              PadArrays = false,
              PadObjects = true,
              SortImports = true,
              UseImplicitPlus = true,
              StripEverything = false,
              StripComments = false,
              StripAllButComments = false,
            },
          },
        },
      })
    end,
  },
}
