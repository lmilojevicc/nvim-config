return {
  "akinsho/bufferline.nvim",
  version = "*",
  event = "BufReadPre",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("bufferline").setup({
      highlights = {
        separator = {
          fg = "#414149",
          bg = "#11111B",
        },
        separator_visible = {
          fg = "#414149",
          bg = "#11111B",
        },
        separator_selected = {
          fg = "#414149",
          bg = "#11111B",
        },
      },
      options = {
        separator_style = { " | ", " | " }, -- Custom separators
        indicator = {
          style = "none",
        },
        offsets = {
          {
            filetype = "snacks_layout_box",
            separator = true,
          },
        },
        diagnostics = "nvim_lsp",
        show_buffer_close_icons = true,
        show_close_icon = true,
      },
    })
  end,
  keys = {
    { "<leader>X", "<cmd>BufferLineCloseOthers<CR>", desc = " Close all other buffers" },
  },
}
