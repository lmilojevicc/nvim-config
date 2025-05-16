return {
  "folke/lazydev.nvim",
  ft = "lua",
  event = "LspAttach",
  opts = {
    library = {
      { path = "vim", words = { "vim" } },
      { path = "snacks.nvim", words = { "Snacks" } },
    },
  },
}
