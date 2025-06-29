return {
  "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.Config
  opts = {},
  -- stylua: ignore
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = " Flash" },
    { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = " Flash Treesitter" },
    {
      "<leader>sl",
      mode = { "n", "o", "x" },
      function ()
        require("flash").jump({
          search = { mode = "search", max_length = 0 },
          label = { after = { 0, 0 } },
          pattern = "^"
        })
      end ,
      desc = " Flash line jump"
    },
    {
      "<leader>sb",
      mode = { "n", "o", "x" },
      function ()
        require("flash").jump({
          search = { forward = false, wrap = false, multi_window = false },
        })
      end ,
      desc = " Flash backward"
    },
    {
      "<leader>sf",
      mode = { "n", "o", "x" },
      function ()
        require("flash").jump({
          search = { forward = true, wrap = false, multi_window = false },
        })
      end ,
      desc = " Flash forward"
    },
    { "r", mode = "o", function() require("flash").remote() end, desc = " Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = " Treesitter Search" },
    { "<a-s>", mode = { "c" }, function() require("flash").toggle() end, desc = " Toggle Flash Search" },
  },
}
