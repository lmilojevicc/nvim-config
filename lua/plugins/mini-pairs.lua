return {
  "echasnovski/mini.pairs",
  event = { "InsertEnter", "BufReadPost" },
  version = "*",
  config = function()
    require("mini.pairs").setup()
  end,
}
