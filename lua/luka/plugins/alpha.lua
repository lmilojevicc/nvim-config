return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    local header = {
      type = "text",
      val = {
        "███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
        "████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
        "██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
        "██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
        "██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
        "╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
      },
      opts = {
        position = "center",
        hl = "DashboardHeader",
      },
    }

    local date_line = {
      type = "text",
      val = " " .. os.date("%A, %d %B %Y"),
      opts = {
        position = "center",
        hl = "DashboardHeader",
      },
    }

    -- Buttons
    dashboard.section.buttons.val = {
      dashboard.button("<leader> f f", "  Find File", "<cmd>Telescope find_files<CR>"),
      dashboard.button("<leader> f b", "  Find Buffers", "<cmd>Telescope buffers<CR>"),
      dashboard.button("<leader> f w", "󰈭  Live grep", "<cmd>Telescope live_grep<CR>"),
      dashboard.button("<leader> d w", "  Workspace Diagnostics", "<cmd>Telescope diagnostics<CR>"),
      dashboard.button("<leader> d d", "  Buffer Diagnostics", "<cmd>Telescope diagnostics bufnr=0<CR>"),
      dashboard.button("<leader> d c", "  TODO List", "<cmd>TodoTelescope<CR>"),
      dashboard.button("<leader> r n", "  Smart Rename", "<cmd>lua vim.lsp.buf.rename()<CR>"),
      dashboard.button("<leader> d l", "  Line Diagnostics", "<cmd>lua vim.diagnostic.open_float()<CR>"),
      dashboard.button("<leader> g h", "󱔗  Hover Documentation", "<cmd>lua vim.lsp.buf.hover()<CR>"),
      dashboard.button("<leader> r s", "  Restart LSP", "<cmd>LspRestart<CR>"),
      dashboard.button("K", "󰊕  Signature Help", "<cmd>lua vim.lsp.buf.signature_help()<CR>"),
    }

    -- Footer Placeholder (to be updated later)
    dashboard.section.footer.val = { "" }

    -- Apply highlight groups
    vim.api.nvim_set_hl(0, "DashboardHeader", { fg = "#89b4fa" })
    vim.api.nvim_set_hl(0, "DashboardButton", { fg = "#cba6f7" })
    vim.api.nvim_set_hl(0, "DashboardFooter", { fg = "#cba6f7" })

    -- Link highlights to sections
    dashboard.section.buttons.opts.hl = "DashboardButton"
    dashboard.section.footer.opts.hl = "DashboardFooter"

    dashboard.opts.layout = {
      { type = "padding", val = 5 },
      header,
      { type = "padding", val = 1 },
      date_line,
      { type = "padding", val = 2 },
      dashboard.section.buttons,
      { type = "padding", val = 2 },
      dashboard.section.footer,
    }

    alpha.setup(dashboard.opts)

    vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])

    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyVimStarted",
      callback = function()
        local lazy_stats = require("lazy").stats()
        local footer_text = string.format(
          "  Loaded %d/%d plugins in %d ms",
          lazy_stats.loaded,
          lazy_stats.count,
          math.floor(lazy_stats.startuptime)
        )
        dashboard.section.footer.val = { "", footer_text }
        pcall(vim.cmd.AlphaRedraw)
      end,
    })
  end,
}
