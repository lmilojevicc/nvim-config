return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },

  opts = {
    float = {
      max_width = 0.6,
      max_height = 0.6,
      border = "single",
    },
    ssh = {
      border = "single",
    },
    keymaps_help = {
      border = "single",
    },
    default_file_explorer = true,
    view_options = { show_hidden = true },
  },

  config = function(_, opts)
    require("oil").setup(opts)

    vim.api.nvim_create_autocmd("User", {
      pattern = "OilEnter",
      callback = vim.schedule_wrap(function(args)
        local oil = require("oil")
        if vim.api.nvim_get_current_buf() == args.data.buf and oil.get_cursor_entry() then
          oil.open_preview()
        end
      end),
    })
  end,

  --stylua: ignore
  keys = {
    { "<leader>oi", function() require("oil").toggle_float() end, desc = "󰿸 Open Floating Oil Nvim", },
  },
}
