return {
  {
    "zbirenbaum/copilot.lua",
    dependencies = "folke/snacks.nvim",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "BufReadPost",
    opts = function()
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

      return {
        suggestion = {
          enabled = false,
          auto_trigger = false,
          hide_during_completion = true,
          keymap = {
            accept = false, -- handled by nvim-cmp / blink.cmp
            next = "<M-]>",
            prev = "<M-[>",
          },
        },
        panel = { enabled = false },
        filetypes = {
          markdown = true,
          help = true,
        },
      }
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
    },
  },
}
