return {
  "stevearc/aerial.nvim",
  event = { "BufRead" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    backends = { "lsp", "treesitter", "markdown", "asciidoc", "man" },

    layout = {
      default_direction = "prefer_right", -- Open as a floating window
      min_width = 40,
      max_width = { 80, 0.5 }, -- Up to 80 columns or 50% of screen
      win_opts = {
        winblend = 10, -- Transparency for popup feel
        winhl = "Normal:Normal,FloatBorder:FloatBorder", -- Custom highlights
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
    { "<leader>af", function () require("aerial.command").nav_toggle() end, desc = "󰆧 Aerial Nav Toggle" },
    { "<leader>fs", function() require("aerial").snacks_picker() end, desc = "󰆧 Find Symbols (Aerial Snacks picker)", },
  },
}
