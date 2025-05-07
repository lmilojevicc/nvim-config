return {
  "nvim-java/nvim-java",
  ft = "java",
  event = "LspAttach",
  config = function()
    require("java").setup()
    require("lspconfig").jdtls.setup({})
  end,
}
