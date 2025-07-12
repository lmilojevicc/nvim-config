return {
  "mason-org/mason.nvim",
  cmd = { "Mason" },
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
        "bashls",
        "clangd",
        "cmake",
        "cssls",
        "docker_compose_language_service",
        "dockerls",
        "emmet_language_server",
        "gopls",
        "html",
        "jdtls",
        "jsonls",
        "lua_ls",
        "marksman",
        "neocmake",
        "ruff",
        "rust_analyzer",
        "tailwindcss",
        "taplo",
        "vtsls",
        "zls",
      },

      automatic_enable = false,
      automatic_installation = true,
    })

    -- Tool installer setup
    require("mason-tool-installer").setup({
      ensure_installed = {
        "autopep8",
        "black",
        "clang-format",
        "cmakelang",
        "cmakelint",
        "codelldb",
        "delve",
        "eslint_d",
        "go-debug-adapter",
        "gofumpt",
        "goimports",
        "goimports-reviser",
        "golines",
        "hadolint",
        "isort",
        "java-debug-adapter",
        "java-test",
        "js-debug-adapter",
        "prettierd",
        "pylint",
        "shfmt",
        "sqlfluff",
        "stylua",
      },
    })
  end,

  build = ":MasonUpdate",

  keys = {
    { "<leader>ms", "<cmd>Mason<CR>", desc = "󰽤 Open Mason" },
  },
}
