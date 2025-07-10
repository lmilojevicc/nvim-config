return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "catppuccin/nvim",
  },
  event = "VeryLazy",
  opts = function()
    local colors = require("catppuccin.palettes").get_palette()
    colors["lighter_base"] = "#232634"
    local custom_catppuccin = require("lualine.themes.catppuccin")

    custom_catppuccin.normal.c.bg = "none"
    custom_catppuccin.command.a = { fg = colors.green, bg = colors.lighter_base }
    custom_catppuccin.normal.a = { fg = colors.blue, bg = colors.lighter_base }
    custom_catppuccin.inactive.a = { fg = colors.lavender, bg = colors.lighter_base }
    custom_catppuccin.insert.a = { fg = colors.peach, bg = colors.lighter_base }
    custom_catppuccin.replace.a = { fg = colors.red, bg = colors.lighter_base }
    custom_catppuccin.terminal.a = { fg = colors.teal, bg = colors.lighter_base }
    custom_catppuccin.visual.a = { fg = colors.mauve, bg = colors.lighter_base }

    return {
      options = {
        theme = custom_catppuccin,
        component_separators = "",
        section_separators = { left = "", right = "" },
        globalstatus = true,
      },

      sections = {
        lualine_a = {
          {
            "mode",
            icon = "",
          },
        },
        lualine_b = {},
        lualine_c = {
          {
            "filetype",
            icon_only = true,
            colored = false,
            color = { fg = colors.blue },
            padding = { left = 1, right = 0 },
            fmt = function(str)
              if str == "" then
                return " "
              end
              return str
            end,
          },
          {
            "filename",
            icon_only = false,
            file_status = true,
            symbols = {
              modified = "●",
              readonly = "󰏮",
              unnamed = "",
            },
            padding = { right = 1, left = 0 },
            color = { fg = colors.blue },
          },
          {
            "branch",
            icon = "󰘬",
            color = { fg = colors.peach },
            fmt = function(str)
              if str == "" then
                return str
              end

              -- Cache results to avoid frequent git calls
              local cache_key = vim.fn.getcwd() .. "_" .. str
              local cache = vim.g.lualine_git_cache or {}
              local cache_time = cache[cache_key] and cache[cache_key].time or 0
              local current_time = os.time()

              -- Update cache every 5 seconds to balance performance and accuracy
              if current_time - cache_time > 5 then
                local ahead = 0
                local behind = 0

                -- Check for unpushed commits (ahead)
                local ahead_cmd = "git log @{upstream}.. --oneline 2>/dev/null | wc -l"
                local ahead_result = vim.fn.system(ahead_cmd)
                if vim.v.shell_error == 0 then
                  ahead = tonumber(ahead_result) or 0
                end

                -- Check for unpulled commits (behind)
                local behind_cmd = "git log ..@{upstream} --oneline 2>/dev/null | wc -l"
                local behind_result = vim.fn.system(behind_cmd)
                if vim.v.shell_error == 0 then
                  behind = tonumber(behind_result) or 0
                end

                cache[cache_key] = {
                  ahead = ahead,
                  behind = behind,
                  time = current_time,
                }
                vim.g.lualine_git_cache = cache
              end

              local git_status = cache[cache_key]
              if not git_status then
                return str
              end

              local indicators = ""
              if git_status.ahead > 0 then
                indicators = indicators .. "↑" .. git_status.ahead
              end
              if git_status.behind > 0 then
                indicators = indicators .. "↓" .. git_status.behind
              end

              return str .. (indicators ~= "" and " " .. indicators or "")
            end,
          },
          {
            "diff",
            colored = true,
            symbols = { added = " ", modified = " ", removed = " " },
          },
          {
            "diagnostics",
            sources = { "nvim_diagnostic" },
            symbols = { error = "󰅚 ", warn = " ", info = " ", hint = "󰛩 " },
            colored = true,
            -- always_visible = true,
          },

          "%=",

          -- stylua: ignore
          {
            function() return " " .. require("dap").status() end,
            cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
            color = { fg = colors.red },
          },

          -- stylua: ignore
          {
            function() local reg = vim.fn.reg_recording() return reg ~= "" and "󰺕 " .. reg or "" end,
            cond = function() return vim.fn.reg_recording() ~= "" end,
            color = { fg = colors.red },
          },
        },
        lualine_x = {
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = { fg = colors.lavender },
          },
          -- Indentation
          {
            function()
              if vim.bo.expandtab then
                return "SPC " .. vim.bo.shiftwidth
              else
                return "TAB " .. vim.bo.tabstop
              end
            end,
            color = { fg = colors.rosewater },
          },
          -- Formatter status
          {
            function()
              local status, conform = pcall(require, "conform")
              if not status then
                return ""
              end

              local lsp_format = require("conform.lsp_format")

              local formatters = conform.list_formatters_for_buffer()
              if formatters and #formatters > 0 then
                local formatterNames = {}

                for _, formatter in ipairs(formatters) do
                  table.insert(formatterNames, formatter)
                end

                return "󰷈 " .. table.concat(formatterNames, " ")
              end

              local bufnr = vim.api.nvim_get_current_buf()
              local lsp_clients = lsp_format.get_format_clients({ bufnr = bufnr })

              if not vim.tbl_isempty(lsp_clients) then
                return "󰷈 LSP Formatter"
              end

              return ""
            end,
            color = { fg = colors.flamingo },
            padding = 1,
          },
          {
            "lsp_status",
            icon = "",
            symbols = {
              spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
              done = "✓",
              separator = " ",
            },
            padding = 1,
            color = { fg = colors.pink },
          },
        },
        lualine_y = {},
        lualine_z = { "progress" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
      },
    }
  end,
}
