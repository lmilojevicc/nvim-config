return {
  "olrtg/nvim-emmet",
  ft = { "html", "css", "javascript", "typescriptreact" },
  config = function()
    vim.keymap.set(
      { "n", "v" },
      "<leader>we",
      require("nvim-emmet").wrap_with_abbreviation,
      { desc = "Emmet wrap with abbreviation" }
    )
  end,
}
