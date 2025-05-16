local opt = vim.opt

vim.cmd("let g:netrw_liststyle = 3")
vim.g.markdown_recommended_style = 0 -- Fix markdown indentation settings

-- UI
opt.termguicolors = true
opt.background = "dark"
opt.cursorline = true
opt.signcolumn = "yes"
opt.showmode = false
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}
opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,a:blinkwait700-blinkon400-blinkoff250"
opt.pumheight = 10
opt.cmdheight = 0

vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.HINT] = "",
      [vim.diagnostic.severity.INFO] = "",
    },
  },
})

-- Editor
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.backspace = "indent,eol,start"
opt.confirm = true
if vim.fn.has("nvim-0.10") == 1 then
  opt.smoothscroll = true
end

-- Text Editing and Indentation
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.autoindent = true
opt.smartindent = true
opt.shiftround = true
opt.breakindent = true

-- Line Wrapping and Display
opt.wrap = true
opt.linebreak = true
opt.list = false

-- Navigation
vim.wo.number = true
vim.wo.relativenumber = true
opt.scrolloff = 999
opt.sidescrolloff = 20

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true

-- Files and buffers
opt.hidden = true
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.undodir = vim.fn.expand("~/.local/share/nvim/undodir")
opt.fileencoding = "utf-8"

-- Completion
opt.completeopt = { "menu", "menuone", "noselect", "noinsert" }

-- Window Management
opt.splitright = true
opt.splitbelow = true
opt.laststatus = 3

-- Performance
opt.redrawtime = 1500
opt.timeoutlen = 500
opt.ttimeoutlen = 10
opt.updatetime = 300
opt.ttyfast = true
