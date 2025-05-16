return {
  "folke/todo-comments.nvim",
  event = "BufReadPost",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    colors = {
      error = { "DiagnosticError", "ErrorMsg", "#ed8796" }, -- Red
      warning = { "DiagnosticWarn", "WarningMsg", "#f5a97f" }, -- Peach
      info = { "DiagnosticInfo", "#8aadf4" }, -- Blue
      hint = { "DiagnosticHint", "#a6da95" }, -- Green
      default = { "Identifier", "#c6a0f6" }, -- Mauve
      test = { "Identifier", "#f5bde6" }, -- Pink
    },
  },
}
