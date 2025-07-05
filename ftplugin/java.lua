local jdtls = require("jdtls")

-- Function to get the project root directory
local function get_root_dir()
  return require("jdtls.setup").find_root({ ".git", "mvnw", "pom.xml", "build.gradle" })
end

-- Function to get project name from root directory
local function get_project_name()
  local root_dir = get_root_dir()
  return root_dir and vim.fs.basename(root_dir) or "default"
end

-- Get paths dynamically
local home = vim.fn.expand("~")
local project_name = get_project_name()
local workspace_dir = home .. "/.cache/jdtls/" .. project_name

-- Determine OS
local system_os = ""
if vim.fn.has("mac") == 1 then
  system_os = "mac"
elseif vim.fn.has("unix") == 1 then
  system_os = "linux"
else
  system_os = "linux"
end

-- Mason installation paths for JDTLS
local mason_path = vim.fn.stdpath("data") .. "/mason"
local jdtls_path = mason_path .. "/packages/jdtls"
local lombok_path = jdtls_path .. "/lombok.jar"

-- Find the correct launcher jar (it may have version numbers)
local launcher_jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
if launcher_jar == "" then
  launcher_jar = jdtls_path .. "/plugins/org.eclipse.equinox.launcher.jar"
end

-- Debugging bundles
local bundles = {}

-- Java Debug Adapter
local java_debug_path = mason_path
  .. "/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"
local debug_jar = vim.fn.glob(java_debug_path)
if debug_jar ~= "" then
  table.insert(bundles, debug_jar)
end

-- Java Test Runner
local java_test_path = mason_path .. "/packages/java-test/extension/server/*.jar"
local test_jars = vim.fn.glob(java_test_path, 1, 1)
if test_jars and #test_jars > 0 then
  vim.list_extend(bundles, test_jars)
end

-- JDTLS configuration
local config = {
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-javaagent:" .. lombok_path,
    "-Xmx4g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    "-jar",
    launcher_jar,
    "-configuration",
    jdtls_path .. "/config_" .. system_os,
    "-data",
    workspace_dir,
  },

  root_dir = get_root_dir(),

  settings = {
    java = {
      home = "/opt/homebrew/Cellar/openjdk@21",
      eclipse = {
        downloadSources = true,
      },
      configuration = {
        updateBuildConfiguration = "interactive",
        runtimes = {
          {
            name = "JavaSE-11",
            path = "/opt/homebrew/Cellar/openjdk@11",
          },
          {
            name = "JavaSE-17",
            path = "/opt/homebrew/Cellar/openjdk@17",
          },
          {
            name = "JavaSE-21",
            path = "/opt/homebrew/Cellar/openjdk@21",
          },
        },
      },
      maven = {
        downloadSources = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      signatureHelp = { enabled = true },
      format = { enabled = true },
      completion = {
        favoriteStaticMembers = {
          "org.hamcrest.MatcherAssert.assertThat",
          "org.hamcrest.Matchers.*",
          "org.hamcrest.CoreMatchers.*",
          "org.junit.jupiter.api.Assertions.*",
          "java.util.Objects.requireNonNull",
          "java.util.Objects.requireNonNullElse",
          "org.mockito.Mockito.*",
        },
        importOrder = {
          "java",
          "javax",
          "com",
          "org",
        },
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
      codeGeneration = {
        toString = {
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
        },
        useBlocks = true,
      },
      inlayHints = {
        parameterNames = {
          enabled = "all",
          exclusions = { "this" },
        },
      },
    },
  },

  flags = {
    allow_incremental_sync = true,
  },

  init_options = {
    bundles = bundles,
    extendedClientCapabilities = jdtls.extendedClientCapabilities,
  },

  on_attach = function(client, bufnr)
    jdtls.setup_dap({ hotcodereplace = "auto" })
    require("jdtls.dap").setup_dap_main_class_configs()

    -- Keymaps for testing
    local map = vim.keymap.set
    map("n", "<leader>tc", function()
      require("jdtls").test_class()
    end, { buffer = bufnr, desc = "Java Test Class (JDTLS)" })

    map("n", "<leader>tm", function()
      require("jdtls").test_nearest_method()
    end, { buffer = bufnr, desc = "Java Test Nearest Method (JDTLS)" })
  end,
}

-- Start or attach to JDTLS
jdtls.start_or_attach(config)
