return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    messages = {
      enabled = true,
      view = "mini",
      view_error = "mini",
      view_warn = "mini",
    },
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = false,
        ["vim.lsp.util.stylize_markdown"] = false,
        ["cmp.entry.get_documentation"] = false,
      },
      hover = {
        enabled = false,
      },
      signature = {
        enabled = false,
      },
    },

    routes = {
      {
        view = "virtualtext",
        filter = { event = "msg_show", kind = "search_count" },
      },
    },
  },
}
