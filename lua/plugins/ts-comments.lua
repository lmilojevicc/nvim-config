return {
  "folke/ts-comments.nvim",
  event = "BufRead",
  opts = {},
  enabled = vim.fn.has("nvim-0.10.0") == 1,
  keys = {
    { mode = "n", "<leader>/", "gcc", desc = "󰨚 Toggle comment for current line", remap = true },
    { mode = "v", "<leader>/", "gc", desc = "󰨚 Toggle comment for selected lines", remap = true },
  },
}
