return {
  "akinsho/bufferline.nvim",
  version = "*",
  event = "BufReadPre",
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

      always_show_bufferline = false,

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
    { "<leader>bX", "<cmd>BufferLineCloseOthers<CR>", desc = " Close all other buffers" },
  },
}
