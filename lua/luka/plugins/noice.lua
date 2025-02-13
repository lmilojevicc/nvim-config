return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    notify = { enabled = false },
    messages = { enabled = false },
    cmdline = { enabled = true, view = "cmdline_popup" },
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
