return {
  "nvimtools/none-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  enabled = false,
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        require("none-ls.diagnostics.eslint_d"),
        null_ls.builtins.diagnostics.golangci_lint.with({
          args = {
            "run",
            "--output.json.path",
            "stdout",
            "--show-stats=false",
            "--issues-exit-code=1",
            "--enable=staticcheck,bodyclose,gosec,exhaustruct,errname,errorlint,wrapcheck,noctx,nilnil,nilerr,prealloc,predeclared,modernize,mnd,gocritic",
            "--disable=errcheck",
          },
        }),
        null_ls.builtins.diagnostics.hadolint,
        null_ls.builtins.diagnostics.sqruff,
        null_ls.builtins.code_actions.gomodifytags,
      },
    })
  end,
}
