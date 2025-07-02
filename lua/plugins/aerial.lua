return {
  "stevearc/aerial.nvim",
  event = { "BufReadPre" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    backends = { "lsp", "treesitter", "markdown", "asciidoc", "man" },
    show_guides = true,

    layout = {
      default_direction = "prefer_right",
      min_width = 40,
      max_width = { 80, 0.5 },
      win_opts = {
        winblend = 10,
        winhl = "Normal:Normal,FloatBorder:FloatBorder",
      },
    },

    nav = {
      border = "rounded",
      max_height = 0.6,
      min_height = 0.6,
      preview = true,
      win_opts = {
        winblend = 5,
      },
    },

    close_automatic_events = { "unfocus", "switch_buffer", "unsupported" },
    filter_kind = false,
  },

  --stylua: ignore
  keys = {
    -- Toggle aerial window
    { "<leader>at", function () require("aerial").toggle() end, desc = "󰆧 Aerial Toggle" },

    -- Aerial nav window (picker-like interface)
    { "<leader>af", function () require("aerial").nav_toggle() end, desc = "󰆧 Aerial Nav Toggle" },
    { "<leader>fs", function() require("aerial").snacks_picker() end, desc = "󰆧 Find Symbols (Aerial Snacks picker)", },
  },
}
