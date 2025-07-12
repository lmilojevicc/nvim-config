return {
  {
    "zbirenbaum/copilot.lua",
    dependencies = "folke/snacks.nvim",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "BufReadPost",
    config = function()
      require("copilot").setup({
        should_attach = function(_, bufname)
          if string.match(bufname, "env") then
            return false
          end
          return true
        end,

        suggestion = {
          enabled = false,
          auto_trigger = false,
          hide_during_completion = true,
          keymap = {
            accept = false,
            next = "<M-]>",
            prev = "<M-[>",
          },
        },
        panel = { enabled = false },
        filetypes = {
          markdown = true,
          help = true,
        },
        copilot_model = "claude-sonnet-4",
      })

      local Snacks = require("snacks")
      Snacks.toggle({
        name = "Copilot",
        get = function()
          return not require("copilot.client").is_disabled()
        end,
        set = function(state)
          if state then
            require("copilot.command").enable()
          else
            require("copilot.command").disable()
          end
        end,
      }):map("<leader>cs", { desc = " Toggle Suggestions" })
    end,
  },
  {
    "yetone/avante.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "folke/snacks.nvim",
      "zbirenbaum/copilot.lua",
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = { file_types = { "markdown", "Avante" } },
        ft = { "markdown", "Avante" },
      },
    },
    build = "make",
    event = "VeryLazy",
    version = false,

    ---@module 'avante'
    ---@type avante.Config
    opts = {
      mode = "legacy",
      provider = "copilot",
      providers = {
        copilot = {
          endpoint = "https://api.githubcopilot.com",
          model = "claude-sonnet-4",
          proxy = nil, -- [protocol://]host[:port] Use this proxy
          allow_insecure = false, -- Allow insecure server connections
          timeout = 30000, -- Timeout in milliseconds
          extra_request_body = {
            temperature = 0,
            max_tokens = 20480,
          },
        },
      },
      windows = {
        ask = {
          start_insert = false,
        },
      },
    },
  },
}
