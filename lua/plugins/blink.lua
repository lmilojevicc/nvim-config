return {
  "saghen/blink.cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  opts_extend = {
    "sources.completion.enabled_providers",
    "sources.compat",
    "sources.default",
  },
  dependencies = {
    "rafamadriz/friendly-snippets",
    { "saghen/blink.compat", optional = true, opts = {} },
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
      window = { border = "shadow" },
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
        border = "shadow",
        scrollbar = true,
        scrolloff = 5,
      },

      ghost_text = { enabled = true },

      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        window = { border = "shadow" },
      },
    },

    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },

    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
}
