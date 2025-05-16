return {
  "echasnovski/mini.surround",
  enabled = false,
  event = { "InsertEnter", "BufReadPost" },
  version = "*",
  opts = {
    mappings = {
      add = "<leader>sa",
      delete = "<leader>sd",
      find = "gsf",
      find_left = "gsF",
      highlight = "gsh",
      replace = "gsr",
      update_n_lines = "gsn",
    },
  },
}
