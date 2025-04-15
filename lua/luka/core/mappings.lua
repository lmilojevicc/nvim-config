vim.g.mapleader = " "
local map = vim.keymap.set

map("n", "<Esc>", ":noh<CR><Esc>", { noremap = true, silent = true })
map("n", ";", ":", { desc = "Enter command mode with ;" })

map("n", "<C-c>", function()
  vim.fn.setreg("+", table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n"))
  vim.notify("Entire file yanked to clipboard!", vim.log.levels.INFO)
end, { desc = " Yank entire file" })

map("n", "<leader>rl", function()
  vim.wo.relativenumber = not vim.wo.relativenumber
  vim.wo.number = true -- Always keep number enabled
end, { desc = "󰨚 Toggle relative line numbers" })

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

-- Keep selection after indent
map("v", "<", "<gv", { desc = " Indent left and keep selection" })
map("v", ">", ">gv", { desc = " Indent right and keep selection" })

-- Window splitting
map("n", "<leader>sv", "<C-w>v", { desc = " Split window vertically" })
map("n", "<leader>sh", "<C-w>s", { desc = " Split window horizontally" })
map("n", "<leader>se", "<C-w>=", { desc = " Make splits equal size" })
map("n", "<leader>sx", "<cmd>close<CR>", { desc = " Close current split" })

-- Buffers
map("n", "]b", "<cmd>bnext<CR>", { desc = " Go to next buffer" })
map("n", "[b", "<cmd>bprevious<CR>", { desc = " Go to previous buffer" })

-- Diagnostics
map("n", "<leader>dt", function()
  local current_virtual_text = vim.diagnostic.config().virtual_text
  vim.diagnostic.config({
    virtual_text = not current_virtual_text,
    underline = not current_virtual_text,
    signs = not current_virtual_text,
  })
end, { desc = "󰨚 Toggle Diagnostics" })

-- Terminal
-- map("t", "<C-x>", [[<C-\><C-n>]], { desc = " Exit Terminal Mode" })
map("t", "<C-x>", function()
  if vim.bo.filetype == "fzf" then
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-x>", true, true, true), "n", true)
  else
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, true, true), "n", true)
  end
end, { desc = " Exit Terminal Mode" })

-- Lazy
map("n", "<leader>lz", "<cmd>Lazy<CR>", { noremap = true, silent = true, desc = "󰽤 Open Lazy" })
map("n", "<leader>lu", "<cmd>Lazy update<CR>", { noremap = true, silent = true, desc = "󰚰 Update Lazy" })

-- Mason
map("n", "<leader>ms", "<cmd>Mason<CR>", { noremap = true, desc = "󰽤 Open Mason" })

-- Move between editor and terminal
map("t", "<C-h>", "<cmd>wincmd h<CR>", { desc = " Move to the left window from terminal mode" })
map("t", "<C-j>", "<cmd>wincmd j<CR>", { desc = " Move to the window below from terminal mode" })
map("t", "<C-k>", "<cmd>wincmd k<CR>", { desc = " Move to the window above from terminal mode" })
map("t", "<C-l>", "<cmd>wincmd l<CR>", { desc = " Move to the right window from terminal mode" })

-- Scrolling and centering
map("n", "<C-u>", "<C-u>zz", { desc = " Scroll up half a page and center the cursor" })
map("n", "<C-d>", "<C-d>zz", { desc = " Scroll down half a page and center the cursor" })

-- Search result navigation with centering
map("n", "n", "nzzzv", { desc = " Jump to next search result and center the cursor" })
map("n", "N", "Nzzzv", { desc = " Jump to previous search result and center the cursor" })

-- Paragraph navigation with centering
map("n", "}", "}zz", { desc = " Jump to next paragraph and center the cursor" })
map("n", "{", "{zz", { desc = " Jump to previous paragraph and center the cursor" })

-- Toggle spell checking
map("n", "<leader>ts", function()
  vim.opt_local.spell = not vim.opt_local.spell:get()
  vim.notify(
    "Spell check " .. (vim.opt_local.spell:get() and "enabled" or "disabled"),
    vim.log.levels.INFO,
    { title = "Toggle Spell Check" }
  )
end, { desc = "󰨚 Toggle spell check" })

-- Toggle wrap
map("n", "<leader>tw", function()
  vim.opt_local.wrap = not vim.opt_local.wrap:get()
  vim.notify(
    "Line wrap " .. (vim.opt_local.wrap:get() and "enabled" or "disabled"),
    vim.log.levels.INFO,
    { title = "Toggle Wrap" }
  )
end, { desc = "󰨚 Toggle line wrap" })

-- Copy file path to clipboard
map("n", "<leader>cp", function()
  local filepath = vim.fn.expand("%:p")
  vim.fn.setreg("+", filepath)
  vim.notify("Copied file path to clipboard: " .. filepath, vim.log.levels.INFO, { title = "Copy File Path" })
end, { desc = " Copy filepath to clipboard" })

-- Copy filename to clipboard
map("n", "<leader>cf", function()
  local filename = vim.fn.expand("%:t")
  vim.fn.setreg("+", filename)
  vim.notify("Copied file name to clipboard: " .. filename, vim.log.levels.INFO, { title = "Copy File Name" })
end, { desc = " Copy filename to clipboard" })
