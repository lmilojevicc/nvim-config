return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = {
    options = { component_separators = "" },
    sections = {
      lualine_a = { "mode" },
      lualine_b = {
        {
          "filename",
          file_status = true,
        },
        "branch",
        "diff",
      },
      lualine_c = {
        "%=",
        {
          function()
            local reg = vim.fn.reg_recording()
            return reg ~= "" and " " .. reg or ""
          end,
          cond = function()
            return vim.fn.reg_recording() ~= ""
          end,
          color = { fg = "#89b4fa" },
        },
      },
      lualine_x = {},
      lualine_y = {
        "diagnostics",
        {
          function()
            local lazy_status = require("lazy.status")
            return lazy_status.updates()
          end,
          cond = function()
            local lazy_status = require("lazy.status")
            return lazy_status.has_updates()
          end,
        },
        {
          "datetime",
          style = "%H:%M:%S",
        },
      },
      lualine_z = {
        {
          function()
            local devicons = require("nvim-web-devicons")
            local ft = vim.bo.filetype
            local icon, _ = devicons.get_icon_by_filetype(ft)
            icon = icon or ""

            local clients = vim.lsp.get_clients({ bufnr = 0 })
            local lsp_names = {}
            for _, client in ipairs(clients) do
              table.insert(lsp_names, client.name)
            end
            local lsp_text = #lsp_names > 0 and table.concat(lsp_names, ", ") or "No LSP"

            return string.format("%s %s", icon, lsp_text)
          end,
          icon = "",
        },
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
