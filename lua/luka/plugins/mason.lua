return {
  "williamboman/mason.nvim",
  event = "BufReadPre",
  dependencies = {
    "mason-org/mason-lspconfig.nvim",
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
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "html",
        "cssls",
        "clangd",
        "basedpyright",
        "rust_analyzer",
        "cmake",
        "tailwindcss",
        "gopls",
        "bashls",
        "jsonls",
        "emmet_language_server",
        "ts_ls",
        "taplo",
        "jdtls",
      },

      automatic_enable = true, -- This replaces the need for setup_handlers
      automatic_installation = true,
    })

    -- Tool installer setup
    require("mason-tool-installer").setup({
      ensure_installed = {
        "prettierd",
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
    })
  end,

  build = ":MasonUpdate",
}
