return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "folke/lazydev.nvim",
  },

  config = function()
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local map = vim.keymap.set

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }

        local has_snacks = Snacks ~= nil
        local has_fzf = pcall(require, "fzf-lua")

        if not has_snacks and not has_fzf then
          opts.desc = " Go to definition"
          map("n", "gd", vim.lsp.buf.definition, opts)

          opts.desc = " Go to declaration"
          map("n", "gD", vim.lsp.buf.declaration, opts)

          opts.desc = " Show LSP references"
          map("n", "gr", vim.lsp.buf.references, opts)

          opts.desc = " Go to implementation"
          map("n", "gi", vim.lsp.buf.implementation, opts)

          opts.desc = " Go to type definition"
          map("n", "gt", vim.lsp.buf.type_definition, opts)

          opts.desc = " Document symbols"
          map("n", "<leader>ds", vim.lsp.buf.document_symbol, opts)
        end

        opts.desc = " See available code actions"
        map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

        opts.desc = "󰑕 LSP rename"
        map("n", "<leader>rn", vim.lsp.buf.rename, opts)

        opts.desc = " Show line diagnostics"
        map("n", "<leader>dl", vim.diagnostic.open_float, opts)

        opts.desc = "󰈙 Show documentation under cursor"
        map("n", "gh", vim.lsp.buf.hover, opts)

        opts.desc = "󰜉 Restart LSP"
        map("n", "<leader>rs", ":LspRestart<CR>", opts)

        opts.desc = " Signature help"
        map("n", "K", vim.lsp.buf.signature_help, opts)
        map("i", "<C-k>", vim.lsp.buf.signature_help, opts)
      end,
    })

    -- Setup capabilities and diagnostic signs
    local capabilities = cmp_nvim_lsp.default_capabilities()
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    -- LSP-specific configurations
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

    -- Lua Language Server
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

    -- TypeScript Language Server
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
}
