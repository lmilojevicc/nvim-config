return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  opts = {
    options = {
      component_separators = "",
      globalstatus = true,
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = {
        {
          "filetype",
          icon_only = true,
          padding = { right = 0, left = 1 },
        },
        {
          "filename",
          icon_only = false,
          file_status = true,
          symbols = {
            modified = "●",
            readonly = "󰏮",
            unnamed = "[No Name]",
          },
          padding = { right = 1, left = 0 },
        },
        "branch",
        "diff",
      },
      lualine_c = {
        "%=",
        -- stylua: ignore
        {
          function() return "  " .. require("dap").status() end,
          cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
          color = function() return { fg = Snacks.util.color("Debug") } end,
        },
        -- stylua: ignore
        {
          function() local reg = vim.fn.reg_recording() return reg ~= "" and " " .. reg or "" end,
          cond = function() return vim.fn.reg_recording() ~= "" end,
          color = function() return { fg = Snacks.util.color("Debug") } end,
        },
      },
      lualine_x = {},
      lualine_y = {
        -- stylua: ignore
        {
          require("lazy.status").updates,
          cond = require("lazy.status").has_updates,
          color = function() return { fg = Snacks.util.color("SnacksDashboardIcon") } end,
          padding = 1
        },
        { "diagnostics", padding = 1 },
        {
          "lsp_status",
          icon = "",
          symbols = {
            spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
            done = "✓",
            separator = " ",
          },
          padding = { left = 1, right = 1 },
        },
      },
      lualine_z = {
        { "datetime", style = " %H:%M" },
      },
    },
    inactive_sections = {
      lualine_a = {
        {
          "filename",
          file_status = true,
        },
        "diagnostics",
        "diff",
      },
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
    extensions = {
      "trouble",
      "fzf",
      "nvim-dap-ui",
    },
  },
}
