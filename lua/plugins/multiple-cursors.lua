return {
  "brenton-leighton/multiple-cursors.nvim",
  event = { "InsertEnter", "BufReadPost" },
  opts = {},
  --stylua: ignore
  keys = {
    { mode = { "n", "x" }, "<leader>ce", "<Cmd>MultipleCursorsAddMatches<CR>", desc = " Add cursor to all matches", },
    { mode = { "n", "x" }, "<leader>cn", "<Cmd>MultipleCursorsAddJumpNextMatch<CR>", desc = " Add cursor to next match", },
    { mode = { "n", "x" }, "<MiddleMouse>", "<Cmd>MultipleCursorsMouseAddDelete<CR>", desc = " Add or remove cursor with click", },
  },
}
