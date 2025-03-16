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
      sources = { explorer = { auto_close = true, hidden = true } },
    },
    terminal = { enabled = true },
    image = { enabled = true },
    dashboard = {
      preset = {
        keys = {
          {
            icon = " ",
            key = "f",
            desc = "Find File",
            action = function()
              Snacks.picker.files({ hidden = true })
            end,
          },
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
      desc = "󰾞 Toggle Zen Mode",
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

    -- Notificiations
    {
      "<leader>nd",
      function()
        Snacks.notifier.hide()
      end,
      desc = "󰎟 Clear notifications",
    },
    {
      "<leader>nf",
      function()
        Snacks.picker.notifications()
      end,
      desc = " Search notifications",
    },
    {
      "<leader>ne",
      function()
        Snacks.picker.notifications({ filter = "error" })
      end,
      desc = "󰎟 Show error notifications",
    },

    -- Explorer
    {
      "<leader>ee",
      function()
        Snacks.explorer.open()
      end,
      desc = " Open Snacks Explorer",
    },
    {
      "<leader>ef",
      function()
        Snacks.explorer.reveal()
      end,
      desc = " Find current file in Snacks",
    },

    -- Buffer
    {
      "<leader>x",
      function()
        local buftype = vim.bo.buftype
        if buftype == "terminal" then
          vim.cmd("bd!")
        else
          require("snacks.bufdelete").delete()
        end
      end,
      desc = " Close current buffer (file or terminal)",
    },

    -- Keymaps
    {
      "<leader>wk",
      function()
        Snacks.picker.keymaps()
      end,
      desc = " Search keymaps",
    },

    -- Diagnostics
    {
      "<leader>dw",
      function()
        Snacks.picker.diagnostics()
      end,
      desc = " Workspace diagnostics",
    },
    {
      "<leader>db",
      function()
        Snacks.picker.diagnostics_buffer()
      end,
      desc = " Buffer diagnostics",
    },
    {
      "<leader>dc",
      function()
        Snacks.picker.todo_comments()
      end,
      desc = " Todo Comments",
    },

    -- Telescope like search
    {
      "<leader>ff",
      function()
        Snacks.picker.files({ hidden = true })
      end,
      desc = " Find files",
    },
    {
      "<leader>fw",
      function()
        Snacks.picker.grep()
      end,
      desc = " Grep text in workspace",
    },
    {
      "<leader>fb",
      function()
        Snacks.picker.buffers()
      end,
      desc = " List open buffers",
    },

    -- Terminal
    {
      mode = { "n", "t" },
      "<C-x>",
      function()
        Snacks.terminal.toggle()
      end,
      desc = "󰨚 Toggle floating terminal",
    },
    {
      "<leader>th",
      function()
        Snacks.terminal.open()
      end,
      desc = "󰨚 Toggle horizontal terminal",
    },

    -- Pickers
    {
      "<leader>hh",
      function()
        Snacks.picker.help()
      end,
      desc = "󰘥 Help Pages",
    },
    {
      "<leader>cp",
      function()
        Snacks.picker.colorschemes()
      end,
      { desc = " Colorscheme picker" },
    },
  },
}
