return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    local lspconfig = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local map = vim.keymap.set

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }

        opts.desc = "Show LSP references"
        map("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

        opts.desc = "Go to declaration"
        map("n", "gD", vim.lsp.buf.declaration, opts)

        opts.desc = "Show LSP definitions"
        map("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

        opts.desc = "Show LSP implementations"
        map("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

        opts.desc = "Show LSP type definitions"
        map("n", "tg", "<cmd>Telescope lsp_type_definitions<CR>", opts)

        opts.desc = "See available code actions"
        map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

        opts.desc = "Smart rename"
        map("n", "<leader>rn", vim.lsp.buf.rename, opts)

        opts.desc = "Show line diagnostics"
        map("n", "<leader>dl", vim.diagnostic.open_float, opts)

        opts.desc = "Show documentation for what is under cursor"
        map("n", "<leader>gh", vim.lsp.buf.hover, opts)

        opts.desc = "Restart LSP"
        map("n", "<leader>rs", ":LspRestart<CR>", opts)

        opts = { desc = "Signature help" }
        map({ "n", "i" }, "K", vim.lsp.buf.signature_help, opts)

        opts.desc = "Show document symbols"
        map("n", "<leader>ds", function()
          require("telescope.builtin").lsp_document_symbols({
            symbols = {
              "class",
              "function",
              "method",
              "constructor",
              "interface",
              "module",
              "namespace",
              "package",
              "struct",
              "enum",
            },
          })
        end, opts)
      end,
    })

    local capabilities = cmp_nvim_lsp.default_capabilities()
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    mason_lspconfig.setup_handlers({
      -- default handler for installed servers
      function(server_name)
        lspconfig[server_name].setup({
          capabilities = capabilities,
        })
      end,

      ["emmet_language_server"] = function()
        lspconfig["emmet_language_server"].setup({
          capabilities = capabilities,
          filetypes = {
            "css",
            "html",
            "javascript",
            "javascriptreact",
            "less",
            "sass",
            "scss",
            "svelte",
            "typescriptreact",
            "vue",
          },
          settings = {
            emmet = {
              showExpandedAbbreviation = "always",
              showAbbreviationSuggestions = true,
              showSuggestionsAsSnippets = false,
              preferences = {
                ["bem.enabled"] = true,
              },
            },
          },
        })
      end,

      ["lua_ls"] = function()
        lspconfig["lua_ls"].setup({
          capabilities = capabilities,
          settings = {
            Lua = {
              -- make the language server recognize "vim" global
              diagnostics = {
                globals = { "vim" },
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        })
      end,
      ["ts_ls"] = function()
        lspconfig["ts_ls"].setup({
          capabilities = capabilities,
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
            completions = {
              completeFunctionCalls = true,
            },
          },
          commands = {
            OrganizeImports = {
              function()
                vim.lsp.buf.code_action({
                  apply = true,
                  context = {
                    only = { "source.organizeImports.ts" },
                  },
                })
              end,
              description = "Organize Imports",
            },
          },
          on_attach = function(client, bufnr)
            -- Enable auto-imports on save
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.code_action({
                  apply = true,
                  context = {
                    only = { "source.addMissingImports.ts" },
                  },
                })
              end,
            })
          end,
        })
      end,
    })
  end,
}
