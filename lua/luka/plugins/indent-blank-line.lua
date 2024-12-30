return {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPre", "BufNewFile" },
  main = "ibl",
  opts = {
    scope = {
      enabled = false, -- Disable scope highlighting if it's too intrusive
    },
  },
}
