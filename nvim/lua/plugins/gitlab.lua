return {
  -- Make GitLab CI files use the filetype expected by gitlab-ci-ls
  {
    "nvim-lua/plenary.nvim",
    init = function()
      vim.filetype.add({
        pattern = {
          [".*%.gitlab%-ci%.ya?ml"] = "yaml.gitlab",
          [".*/%.gitlab%-ci%.ya?ml"] = "yaml.gitlab",
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gitlab_ci_ls = {
          filetypes = { "yaml.gitlab" },
          cmd = { "gitlab-ci-ls" },
          root_dir = function(fname)
            return vim.fs.root(fname, {
              ".gitlab-ci.yml",
              ".gitlab-ci.yaml",
              ".gitlab-ci-ls.yml",
              ".git",
            })
          end,
          init_options = {
            cache = vim.fn.stdpath("cache") .. "/gitlab-ci-ls",
            log_path = vim.fn.stdpath("state") .. "/gitlab-ci-ls.log",
            options = {
              dependencies_autocomplete_stage_filtering = false,
            },
          },
        },

        -- Optional: keep yamlls for normal YAML, but do not attach it to GitLab CI files
        yamlls = {
          filetypes = { "yaml", "yaml.docker-compose", "yaml.github" },
        },
      },
    },
  },
}
