return {
  "akinsho/bufferline.nvim",
  version = "*",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = function(_, opts)
    if (vim.g.colors_name or ""):find("catppuccin") then
      opts.highlights = require("catppuccin.groups.integrations.bufferline").get()
    end

    opts.options = {
      -- stylua: ignore
      close_command = function(n) Snacks.bufdelete(n) end,
      -- stylua: ignore
      middle_mouse_command = function(n) Snacks.bufdelete(n) end,

      always_show_bufferline = true,

      diagnostics = "nvim_lsp",
      diagnostics_indicator = function(count, level, diagnostics_dict, context)
        local s = " "
        for e, n in pairs(diagnostics_dict) do
          local sym = e == "error" and " " or (e == "warning" and " " or "󰠠 ")
          s = n .. s .. sym
        end
        return s
      end,

      offsets = {
        { filetype = "snacks_layout_box" },
      },
    }
  end,

  keys = {
    { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Bufferline Toggle Pin" },
    { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Buffferline Delete Non-Pinned Buffers" },
    { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Bufferline Delete Buffers to the Right" },
    { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Bufferline Delete Buffers to the Left" },
    { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Bufferline Prev Buffer" },
    { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Bufferline Next Buffer" },
    { "[B", "<cmd>BufferLineMovePrev<cr>", desc = "Bufferline Move buffer prev" },
    { "]B", "<cmd>BufferLineMoveNext<cr>", desc = "Bufferline Move buffer next" },
    { "<leader>bl", "<cmd>BufferLinePick<cr>", desc = "Bufferline Pick Buffer" },
  },
}
