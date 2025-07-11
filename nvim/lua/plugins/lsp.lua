return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      lspconfig.tsserver.setup({
        on_attach = function(client, bufnr)
          -- Disable tsserver's formatting capability to use other formatters
          client.server_capabilities.document_formatting = false
        end,
      })

      lspconfig.clangd.setup({
        cmd = { "clangd", "--background-index", "--clang-tidy" },
        filetypes = { "c", "cpp", "objc", "objcpp" },
        root_dir = lspconfig.util.root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
      })

      lspconfig.gh_actions_ls.setup({
        cmd = { "gh-actions-language-server", "--stdio" },
        -- root_dir = lspconfig.util.root_pattern(".github/workflows/*"),
      })

      lspconfig.bashls.setup({
        cmd = { "bash-language-server", "start" },
        filetypes = { "sh" },
      })

      lspconfig.terraformls.setup({})

      lspconfig.roslyn.setup({
        filetypes = { "cs" },
        settings = {
          roslyn = {
            fileWatching = true,
          },
        },
      })

      lspconfig.jsonnet_ls.setup({
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
      })
    end,
  },
}
