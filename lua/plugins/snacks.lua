---@module 'snacks'

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    input = {
      enabled = true,
      win = { relative = "cursor", width = 60, row = -3, col = 0, style = "input" },
    },
    picker = {
      layout = "default",
      files = { hidden = true },
      sources = { explorer = { auto_close = true, hidden = true, ignored = true } },
    },
    dashboard = {
      preset = {
        -- stylua: ignore
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = function() Snacks.picker.files({ hidden = true }) end, },
          { icon = "󱎸 ", key = "g", desc = "RipGrep", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = "󰦛 ", key = "r", desc = "Restore Last Session", action = function() require("persistence").load() end, },
          { icon = " ", key = "R", desc = "Pick Session", action = function() require("persistence").select() end, },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "l", desc = "LazyGit", action = "<leader>lg" },
          { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
          { icon = " ", key = "m", desc = "Mason", action = ":Mason" },
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
    },
    explorer = { enabled = true, replace_netrw = true, auto_close = true },
    notifier = { enabled = true },
    bigfile = { enabled = true },
    quickfile = { enabled = true },
    terminal = { enabled = true },
    image = { enabled = true },
    words = { enabled = false },
    indent = { enabled = true },
    scroll = { enabled = false },
    zen = { enabled = true, toggles = { dim = false } },
    toggle = { enabled = true },
    lazygit = { enabled = true },
    statuscolumn = { enabled = true },
  },

  -- stylua: ignore
  keys = {
    -- Zen
    { "<leader>zm", function() Snacks.zen() end, desc = "󰾞 Toggle Zen Mode", },

    -- Lazygit
    { "<leader>lg", function() Snacks.lazygit.open() end, desc = " Open Lazygit", },
    { "<leader>ll", function() Snacks.lazygit.log() end, desc = " Lazygit log", },

    -- Notificiations
    { "<leader>nd", function() Snacks.notifier.hide() end, desc = "󰎟 Clear notifications", },
    { "<leader>nf", function() Snacks.picker.notifications() end, desc = " Search notifications", },
    { "<leader>ne", function() Snacks.picker.notifications({ filter = "error" }) end, desc = "󰎟 Show error notifications", },

    -- Explorer
    { "<leader>ee", function() Snacks.explorer.open() end, desc = " Open Snacks Explorer", },

    -- Buffer
    { "<leader>bd", function() Snacks.bufdelete() end, desc = " Delete current buffer (file or terminal)", },
    { "<leader>bo", function() Snacks.bufdelete.other() end, desc = " Delete other buffers", },

    -- Keymaps
    {
      "<leader>wk",
      function()
        Snacks.picker.keymaps({
          format = function(item, picker)
            -- Extract key from item.text (everything until the first space)
            local key = item.text and item.text:match("^[^%s]+") or ""

            -- Calculate lengths for alignment
            local mode = item.mode or ""
            local desc = item.item.desc or ""
            local mode_width = 5
            local key_width = 15
            local desc_width = 40

            -- Pad strings to fit the column widths
            local padded_mode = mode .. string.rep(" ", mode_width - #mode)
            local padded_key = key .. string.rep(" ", key_width - #key)
            local padded_desc = desc .. string.rep(" ", desc_width - #desc)

            return {
              { padded_mode, "String" },
              { padded_key, "ErrorMsg" },
              { padded_desc, "Function" },
            }
          end,
        })
      end,
      desc = " Search keymaps",
    },

    -- LSP
    { "gr", function() Snacks.picker.lsp_references() end, desc = " Show LSP references", },
    { "gD", function() Snacks.picker.lsp_declarations() end, desc = " Go to declaration", },
    { "gd", function() Snacks.picker.lsp_definitions() end, desc = " Show LSP definitions", },
    { "gi", function() Snacks.picker.lsp_implementations() end, desc = " Show LSP implementations", },
    { "gt", function() Snacks.picker.lsp_type_definitions() end, desc = " Show LSP type definitions", },
    { "<leader>fs", function() Snacks.picker.lsp_symbols() end, desc = " Show document symbols", },
    { "<leader>fS", function() Snacks.picker.lsp_workspace_symbols() end, desc = " Show document symbols", },

    -- Search
    { "<leader>ff", function() Snacks.picker.files({ hidden = true }) end, desc = " Find files", },
    { "<leader>fg", function() Snacks.picker.grep() end, desc = " Grep in workspace", },
    { mode = {"n", "v"}, "<leader>fw", function() Snacks.picker.grep_word() end, desc = " Grep in workspace", },
    { "<leader>fb", function() Snacks.picker.buffers() end, desc = " List open buffers", },

    -- Terminal
    { mode = { "n", "t" }, "<A-t>", function() Snacks.terminal.toggle() end, desc = "󰨚 Toggle floating terminal", },

    -- Git Pickers
    { "<leader>gs", function() Snacks.picker.git_status() end, desc = " Git Status" },
    { "<leader>gL", function() Snacks.picker.git_log_file() end, desc = " Git Current File History" },

    -- Lists
    { "<leader>qf", function() Snacks.picker.qflist() end, desc = " Quickfix list" },
    { "<leader>ql", function() Snacks.picker.loclist() end, desc = " Loclist" },

    -- Diagnostics
    { "<leader>fd", function() Snacks.picker.diagnostics_buffer() end, desc = " Buffer diagnostics", },
    { "<leader>fD", function() Snacks.picker.diagnostics() end, desc = " Workspace diagnostics", },
    { "<leader>fT", function() Snacks.picker.todo_comments() end, desc = " Todo Comments", },

    -- Pickers
    { "<leader>fl", function() Snacks.picker.lsp_config() end, desc = " Lsp Config", },
    { "<leader>fh", function() Snacks.picker.help() end, desc = "󰘥 Help Pages", },
    { "<leader>fM", function() Snacks.picker.man() end, desc = "󰘥 Man Pages", },
    { "<leader>fc", function() Snacks.picker.colorschemes() end, desc = " Colorscheme picker", },
    { "<leader>fi", function() Snacks.picker.icons({ icon_sources = { "nerd_fonts" } }) end, desc = "  Nerd Font Icons picker", },
    { "<leader>fm", function() Snacks.picker.marks() end, desc = " Marks" },
    { "<leader>fj", function() Snacks.picker.jumps() end, desc = "󰹹 Jumps" },
    { "<leader>fr", function() Snacks.picker.registers() end, desc = " Registers" },
    { "<leader>fP", function() Snacks.picker.projects() end, desc = " Projects" },
  },

  -- Setup toggle mappings
  config = function(_, opts)
    require("snacks").setup(opts)

    local Snacks = require("snacks")

    Snacks.toggle.inlay_hints():map("<leader>uh", { desc = "󰅩 Toggle Inlay Hints" })
    Snacks.toggle.diagnostics():map("<leader>ud", { desc = " Toggle Diagnostics" })
    Snacks.toggle.line_number():map("<leader>uL", { desc = "󰨚 Toggle Line Numbers" })
    Snacks.toggle.treesitter():map("<leader>uT", { desc = "󱘎 Toggle Treesitter" })
    Snacks.toggle.dim():map("<leader>uD", { desc = " Toggle Dim Mode" })
    Snacks.toggle.animate():map("<leader>ua", { desc = "󰪐 Toggle Animations" })
    Snacks.toggle.indent():map("<leader>ui", { desc = "󰉶 Toggle Indent Guides" })
    Snacks.toggle.scroll():map("<leader>uS", { desc = "󰹹 Toggle Smooth Scroll" })

    Snacks.toggle.option("spell"):map("<leader>us", { desc = "󰓆 Spell Checking" })
    Snacks.toggle.option("wrap"):map("<leader>uw", { desc = "󰖶 Word Wrap" })
    Snacks.toggle.option("relativenumber"):map("<leader>ul", { desc = "󰉻 Relative Line Numbers" })

    --stylua: ignore
    Snacks.toggle.option("conceallevel", { name = " Conceal", off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
    --stylua: ignore
    Snacks.toggle.option("showtabline", { name = "󰓩 Tabline", off = 0, on = vim.o.showtabline > 0 and vim.o.showtabline or 2 }):map("<leader>ut")

    Snacks.toggle.zoom():map("<leader>sz", { desc = " Toggle Zoom Split" })
    Snacks.toggle.words():map("<leader>uW", { desc = "󰺯 Toggle Word Highlighting" })

    Snacks.toggle({
      name = "Auto Format (Global)",
      get = function()
        return not vim.g.disable_autoformat
      end,
      set = function(state)
        vim.g.disable_autoformat = not state
        vim.b.disable_autoformat = false
      end,
    }):map("<leader>uf")

    Snacks.toggle({
      name = "Auto Format (Buffer)",
      get = function()
        return not vim.b.disable_autoformat
      end,
      set = function(state)
        vim.b.disable_autoformat = not state
      end,
    }):map("<leader>uF")
  end,
}
