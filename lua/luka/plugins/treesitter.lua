return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    ensure_installed = {
      "vim",
      "lua",
      "vimdoc",
      "html",
      "css",
      "javascript",
      "typescript",
      "tsx",
      "json",
      "c",
      "cpp",
      "rust",
      "cmake",
      "java",
      "go",
      "python",
      "bash",
      "regex",
      "markdown",
      "markdown_inline",
    },
    auto_install = true,
    highlight = {
      enable = true,
    },
    indent = {
      enable = true,
    },
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)

    vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
      callback = function()
        vim.cmd("TSBufEnable highlight")
      end,
    })
  end,
}
