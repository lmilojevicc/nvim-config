return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },

  config = function()
    require("mason").setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    -- LSP setup
    vim.defer_fn(function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "html",
          "cssls",
          "clangd",
          "pyright",
          "rust_analyzer",
          "cmake",
          "jdtls",
          "tailwindcss",
          "gopls",
          "bashls",
          "jsonls",
          "golangci_lint_ls",
          "emmet_language_server",
          "ts_ls",
        },
        automatic_installation = true,
      })
    end, 0)

    -- Tool installer setup
    require("mason-tool-installer").setup({
      ensure_installed = {
        "prettier",
        "stylua",
        "isort",
        "black",
        "autopep8",
        "pylint",
        "eslint_d",
        "clang-format",
        "google-java-format",
      },
      auto_update = true,
      run_on_start = true,
    })
  end,
  build = ":MasonUpdate",
}
