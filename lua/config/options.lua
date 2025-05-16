vim.cmd("let g:netrw_liststyle = 3")

-- Global stausline
vim.opt.laststatus = 3

vim.opt.backspace = "indent,eol,start"
vim.opt.clipboard:append("unnamedplus")
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.scrolloff = 30

-- Indentation Settings
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true

-- Appearance Settings
vim.opt.fillchars = "eob: "
vim.opt.cmdheight = 0
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.signcolumn = "yes"
vim.opt.confirm = true
vim.opt.pumheight = 10

-- Line Numbers (Relative and Absolute)
vim.wo.number = true
vim.wo.relativenumber = true

-- Line Wrapping
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.list = false

-- Search Behavior
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true

-- Persistent undo
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("cache") .. "/undo"
