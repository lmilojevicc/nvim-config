-- # Create a directory for extensions
-- mkdir -p ~/.local/share/nvim/java-debug-extensions
--
-- # Clone and build java-debug
-- cd ~/.local/share/nvim/java-debug-extensions
-- git clone https://github.com/microsoft/java-debug
-- cd java-debug
-- ./mvnw clean install
--
-- # Clone and build vscode-java-test (optional, for test debugging)
-- cd ~/.local/share/nvim/java-debug-extensions
-- git clone https://github.com/microsoft/vscode-java-test
-- cd vscode-java-test
-- npm install
-- npm run build-plugin

local jdtls = require("jdtls")
local home = os.getenv("HOME")
local workspace_path = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

-- Add bundles from java-debug and vscode-java-test
local bundles = {}
local extensions_dir = home .. "/.local/share/nvim/java-debug-extensions"

-- java-debug bundles
vim.list_extend(
  bundles,
  vim.split(
    vim.fn.glob(
      extensions_dir .. "/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar"
    ),
    "\n"
  )
)

vim.list_extend(bundles, vim.split(vim.fn.glob(extensions_dir .. "/vscode-java-test/server/*.jar"), "\n"))

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
