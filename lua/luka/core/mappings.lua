vim.g.mapleader = " "
local map = vim.keymap.set

map("n", "<Esc>", ":noh<CR><Esc>", { noremap = true, silent = true })
map("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
map("n", ";", ":", { desc = "Enter command mode with ;" })
map({ "n", "x" }, "j", [[v:count == 0 ? 'gj' : 'j']], { expr = true })
map({ "n", "x" }, "k", [[v:count == 0 ? 'gk' : 'k']], { expr = true })

map("n", "<C-c>", function()
  vim.fn.setreg("+", table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n"))
  vim.notify("Entire file yanked to clipboard!", vim.log.levels.INFO)
end, { desc = "Yank entire file" })

map("n", "<leader>rl", function()
  vim.wo.relativenumber = not vim.wo.relativenumber
  vim.wo.number = true -- Always keep number enabled
end, { desc = "Toggle relative line numbers" })

-- VSCode like move line
map("n", "<A-Up>", ":m .-2<CR>==", { silent = true, desc = "󰜸 Move line up" })
map("n", "<A-Down>", ":m .+1<CR>==", { silent = true, desc = "󰜯 Move line down" })
map("i", "<A-Up>", "<Esc>:m .-2<CR>==gi", { silent = true, desc = "󰜸 Move line up" })
map("i", "<A-Down>", "<Esc>:m .+1<CR>==gi", { silent = true, desc = "󰜯 Move line down" })
map("v", "<A-Up>", ":m '<-2<CR>gv=gv", { silent = true, desc = "󰜸 Move selection up" })
map("v", "<A-Down>", ":m '>+1<CR>gv=gv", { silent = true, desc = "󰜯 Move selection down" })

map("n", "<A-k>", ":m .-2<CR>==", { silent = true, desc = "󰜸 Move line up" })
map("n", "<A-j>", ":m .+1<CR>==", { silent = true, desc = "󰜯 Move line down" })
map("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { silent = true, desc = "󰜸 Move line up" })
map("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { silent = true, desc = "󰜯 Move line down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { silent = true, desc = "󰜸 Move selection up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { silent = true, desc = "󰜯 Move selection down" })

-- VSCode like copy line
map("n", "<S-A-Up>", "YP", { desc = "󰆏 Duplicate line up" })
map("n", "<S-A-Down>", "Yp", { desc = "󰆏 Duplicate line down" })
map("i", "<S-A-Up>", "<esc>ypgi", { desc = "󰆏 duplicate line up" })
map("i", "<S-A-Down>", "<esc>ypgi", { desc = "󰆏 duplicate line down" })
map("v", "<S-A-Up>", "y`>pgvo", { desc = "󰆏 duplicate selection up" })
map("v", "<S-A-Down>", "y`>p`[v`]", { desc = "󰆏 duplicate selection down" })

map("n", "<S-A-k>", "YP", { desc = "󰆏 Duplicate line up" })
map("n", "<S-A-j>", "Yp", { desc = "󰆏 Duplicate line down" })
map("i", "<S-A-k>", "<Esc>YPgi", { desc = "󰆏 Duplicate line up" })
map("i", "<S-A-j>", "<Esc>Ypgi", { desc = "󰆏 Duplicate line down" })
map("v", "<S-A-k>", "y`>PgvO", { desc = "󰆏 Duplicate selection up" })
map("v", "<S-A-j>", "y`>p`[v`]", { desc = "󰆏 Duplicate selection down" })

-- NvimTree
map("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { noremap = true, silent = true, desc = "Toggle NvimTree" })
map("n", "<leader>ex", "<cmd>NvimTreeClose<CR>", { noremap = true, silent = true, desc = "Close NvimTree" })
map("n", "<leader>ef", "<cmd>NvimTreeFindFile<CR>", { desc = "Find current file in tree" })
map("n", "<C-N>", "<cmd>NvimTreeToggle<CR>", { noremap = true, silent = true, desc = "Toggle NvimTree" })

-- Keep selection after indent
map("v", "<", "<gv", { desc = "Indent left and keep selection" })
map("v", ">", ">gv", { desc = "Indent right and keep selection" })

-- Notifications
map("n", "<leader>nd", function()
  Snacks.notifier.hide()
end, { desc = "Clear notifications" })
map("n", "<leader>nt", function()
  Snacks.picker.notifications()
end, { desc = "Search notifications" })
map("n", "<leader>ne", function()
  Snacks.picker.notifications({ filter = "error" })
end, { desc = "Show error notifications" })

-- Snacks Explorer
map(
  "n",
  "<leader>ee",
  "<cmd>lua Snacks.explorer.open()<CR>",
  { noremap = true, silent = true, desc = "Open Snacks Explorer" }
)
map("n", "<leader>ef", "<cmd>lua Snacks.explorer.reveal()<CR>", { desc = "Find current file in Snacks" })

-- Window splitting
map("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
map("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
map("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
map("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- Buffers
map("n", "<leader>x", function()
  local buftype = vim.bo.buftype
  if buftype == "terminal" then
    vim.cmd("bd!") -- Force close terminal buffers
  else
    require("snacks.bufdelete").delete() -- Use Snacks.bufdelete for other buffers
  end
end, { desc = "Close current buffer (file or terminal)" })
map("n", "<leader>X", "<cmd>BufferLineCloseOthers<CR>", { desc = "Close all other buffers" })
map("n", "]b", "<cmd>bnext<CR>", { desc = "Go to next buffer" })
map("n", "[b", "<cmd>bprevious<CR>", { desc = "Go to previous buffer" })

-- Search mappings
map("n", "<leader>wk", function()
  Snacks.picker.keymaps({
    modes = { "n", "i", "v", "x" },
  })
end, { desc = "Search keymaps" })

-- Session manager
map("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" })
map("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Save session for auto session root dir" })

-- Diagnostics
map("n", "<leader>dw", function()
  Snacks.picker.diagnostics()
end, { desc = "Workspace diagnostics" })
map("n", "<leader>dd", function()
  Snacks.picker.diagnostics_buffer()
end, { desc = "Buffer diagnostics" })
map("n", "<leader>dc", function()
  Snacks.picker.todo_comments()
end, { desc = "Todo Comments" })
map("n", "<leader>dq", "<cmd>Telescope quickfix<CR>", { desc = "Telescope quickfix list" })
map("n", "<leader>dt", function()
  local current_virtual_text = vim.diagnostic.config().virtual_text
  vim.diagnostic.config({
    virtual_text = not current_virtual_text,
    underline = not current_virtual_text,
    signs = not current_virtual_text,
  })
end, { desc = "Toggle Diagnostics" })

-- Telescope search
map("n", "<leader>ff", function()
  Snacks.picker.files()
end, { desc = "Find files" })
map("n", "<leader>fw", function()
  Snacks.picker.grep()
end, { desc = "Search text in project" })
map("n", "<leader>fb", function()
  Snacks.picker.buffers()
end, { desc = "List open buffers" })

-- Comments
map(
  "n",
  "<leader>/",
  "<Plug>(comment_toggle_linewise_current)",
  { silent = true, desc = "Toggle comment for current line" }
)
map(
  "v",
  "<leader>/",
  "<Plug>(comment_toggle_linewise_visual)",
  { silent = true, desc = "Toggle comment for selected lines" }
)

-- Terminal
map({ "n", "t" }, "<A-i>", function()
  Snacks.terminal.toggle()
end, { desc = "Toggle floating terminal" })

map("n", "<leader>th", function()
  Snacks.terminal.open()
end, { desc = "Toggle horizontal terminal" })

map("t", "<C-x>", [[<C-\><C-n>]], { desc = "Exit Terminal Mode" })

-- Multiple cursors
map({ "n", "x" }, "<leader>ce", "<Cmd>MultipleCursorsAddMatches<CR>", { desc = "Add cursor to all matches" })
map({ "n", "x" }, "<leader>cn", "<Cmd>MultipleCursorsAddJumpNextMatch<CR>", { desc = "Add cursor to next match" })

-- LSP preview mappings
map("n", "gpd", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", { desc = "Preview definition" })
map(
  "n",
  "gpt",
  "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>",
  { desc = "Preview type definition" }
)
map(
  "n",
  "gpi",
  "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>",
  { desc = "Preview implementation" }
)
map("n", "gpD", "<cmd>lua require('goto-preview').goto_preview_declaration()<CR>", { desc = "Preview declaration" })
map("n", "gP", "<cmd>lua require('goto-preview').close_all_win()<CR>", { desc = "Close all preview windows" })
map("n", "gpr", "<cmd>lua require('goto-preview').goto_preview_references()<CR>", { desc = "Preview references" })

-- Treesitter context
map("n", "<leader>tc", "<cmd>TSContextToggle<CR>", { desc = "Toggle Treesitter Context" })

-- Inlay hints
map("n", "<leader>gl", "<cmd>InlayHintsToggle<CR>", { desc = "Toggle Inlay Hints" })

-- Lazy
map("n", "<leader>lz", "<cmd>Lazy<CR>", { noremap = true, silent = true, desc = "Open Lazy" })
map("n", "<leader>lu", "<cmd>Lazy update<CR>", { noremap = true, silent = true, desc = "Update Lazy" })

-- Mason
map("n", "<leader>ms", "<cmd>Mason<CR>", { noremap = true, desc = "Open Mason" })

-- Colorscheme picker
map({ "n" }, "<leader>cp", function()
  Snacks.picker.colorschemes()
end, { desc = "Colorscheme picker" })
