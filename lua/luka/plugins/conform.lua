local utils = {
  has_local_config = function(filename, config_names)
    local Path = require("plenary.path")
    local root = vim.fn.getcwd()
    for _, name in ipairs(config_names) do
      local config_path = Path:new(root):joinpath(name)
      if config_path:exists() then
        return true
      end
    end
    return false
  end,
}

vim.g.format_on_save = true

local function toggle_format_on_save()
  vim.g.format_on_save = not vim.g.format_on_save
  local status = vim.g.format_on_save and "enabled" or "disabled"
  local message = string.format("Format on save %s", status)
  local level = vim.g.format_on_save and vim.log.levels.INFO or vim.log.levels.WARN
  vim.notify(message, level, {
    title = "Format on Save",
    icon = vim.g.format_on_save and "󰄳" or "󰅖",
  })
end

return {
  "stevearc/conform.nvim",
  event = { "BufEnter", "BufWritePre" },
  config = function()
    local conform = require("conform")

    local options = {
      formatters_by_ft = {
        lua = { "stylua" },
        c = { "clang-format" },
        cpp = { "clang-format" },
        java = { "google-java-format" },
        go = { "gofumpt", "goimports-reviser" },
        bash = { "shfmt" },
        css = { "prettier" },
        html = { "prettier" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        jsx = { "prettier" },
        tsx = { "prettier" },
        json = { "prettier" },
        markdown = { "prettier" },
        python = function(bufnr)
          if utils.has_local_config(bufnr, { ".pycodestyle" }) then
            return { "autopep8", "isort" }
          else
            return { "black", "isort" }
          end
        end,
      },

      format_on_save = function()
        return vim.g.format_on_save and {
          timeout_ms = 500,
          lsp_fallback = true,
        }
      end,
    }

    conform.setup(options)
  end,

  keys = {
    {
      "<leader>rt",
      toggle_format_on_save,
      desc = "Toggle format on save",
    },
    {
      "<leader>rf",
      mode = { "n", "v" },
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      desc = "Format file",
    },
  },
}
