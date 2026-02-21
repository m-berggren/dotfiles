return {
  -- Undo tree visualization
  {
    "mbbill/undotree",
    keys = {
      { "<leader>u", vim.cmd.UndotreeToggle, desc = "Undotree" },
    },
  },

  -- Better quickfix/location list
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
  },

  -- Project-specific marks and sessions
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("harpoon"):setup()
    end,
    keys = {
      { "<leader>a", function() require("harpoon"):list():add() end, desc = "Harpoon add" },
      { "<C-e>", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, desc = "Harpoon menu" },
    },
  },
}