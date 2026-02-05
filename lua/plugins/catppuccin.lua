return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
      transparent_background = true,
      show_end_of_buffer = false,
      term_colors = true,
      float = {
        transparent = true,
        solid = false,
      },

      no_italic = false,
      no_bold = false,
      no_underline = false,

      styles = {
        comments = { "italic" },
        conditionals = {},
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
      },

      default_integrations = true,
      auto_integrations = true,
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

        -- Noice cmdline title and icon colors
        for name, color in pairs({
          Lua = colors.blue,
          Help = colors.peach,
          Input = colors.blue,
          Filter = colors.yellow,
          Cmdline = colors.green,
          Calculator = colors.red,
        }) do
          vim.api.nvim_set_hl(0, "NoiceCmdlineIcon" .. name, { fg = color })
          vim.api.nvim_set_hl(0, "NoiceCmdlinePopupTitle" .. name, { fg = color })
        end

        return {
          BlinkCmpMenuSelection = { bg = colors.surface0 },

          NoiceCmdlinePopupBorder = { fg = colors.surface0 },
          NoiceVirtualText = { fg = colors.rosewater },

          SnacksInputTitle = { fg = colors.blue },
          SnacksIndentScope = { fg = colors.pink },

          SnacksPickerMatch = { bg = "", fg = colors.peach },
          SnacksPickerTitle = { fg = colors.green },
          SnacksPickerListTitle = { fg = colors.red },
          SnacksPickerInputTitle = { fg = colors.blue },
          SnacksPickerInputSearch = { fg = colors.blue },
          SnacksPickerToggle = { fg = colors.blue },
          SnacksPickerPrompt = { fg = colors.blue },
          SnacksPickerListCursorLine = { bg = "" },

          SnacksPickerBorder = { fg = colors.surface0 },
          SnacksInputBorder = { fg = colors.surface0 },
          SnacksInputIcon = { fg = colors.blue },

          AvanteSidebarWinSeparator = { bg = "", fg = colors.crust },
          AvanteTitle = { fg = colors.base, bg = colors.lavender },
          AvanteSubtitle = { fg = colors.base, bg = colors.peach },
          AvanteThirdTitle = { fg = colors.base, bg = colors.blue },

          BufferlineIndicatorSelected = { fg = colors.peach },
          BufferlineSeparator = { fg = colors.surface2 },
          BufferlineTabSeparator = { fg = colors.surface2 },
          BufferlineTabSeparatorSelected = { fg = colors.surface2 },
          BufferlineTabSelected = { fg = colors.peach },

          OilBorderNormal = { fg = colors.blue, bg = "NONE" },
          OilBorderModified = { fg = colors.yellow, bg = "NONE" },

          RainbowDelimiterCyan = { fg = colors.lavender },
          RainbowDelimiterGreen = { fg = colors.pink },

          CurSearch = { bg = colors.lavender },
          Search = { fg = "", bg = colors.surface0 },
          IncSearch = { fg = colors.crust, bg = colors.blue },
          CursorLine = { bg = "" },
          CursorLineNr = { fg = colors.pink },
        }
      end,
    })

    vim.cmd.colorscheme("catppuccin")
  end,
}
