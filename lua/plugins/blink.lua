return {
  "saghen/blink.cmp",
  event = { "InsertEnter", "CmdlineEnter" },

  opts_extend = {
    "sources.completion.enabled_providers",
    "sources.compat",
    "sources.default",
  },

  dependencies = {
    "kristijanhusak/vim-dadbod-completion",
    "giuxtaposition/blink-cmp-copilot",
    {
      "saghen/blink.compat",
      optional = true,
      event = { "InsertEnter", "CmdlineEnter" },
      opts = {},
    },
    {
      "L3MON4D3/LuaSnip",
      build = "make install_jsregexp",
      lazy = true,
      dependencies = {
        "rafamadriz/friendly-snippets",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
          require("luasnip.loaders.from_vscode").lazy_load({
            paths = { vim.fn.stdpath("config") .. "/snippets" },
          })
        end,
      },
      opts = {
        history = true,
        delete_check_events = "TextChanged",
      },
    },
  },

  version = "1.*",

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = "super-tab",
    },

    cmdline = {
      keymap = { preset = "inherit" },
      completion = { menu = { auto_show = true } },
    },

    appearance = { nerd_font_variant = "mono" },

    signature = {
      window = { border = "none" },
    },

    completion = {
      accept = {
        auto_brackets = { enabled = true },
      },

      menu = {
        draw = {
          treesitter = { "lsp" },
          gap = 2,
          columns = {
            { "kind_icon" },
            { "label", "label_description", gap = 1 },
            { "kind" },
          },
        },

        auto_show = true,
        border = "none",
        scrollbar = false,
        scrolloff = 5,
      },

      ghost_text = { enabled = true },

      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        window = { border = "none" },
      },
    },

    snippets = {
      preset = "luasnip",
    },

    sources = {
      default = { "lsp", "lazydev", "dadbod", "snippets", "path", "buffer", "copilot" },

      providers = {
        lsp = {
          name = "lsp",
          score_offset = 900,
        },

        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 950,
        },

        snippets = {
          name = "snippets",
          score_offset = 500,
          min_keyword_length = 2,
        },

        path = {
          name = "path",
          score_offset = 250,
          fallbacks = { "buffer" },
        },

        buffer = {
          name = "buffer",
          score_offset = 50,
          max_items = 8,
          min_keyword_length = 3,
        },

        dadbod = {
          name = "Dadbod",
          module = "vim_dadbod_completion.blink",
          score_offset = 950,
        },

        copilot = {
          name = "copilot",
          module = "blink-cmp-copilot",
          score_offset = -100,
          async = true,
          should_show_items = function(ctx)
            return ctx.trigger.kind ~= "trigger_character"
          end,
        },
      },
    },

    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
}
