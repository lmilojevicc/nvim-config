return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        lua = { "stylua" },
        c = { "clang-format" },
        cpp = { "clang-format" },
        java = { "google-java-format" },
        go = { "gofumpt", "goimports-reviser" },
        bash = { "shfmt" },
        zsh = { "shfmt" },
        sh = { "shfmt" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
        html = { "prettierd", "prettier", stop_after_first = true },
        css = { "prettierd", "prettier", stop_after_first = true },
        json = { "prettierd", "prettier", stop_after_first = true },
        markdown = { "prettierd", "prettier", stop_after_first = true },
        jsx = { "prettierd", "prettier", stop_after_first = true },
        tsx = { "prettierd", "prettier", stop_after_first = true },
        sql = { "sqruff", stop_after_first = true },
        yaml = { "prettierd", "prettier", stop_after_first = true },
        toml = { "taplo" },
        python = function(bufnr)
          if require("conform").get_formatter_info("ruff_format", bufnr).available then
            return { "ruff_fix", "ruff_organize_imports", "ruff_format" }
          else
            return { "isort", "black" }
          end
        end,
      },

      format_after_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return { async = true, lsp_fallback = true }
      end,
    })
  end,

  -- stylua: ignore
  keys = {
    { "<leader>fo", function() require("conform").format({ async = true, lsp_fallback = true }) end, { desc = " Format file or selection" } },
  },
}
