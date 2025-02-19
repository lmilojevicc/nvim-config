return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    quickfile = { enabled = true },
    input = {
      enabled = true,
      win = {
        relative = "cursor",
        width = 60,
        row = -3,
        col = 0,
        style = "input",
      },
    },
    explorer = { enabled = true, replace_netrw = true, auto_close = true },
    notifier = { enabled = true },
    picker = {
      layout = "telescope",
      files = { hidden = true },
      sources = {
        explorer = { auto_close = true, hidden = true },
      },
    },
    terminal = { enabled = true },
    image = { enabled = true },
    dashboard = {
      preset = {
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "w", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
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
    -- Zen
    {
      "<leader>zm",
      function()
        Snacks.zen()
      end,
      desc = "Toggle Zen Mode",
    },

    -- Lazygit
    {
      "<leader>lg",
      function()
        Snacks.lazygit.open()
      end,
      desc = " Open Lazygit",
    },
    {
      "<leader>ll",
      function()
        Snacks.lazygit.log()
      end,
      desc = " Lazygit log",
    },
  },
}
