return {
  "saghen/blink.pairs",
  version = "*",
  event = "InsertEnter",
  dependencies = "saghen/blink.download",
  ---@module 'blink.pairs'
  ---@type blink.pairs.Config
  opts = {
    mappings = {
      enabled = true,
    },
    highlights = {
      enabled = true,
      groups = {
        "BlinkPairsOrange",
        "BlinkPairsPurple",
        "BlinkPairsBlue",
      },
    },
  },
}
