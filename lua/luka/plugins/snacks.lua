return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    indent = { enabled = true },
    scroll = { enabled = true },
    zen = { enabled = true, toggles = { dim = false } },
  },

  keys = {
    {
      "<leader>zm",
      function()
        Snacks.zen()
      end,
      desc = "Toggle Zen Mode",
    },
  },
}
