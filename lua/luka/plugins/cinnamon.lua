return {
  "declancm/cinnamon.nvim",
  version = "*",
  opts = {
    keymaps = {
      basic = true,
      extra = true,
    },
    options = {
      mode = "cursor",
      delay = 5,
      step_size = {
        vertical = 1,
        horizontal = 2,
      },
      max_delta = {
        line = false,
        column = false,
        time = 500,
      },
    },
  },
  keys = {
    { "<C-d>", "<cmd>lua require('cinnamon').scroll('<C-d>zz')<CR>", mode = "n", desc = "Smooth scroll down" },
    { "<C-u>", "<cmd>lua require('cinnamon').scroll('<C-u>zz')<CR>", mode = "n", desc = "Smooth scroll up" },
    { "<C-f>", "<cmd>lua require('cinnamon').scroll('<C-f>zz')<CR>", mode = "n", desc = "Smooth page forward" },
    { "<C-b>", "<cmd>lua require('cinnamon').scroll('<C-b>zz')<CR>", mode = "n", desc = "Smooth page backward" },
  },
  config = function(_, opts)
    require("cinnamon").setup(opts)
  end,
}
