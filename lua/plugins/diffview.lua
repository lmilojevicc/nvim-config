return {
  "sindrets/diffview.nvim",
  dependencies = {
    { "nvim-tree/nvim-web-devicons", lazy = true },
  },
  event = "CmdlineEnter",

  opts = {
    merge_tool = {
      layout = "diff3_mixed",
      disable_diagnostics = true,
      winbar_info = true,
    },
    view = {
      merge_tool = {
        layout = "diff3_mixed",
        winbar_info = true,
        disable_diagnostics = true,
      },
    },
  },

  keys = {
    { "<leader>gdo", "<cmd>DiffviewOpen<cr>", desc = " Open Diffview" },
    { "<leader>gdc", "<cmd>DiffviewClose<cr>", desc = " Close Diffview" },
    { "<leader>gdh", "<cmd>DiffviewFileHistory<cr>", desc = " Diff File History" },
  },
}
