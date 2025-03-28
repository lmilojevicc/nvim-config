return {
  "echasnovski/mini.surround",
  enabled = false,
  event = { "InsertEnter", "BufReadPost" },
  version = "*",
  config = function()
    require("mini.surround").setup()
  end,
}
