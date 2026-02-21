return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "c",
        "cpp",
        "zig",
        "python",
        "typescript",
        "tsx",
        "javascript",
        "lua",
        "bash",
        "fish",
        "markdown",
        "markdown_inline",
        "json",
        "yaml",
        "toml",
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = { max_lines = 3 },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        zls = {},
      },
    },
  },

  {
    "mason.nvim",
    opts = function(_, opts)
        vim.list_extend(opts.ensure_installed, {
            "zls",
            "stylua",
            "shellcheck",
            "shfmt",
        })
    end,
  },
}