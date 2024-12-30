vim.g.mapleader = " "
local map = vim.keymap.set

map("n", "<Esc>", ":noh<CR><Esc>", { noremap = true, silent = true })
map("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
map("n", ";", ":", { desc = "Enter command mode with ;" })

map("n", "<C-c>", function()
  vim.fn.setreg("+", table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n"))
  vim.notify("Entire file yanked to clipboard!", vim.log.levels.INFO)
end, { desc = "Yank entire file" })

map("n", "<leader>rl", function()
  vim.wo.relativenumber = not vim.wo.relativenumber
  vim.wo.number = true -- Always keep number enabled
end, { desc = "Toggle relative line numbers" })

-- VSCode like move line
map("n", "<A-Up>", ":m .-2<CR>==", { desc = "󰜸 Move line up" })
map("n", "<A-Down>", ":m .+1<CR>==", { desc = "󰜯 Move line down" })
map("i", "<A-Up>", "<Esc>:m .-2<CR>==gi", { desc = "󰜸 Move line up" })
map("i", "<A-Down>", "<Esc>:m .+1<CR>==gi", { desc = "󰜯 Move line down" })
map("v", "<A-Up>", ":m '<-2<CR>gv=gv", { desc = "󰜸 Move selection up" })
map("v", "<A-Down>", ":m '>+1<CR>gv=gv", { desc = "󰜯 Move selection down" })

-- VSCode like copy line
map("n", "<S-A-Up>", "YP", { desc = "󰆏 Duplicate line up" })
map("n", "<S-A-Down>", "Yp", { desc = "󰆏 Duplicate line down" })
map("i", "<S-A-Up>", "<Esc>YPgi", { desc = "󰆏 Duplicate line up" })
map("i", "<S-A-Down>", "<Esc>Ypgi", { desc = "󰆏 Duplicate line down" })
map("v", "<S-A-Up>", "y`>PgvO", { desc = "󰆏 Duplicate selection up" })
map("v", "<S-A-Down>", "y`>p`[v`]", { desc = "󰆏 Duplicate selection down" })

-- Toggle NvimTree
map("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { noremap = true, silent = true, desc = "Toggle NvimTree" })
map("n", "<leader>ef", "<cmd>NvimTreeFindFile<CR>", { desc = "Find current file in tree" })

-- Keep selection after indent
map("v", "<", "<gv", { desc = "Indent left and keep selection" })
map("v", ">", ">gv", { desc = "Indent right and keep selection" })

-- Notifications
map("n", "<leader>nd", function()
  require("noice").cmd("dismiss")
end, { desc = "Clear Noice Messages" })
map("n", "<leader>nt", function()
  require("noice").cmd("telescope")
end, { desc = "Seach messages with telescope" })
map("n", "<leader>ne", function()
  require("noice").cmd("errors")
end, { desc = "Show error messages" })

-- Window splitting
map("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
map("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
map("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
map("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

map("n", "<leader>x", function()
  local buftype = vim.bo.buftype
  if buftype == "terminal" then
    vim.cmd("bd!") -- Force close terminal buffers
  else
    require("snacks.bufdelete").delete() -- Use Snacks.bufdelete for other buffers
  end
end, { desc = "Close current buffer (file or terminal)" })
map("n", "<leader>X", "<cmd>BufferLineCloseOthers<CR>", { desc = "Close all other buffers" })
map("n", "<leader><tab>", "<cmd>bnext<CR>", { desc = "Go to next buffer" })
map("n", "<leader><S-tab>", "<cmd>bprevious<CR>", { desc = "Go to previous buffer" })

-- Search WhichKey mappings via Telescope
map("n", "<leader>wk", function()
  require("telescope.builtin").keymaps({
    modes = { "n", "i", "v", "x" },
    show_plug = false,
  })
end, { desc = "Search keymaps" })

-- Session manager
map("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" })
map("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Save session for auto session root dir" })

-- Telescope Diagnostics
map("n", "<leader>dw", "<cmd>Telescope diagnostics<CR>", { desc = "Telescope workspace diagnostics" })
map("n", "<leader>dd", "<cmd>Telescope diagnostics bufnr=0<CR>", { desc = "Telescope buffer diagnostics" })
map("n", "<leader>dq", "<cmd>Telescope quickfix<CR>", { desc = "Telescope quickfix list" })
map("n", "<leader>dc", "<cmd>TodoTelescope<CR>", { desc = "Telescope Todo Comments" })

-- Telescope search
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>")
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>")
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>")

-- Comments
map("n", "<leader>/", "<Plug>(comment_toggle_linewise_current)", { silent = true })
map("v", "<leader>/", "<Plug>(comment_toggle_linewise_visual)", { silent = true })

map({ "n", "t" }, "<A-i>", function()
  require("nvterm.terminal").toggle("float")
end, { desc = "Toggle floating terminal" })

map("n", "<leader>th", function()
  require("nvterm.terminal").toggle("horizontal")
end, { desc = "Toggle horizontal terminal" })

map("n", "<leader>tv", function()
  require("nvterm.terminal").toggle("vertical")
end, { desc = "Toggle vertical terminal" })

map("t", "<C-x>", [[<C-\><C-n>]], { desc = "Exit Terminal Mode" })
