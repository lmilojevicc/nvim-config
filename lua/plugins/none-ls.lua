return {
  "nvimtools/none-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        -- eslint_d: JavaScript/TypeScript linting
        require("none-ls.diagnostics.eslint_d").with({
          filetypes = {
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "vue",
            "svelte",
          },
        }),
        -- golangci-lint: Go linting
        null_ls.builtins.diagnostics.golangci_lint.with({
          filetypes = { "go" },
          args = {
            "run",
            "--output.json.path",
            "stdout",
            "--show-stats=false",
            "--issues-exit-code=1",
            "--enable=bodyclose,gosec,exhaustruct,errname,errorlint,wrapcheck,noctx,nilnil,nilerr,prealloc,predeclared,modernize,mnd,gocritic",
            "--disable=errcheck",
          },
        }),
        -- hadolint: Dockerfile linting
        null_ls.builtins.diagnostics.hadolint.with({
          filetypes = { "dockerfile" },
        }),
        -- sqruff: SQL linting
        null_ls.builtins.diagnostics.sqruff.with({
          filetypes = { "sql" },
        }),
      },
    })
  end,
}
