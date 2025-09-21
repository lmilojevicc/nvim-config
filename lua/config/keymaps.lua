local map = vim.keymap.set

map("n", "<Esc>", ":noh<CR><Esc>", { noremap = true, silent = true })
map("n", ";", ":", { desc = " Enter command mode with ;" })

map("n", "<leader>qq", "<cmd>qa<cr>", { desc = " Quit All" })
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = " Exit terminal mode" })

map("n", "<C-c>", function()
  vim.fn.setreg("+", table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n"))
  vim.notify("Entire file yanked to clipboard!", vim.log.levels.INFO)
end, { desc = " Yank entire file" })

-- Vim native file navigation
map("n", "<leader>ee", ":Explore<CR>", { desc = " Open file explorer" })
map("n", "<leader>ff", ":find ", { desc = " Find file" })

-- Window navigation
map("n", "<C-h>", "<C-w>h", { desc = " Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = " Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = " Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = " Go to Right Window", remap = true })
map("t", "<C-h>", "<cmd>wincmd h<CR>", { desc = " Move to the left window from terminal mode" })
map("t", "<C-j>", "<cmd>wincmd j<CR>", { desc = " Move to the window below from terminal mode" })
map("t", "<C-k>", "<cmd>wincmd k<CR>", { desc = " Move to the window above from terminal mode" })
map("t", "<C-l>", "<cmd>wincmd l<CR>", { desc = " Move to the right window from terminal mode" })

-- VSCode like move line
map("n", "<A-Down>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = " Move Down" })
map("i", "<A-Down>", "<esc><cmd>m .+1<cr>==gi", { desc = " Move Down" })
map("v", "<A-Down>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = " Move Down" })
map("n", "<A-Up>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = " Move Up" })
map("i", "<A-Up>", "<esc><cmd>m .-2<cr>==gi", { desc = " Move Up" })
map("v", "<A-Up>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = " Move Up" })

-- VSCode like copy line
map("n", "<A-S-Down>", "<Cmd>t .<CR><Cmd>silent! normal! ==<CR>", { desc = " Duplicate line down" })
map("i", "<A-S-Down>", "<esc><Cmd>t .<CR><Cmd>silent! normal! ==<CR>gi", { desc = " Duplicate line down" })
map("v", "<A-S-Down>", ":t '>+0<CR><Cmd>silent! normal! gv=gv<CR>", { desc = " Duplicate selection down" })
map("n", "<A-S-Up>", "<Cmd>t .-1<CR><Cmd>silent! normal! ==<CR>", { desc = " Duplicate line up" })
map("i", "<A-S-Up>", "<esc><Cmd>t .-1<CR><Cmd>silent! normal! ==<CR>gi", { desc = " Duplicate line up" })
map("v", "<A-S-Up>", ":t '<-1<CR><Cmd>silent! normal! gv=gv<CR>", { desc = " Duplicate selection up" })

-- Keep selection after indent
map("v", "<", "<gv", { desc = " Indent left and keep selection" })
map("v", ">", ">gv", { desc = " Indent right and keep selection" })

-- Window splitting
map("n", "<leader>wv", "<C-w>v", { desc = " Split window vertically" })
map("n", "<leader>wh", "<C-w>s", { desc = " Split window horizontally" })
map("n", "<leader>we", "<C-w>=", { desc = " Equalize window size" })
map("n", "<leader>wd", "<cmd>close<CR>", { desc = " Close current window" })
map("n", "<leader>wO", "<C-w>o", { desc = " Close all other windows" })
map("n", "<leader>wF", function()
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local cfg = vim.api.nvim_win_get_config(win)
    if cfg.relative ~= "" then
      vim.api.nvim_win_close(win, false)
    end
  end
end, { desc = " Close all floating windows" })

-- Resize windows
map("n", "<leader>w<Up>", "<cmd>resize +2<cr>", { desc = " Increase Window Height" })
map("n", "<leader>w<Down>", "<cmd>resize -2<cr>", { desc = " Decrease Window Height" })
map("n", "<leader>w<Left>", "<cmd>vertical resize -2<cr>", { desc = " Decrease Window Width" })
map("n", "<leader>w<Right>", "<cmd>vertical resize +2<cr>", { desc = " Increase Window Width" })

map("n", "<leader>rm", "<cmd>vsplit README.md<CR>", { desc = " Open README in a new vertical split" })

local function cycle_floating_windows()
  local wins = vim.api.nvim_list_wins()
  local floating_wins = {}
  local current_win = vim.api.nvim_get_current_win()

  -- Collect all floating windows
  for _, win in ipairs(wins) do
    local config = vim.api.nvim_win_get_config(win)
    if config.relative ~= "" then
      table.insert(floating_wins, win)
    end
  end

  if #floating_wins == 0 then
    return
  end

  -- Find current floating window index
  local current_index = 1
  for i, win in ipairs(floating_wins) do
    if win == current_win then
      current_index = i
      break
    end
  end

  -- Move to next floating window (with wraparound)
  local next_index = (current_index % #floating_wins) + 1
  vim.api.nvim_set_current_win(floating_wins[next_index])
end

-- Create a keymap for this function
map("n", "<leader>wf", cycle_floating_windows, { desc = " Focus floating window" })

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

map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = " Next Search Result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = " Next Search Result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = " Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = " Prev Search Result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = " Prev Search Result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = " Prev Search Result" })

map("n", "<leader>jp", "<C-o>", { noremap = true, silent = true, desc = " Jump backward in jumplist" })
map("n", "<leader>jn", "<C-i>", { noremap = true, silent = true, desc = " Jump forward in jumplist" })
map("n", "<leader>ep", "g;", { noremap = true, silent = true, desc = " Jump to previous change (last edit)" })
-- stylua: ignore
map("n", "<leader>en", "g,", { noremap = true, silent = true, desc = " Jump to next change (forward in change list)" })
