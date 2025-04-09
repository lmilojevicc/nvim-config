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
    { "<C-d>", "<cmd>lua require('cinnamon').scroll('<C-d>zz')<CR>", mode = "n", desc = " Smooth scroll down" },
    { "<C-u>", "<cmd>lua require('cinnamon').scroll('<C-u>zz')<CR>", mode = "n", desc = " Smooth scroll up" },
    {
      "<C-f>",
      "<cmd>lua require('cinnamon').scroll('<C-f>zz')<CR>",
      mode = "n",
      desc = " Smooth scroll page down",
    },
    { "<C-b>", "<cmd>lua require('cinnamon').scroll('<C-b>zz')<CR>", mode = "n", desc = " Smooth scroll page up" },
    { "gg", "<cmd>lua require('cinnamon').scroll('gg')<CR>", mode = "n", desc = " Smooth scroll to top" },
    { "G", "<cmd>lua require('cinnamon').scroll('G')<CR>", mode = "n", desc = " Smooth scroll to bottom" },
  },

  config = function(_, opts)
    require("cinnamon").setup(opts)
  end,
}
