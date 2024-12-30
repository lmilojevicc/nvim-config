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

return {
  "stevearc/conform.nvim",
  event = { "BufEnter", "BufWritePre" },
  config = function()
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
        python = function(bufnr)
          if utils.has_local_config(bufnr, { ".pycodestyle" }) then
            return { "autopep8", "isort" }
          else
            return { "black", "isort" }
          end
        end,
      },

      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    }

    require("conform").setup(options)
  end,
}
