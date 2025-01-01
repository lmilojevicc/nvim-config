return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    quickfile = { enabled = true },
    words = { enabled = true },
    dashboard = {
      preset = {
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "R", desc = "Restore Session", section = "session" },
          { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
          { icon = " ", key = "G", desc = "LazyGit", action = "<leader>lg" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
      header = {
        text = {
          "███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
          "████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
          "██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
          "██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
          "██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
          "╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
        },
        hl = "SnacksDashboardHeader",
      },
      sections = {
        { section = "header" },
        { text = { " " .. os.date("%A, %d %B %Y"), hl = "SnacksDashboardHeader" }, padding = 1, align = "center" },
        { icon = " ", title = "Keymaps", section = "keys", padding = 1 },
        { icon = " ", title = "Projects", section = "projects", padding = 1 },
        {
          section = "terminal",
          icon = " ",
          title = "Git Status",
          enabled = vim.fn.isdirectory(".git") == 1,
          cmd = 'git rev-parse --is-inside-work-tree >/dev/null 2>&1 && PAGER="" GIT_PAGER="" git -P diff --stat -B -M -C || echo "Not a git repository" ',
          height = 8,
          padding = 2,
          indent = 0,
        },
        { section = "startup" },
      },
      highlights = {
        SnacksDashboardHeader = { fg = "#89b4fa" },
        SnacksDashboardButton = { fg = "#cba6f7" },
        SnacksDashboardFooter = { fg = "#cba6f7" },
      },
    },
    indent = {
      enabled = true,
      filter = function(buf)
        local ft = vim.bo[buf].filetype
        return ft ~= "markdown"
          and vim.g.snacks_indent ~= false
          and vim.b[buf].snacks_indent ~= false
          and vim.bo[buf].buftype == ""
      end,
    },
    scroll = { enabled = true },
    zen = { enabled = true, toggles = { dim = false } },
    lazygit = { enabled = true },
  },

  keys = {
    {
      "<leader>zm",
      function()
        Snacks.zen()
      end,
      desc = "Toggle Zen Mode",
    },
    {
      "<leader>lg",
      function()
        Snacks.lazygit.open()
      end,
      desc = "Open Lazygit",
    },
    {
      "<leader>ll",
      function()
        Snacks.lazygit.log()
      end,
      desc = "Lazygit log",
    },
  },
}
