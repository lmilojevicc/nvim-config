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

local is_active = true

local function toggle_format_after_save()
  is_active = not is_active

  local conform = require("conform")
  conform.setup({
    format_after_save = is_active and { lsp_fallback = true } or false,
  })

  local status = is_active and "enabled" or "disabled"
  local message = string.format("Format after save %s", status)
  local level = is_active and vim.log.levels.INFO or vim.log.levels.WARN
  vim.notify(message, level, {
    title = "Format After Save",
    icon = is_active and "󰄳" or "󰅖",
  })
end

return {
  "stevearc/conform.nvim",
  event = { "BufWritePost" },
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
        javascript = { "prettierd", "prettier" },
        typescript = { "prettierd", "prettier" },
        javascriptreact = { "prettierd", "prettier" },
        typescriptreact = { "prettierd", "prettier" },
        html = { "prettierd", "prettier" },
        css = { "prettierd", "prettier" },
        json = { "prettierd", "prettier" },
        markdown = { "prettierd", "prettier" },
        jsx = { "prettierd", "prettier" },
        tsx = { "prettierd", "prettier" },
        python = function(bufnr)
          if utils.has_local_config(bufnr, { ".pycodestyle" }) then
            return { "autopep8", "isort" }
          else
            return { "black", "isort" }
          end
        end,
      },

      format_after_save = {
        lsp_fallback = true,
      },
    }

    conform.setup(options)
  end,

  keys = {
    -- stylua: ignore start
    { "<leader>rt", toggle_format_after_save, desc = "󰚟 Toggle format after save" },
    { "<leader>rf", mode = { "n" }, function() require("conform").format({ async = true, lsp_fallback = true }) end, desc = "󰚟 Format file" },
    { "<leader>rs", mode = { "v" }, function() require("conform").format({ async = true, lsp_fallback = true }) end, desc = "󰚟 Format selection" },
    -- stylua: ignore end
  },
}
