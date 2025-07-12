return {
  "brenton-leighton/multiple-cursors.nvim",
  event = "VeryLazy",
  opts = {},
  --stylua: ignore
  keys = {
    { mode = { "n", "x" }, "<leader>cU", "<Cmd>MultipleCursorsAddMatches<CR>", desc = " Add cursor to all matches", },
    { mode = { "n", "x" }, "<leader>cu", "<Cmd>MultipleCursorsAddJumpNextMatch<CR>", desc = " Add cursor to next match", },
    { mode = { "n", "x" }, "<MiddleMouse>", "<Cmd>MultipleCursorsMouseAddDelete<CR>", desc = " Add or remove cursor with click", },
  },
}
