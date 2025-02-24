return {
  "rmagatti/goto-preview",
  event = "LspAttach",
  config = true,
  keys = {
    {
      "gpd",
      "<cmd>lua require('goto-preview').goto_preview_definition()<CR>",
      mode = { "n" },
      desc = " Preview definition",
    },
    {
      "gpt",
      "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>",
      mode = { "n" },
      desc = " Preview type definition",
    },
    {
      "gpi",
      "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>",
      mode = { "n" },
      desc = " Preview implementation",
    },
    {
      "gpD",
      "<cmd>lua require('goto-preview').goto_preview_declaration()<CR>",
      mode = { "n" },
      desc = " Preview declaration",
    },
    {
      "gP",
      "<cmd>lua require('goto-preview').close_all_win()<CR>",
      mode = { "n" },
      desc = " Close all preview windows",
    },
    {
      "gpr",
      "<cmd>lua require('goto-preview').goto_preview_reference()<CR>",
      mode = { "n" },
      desc = " Preview references",
    },
  },
}
