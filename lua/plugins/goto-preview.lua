return {
  "rmagatti/goto-preview",
  event = "LspAttach",
  config = true,
  -- stylua: ignore 
  keys = {
    { "gpd", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", desc = " Preview definition", },
    { "gpt", "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>", desc = " Preview type definition", },
    { "gpi", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", desc = " Preview implementation", },
    { "gpD", "<cmd>lua require('goto-preview').goto_preview_declaration()<CR>", desc = " Preview declaration", },
    { "gP", "<cmd>lua require('goto-preview').close_all_win()<CR>", desc = " Close all preview windows", },
    { "gpr", "<cmd>lua require('goto-preview').goto_preview_reference()<CR>", desc = " Preview references", },
  },
}
