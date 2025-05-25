local map = vim.keymap.set

-- Leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

map("n", "<Esc>", ":noh<CR><Esc>", { noremap = true, silent = true })
map("n", ";", ":", { desc = "Enter command mode with ;" })

map("n", "<C-c>", function()
  vim.fn.setreg("+", table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n"))
  vim.notify("Entire file yanked to clipboard!", vim.log.levels.INFO)
end, { desc = " Yank entire file" })

if not os.getenv("TMUX") then
  map("n", "<C-h>", "<C-w>h", { desc = " Go to Left Window", remap = true })
  map("n", "<C-j>", "<C-w>j", { desc = " Go to Lower Window", remap = true })
  map("n", "<C-k>", "<C-w>k", { desc = " Go to Upper Window", remap = true })
  map("n", "<C-l>", "<C-w>l", { desc = " Go to Right Window", remap = true })

  map("t", "<C-h>", "<cmd>wincmd h<CR>", { desc = " Move to the left window from terminal mode" })
  map("t", "<C-j>", "<cmd>wincmd j<CR>", { desc = " Move to the window below from terminal mode" })
  map("t", "<C-k>", "<cmd>wincmd k<CR>", { desc = " Move to the window above from terminal mode" })
  map("t", "<C-l>", "<cmd>wincmd l<CR>", { desc = " Move to the right window from terminal mode" })
end

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = " Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = " Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = " Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = " Increase Window Width" })

-- VSCode like move line
map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = " Move Down" })
map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = " Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = " Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = " Move Up" })
map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = " Move Down" })
map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = " Move Up" })

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
map("n", "<leader>so", "<C-w>o", { desc = " Close all other splits" })
map("n", "<leader>sf", function()
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local cfg = vim.api.nvim_win_get_config(win)
    if cfg.relative ~= "" then
      vim.api.nvim_win_close(win, false)
    end
  end
end, { desc = " Close all floating windows" })

-- Buffers
map("n", "]b", "<cmd>bnext<CR>", { desc = " Go to next buffer" })
map("n", "[b", "<cmd>bprevious<CR>", { desc = " Go to previous buffer" })

-- Diagnostics
map("n", "<leader>ud", function()
  local current_virtual_text = vim.diagnostic.config().virtual_text
  vim.diagnostic.config({
    virtual_text = not current_virtual_text,
    underline = not current_virtual_text,
    signs = not current_virtual_text,
  })
end, { desc = "󰨚 Toggle Diagnostics" })

local diagnostic_goto = function(next, severity)
  local count = next and 1 or -1
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    vim.diagnostic.jump({ count = count, severity = severity, float = true })
  end
end

map("n", "<leader>dl", vim.diagnostic.open_float, { desc = " Line Diagnostics" })
map("n", "]d", diagnostic_goto(true), { desc = " Next Diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = " Prev Diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = " Next Error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = " Prev Error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = " Next Warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = " Prev Warning" })

-- Terminal
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
