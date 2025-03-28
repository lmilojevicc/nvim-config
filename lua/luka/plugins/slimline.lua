return {
  "sschleemilch/slimline.nvim",
  enabled = false,
  event = "VeryLazy",
  opts = {
    hl = {
      modes = {
        normal = "Function",
        insert = "Type",
        pending = "Boolean",
        visual = "Keyword",
        command = "String",
      },
      base = "Comment",
      primary = "Function",
      secondary = "Keyword",
    },
    components = {
      center = {
        "recording",
      },
      right = {
        "diagnostics",
        "filetype_lsp",
      },
    },
  },
}
