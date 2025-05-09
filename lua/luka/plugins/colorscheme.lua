return {
  "catppuccin/nvim",
  name = "catppuccin",
  enabled = true,
  priority = 1000,
  config = function()
    local mocha = require("catppuccin.palettes").get_palette("mocha")

    require("catppuccin").setup({
      flavour = "mocha",
      transparent_background = true,
      show_end_of_buffer = false,
      term_colors = true,
      dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.5,
      },
      no_italic = false,
      no_bold = false,
      no_underline = false,
      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = { "italic" },
        functions = { "italic" },
        keywords = { "italic" },
        strings = {},
        variables = {},
        numbers = {},
        booleans = { "italic" },
        properties = {},
        types = { "italic" },
        operators = {},
      },
      color_overrides = {},
      custom_highlights = {
        StatusLine = { bg = "NONE" },
        StatusLineNC = { bg = "NONE" },
        LualineNormal = { bg = "NONE" },
        LualineInsert = { bg = "NONE" },
        LualineVisual = { bg = "NONE" },
        LualineReplace = { bg = "NONE" },
        LualineCommand = { bg = "NONE" },
      },
      integrations = {
        cmp = true,
        barbar = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = false,
        lsp_trouble = true,
        telescope = {
          enabled = true,
        },
        mini = {
          enabled = true,
          indentscope_color = "",
        },
      },
    })

    vim.cmd.colorscheme("catppuccin")
  end,
}
