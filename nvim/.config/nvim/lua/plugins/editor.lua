return {
  -- Better terminal integration
  {
    "akinsho/toggleterm.nvim",
    keys = {
      { "<C-\\>", "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal" },
    },
    opts = {
      direction = "float",
      float_opts = { border = "curved" },
    },
  },

  -- Superior fuzzy finding with native performance
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
  },

  -- Git integration beyond gitsigns
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G" },
  },
}