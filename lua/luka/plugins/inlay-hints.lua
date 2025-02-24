return {
  "MysticalDevil/inlay-hints.nvim",
  event = "LspAttach",
  dependencies = { "neovim/nvim-lspconfig" },
  config = function()
    require("inlay-hints").setup()
  end,
  keys = {
    { "<leader>gl", "<cmd>InlayHintsToggle<CR>", desc = "󰨚 Toggle Inlay Hints" },
  },
}
