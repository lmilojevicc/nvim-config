local jdtls = require("jdtls")
local home = os.getenv("HOME")
local workspace_path = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

-- See nvim-jdtls documentation for all available options
local config = {
  cmd = {
    "jdtls",
    "-data",
    workspace_path,
  },
  root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),
  settings = {
    java = {},
  },
  init_options = {
    bundles = {},
  },
  on_attach = function(client, bufnr)
    jdtls.setup_dap()
  end,
}

-- Start the server
jdtls.start_or_attach(config)
