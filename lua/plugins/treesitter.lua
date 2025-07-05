return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre" },

  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },

  opts = {
    ensure_installed = {
      "bash",
      "c",
      "cmake",
      "cpp",
      "diff",
      "dockerfile",
      "git_config",
      "git_rebase",
      "gitattributes",
      "gitcommit",
      "gitignore",
      "go",
      "gomod",
      "gosum",
      "gowork",
      "html",
      "java",
      "javascript",
      "jsdoc",
      "json",
      "jsonc",
      "lua",
      "luadoc",
      "luap",
      "markdown",
      "markdown_inline",
      "printf",
      "python",
      "query",
      "regex",
      "rust",
      "toml",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
      "xml",
      "yaml",
      "zig",
    },

    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },

    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<CR>",
        node_incremental = "<CR>",
        node_decremental = "<bs>",
      },
    },

    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
          ["as"] = "@struct.outer",
          ["is"] = "@struct.inner",
          ["aa"] = "@parameter.outer",
          ["ia"] = "@parameter.inner",
          ["ao"] = "@conditional.outer",
          ["io"] = "@conditional.inner",
          ["al"] = "@loop.outer",
          ["il"] = "@loop.inner",
          ["ak"] = "@block.outer",
          ["ik"] = "@block.inner",
          ["ar"] = "@return.outer",
          ["ir"] = "@return.inner",
          ["ai"] = "@interface.outer",
          ["ii"] = "@interface.inner",
        },
      },

      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          ["]f"] = "@function.outer",
          ["]c"] = "@class.outer",
          ["]s"] = "@struct.outer",
          ["]i"] = "@interface.outer",
          ["]r"] = "@return.outer",
          ["]o"] = "@conditional.outer",
          ["]l"] = "@loop.outer",
        },
        goto_next_end = {
          ["]F"] = "@function.outer",
          ["]C"] = "@class.outer",
          ["]S"] = "@struct.outer",
          ["]I"] = "@interface.outer",
          ["]R"] = "@return.outer",
          ["]O"] = "@conditional.outer",
          ["]L"] = "@loop.outer",
        },
        goto_previous_start = {
          ["[f"] = "@function.outer",
          ["[c"] = "@class.outer",
          ["[s"] = "@struct.outer",
          ["[i"] = "@interface.outer",
          ["[r"] = "@return.outer",
          ["[o"] = "@conditional.outer",
          ["[l"] = "@loop.outer",
        },
        goto_previous_end = {
          ["[F"] = "@function.outer",
          ["[C"] = "@class.outer",
          ["[S"] = "@struct.outer",
          ["[I"] = "@interface.outer",
          ["[R"] = "@return.outer",
          ["[O"] = "@conditional.outer",
          ["[L"] = "@loop.outer",
        },
      },
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
