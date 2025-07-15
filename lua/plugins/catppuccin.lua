return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "mocha",
      transparent_background = true,
      show_end_of_buffer = false,
      term_colors = true,

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

      integrations = {
        aerial = true,
        alpha = true,
        blink_cmp = true,
        beacon = true,
        cmp = true,
        dropbar = {
          enabled = true,
          color_mode = true,
        },
        dap = true,
        dap_ui = true,
        diffview = true,
        dashboard = true,
        flash = true,
        dadbod_ui = true,
        fzf = true,
        grug_far = true,
        gitsigns = true,
        headlines = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        leap = true,
        lsp_trouble = true,
        mason = true,
        markdown = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        navic = { enabled = true, custom_bg = "lualine" },
        nvim_surround = true,
        neotest = true,
        neotree = true,
        noice = true,
        notify = true,
        semantic_tokens = true,
        snacks = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        which_key = true,
      },

      custom_highlights = function(colors)
        local lualine_theme = require("lualine.themes.catppuccin")
        lualine_theme.normal.c.bg = "none"
        lualine_theme.command.a = { fg = colors.green, bg = colors.base }
        lualine_theme.normal.a = { fg = colors.blue, bg = colors.base }
        lualine_theme.inactive.a = { fg = colors.rosewater, bg = colors.base }
        lualine_theme.insert.a = { fg = colors.lavender, bg = colors.base }
        lualine_theme.replace.a = { fg = colors.red, bg = colors.base }
        lualine_theme.terminal.a = { fg = colors.teal, bg = colors.base }
        lualine_theme.visual.a = { fg = colors.mauve, bg = colors.base }

        return {
          NoiceCmdlinePopupBorder = { fg = colors.rosewater },
          NoiceCmdlinePopupTitle = { fg = colors.rosewater },
          NoiceCmdlineIcon = { fg = colors.rosewater },
          NoiceVirtualText = { fg = colors.rosewater },
          SnacksInputTitle = { fg = colors.blue },
          SnacksInputBorder = { fg = colors.blue },
          SnacksInputIcon = { fg = colors.blue },
          AvanteSidebarWinSeparator = { bg = colors.crust, fg = colors.crust },

          CurSearch = { bg = colors.rosewater },
          Search = { fg = "", bg = colors.surface0 },
          IncSearch = { fg = colors.crust, bg = colors.blue },
          CursorLine = { bg = "" },
          CursorLineNr = { fg = colors.mauve },
        }
      end,
    })

    vim.cmd.colorscheme("catppuccin")
  end,
}
