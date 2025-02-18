return {
  "echasnovski/mini.surround",
  event = { "InsertEnter", "BufReadPost" },
  version = "*",
  config = function()
    require("mini.surround").setup()
  end,
}
