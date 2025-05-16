return {
  "mfussenegger/nvim-lint",
  enabled = false,
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      sh = { "shellcheck" },
      bash = { "shellcheck" },
      go = { "golangcilint" },
      python = { "pylint" },
    }

    require("lint.linters.pylint").args = {
      "--rcfile=" .. vim.fn.getcwd() .. "/.pylintrc",
    }

    -- Create an autocommand group for linting
    vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
