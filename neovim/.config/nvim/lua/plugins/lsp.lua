return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "jose-elias-alvarez/null-ls.nvim",
    },
    config = function()
        require("mason").setup({
            ensure_installed = {
                "black",
                "debugpy",
                "flake8",
                "isort",
                "mypy",
            },
        })

        require("mason-lspconfig").setup({
            ensure_installed = {
                "clangd",
                "harper_ls",
                "ltex",
                "lua_ls",
                "pyright",
                "yamlls",
            },
        })

        -- LSP Configuration
        local lsp = require("lspconfig")

        lsp.clangd.setup({})
        lsp.harper_ls.setup({})
        lsp.ltex.setup({})
        lsp.lua_ls.setup({})
        lsp.pyright.setup({
            settings = {
                python = {
                    analysis = {
                        typeCheckingMode = "off",
                    },
                },
            },
        })
        lsp.yamlls.setup({})

        -- Null LS configuration
        local null_ls = require("null-ls")

        null_ls.setup({
            source = {
                null_ls.builtins.diagnostics.flake8,
                null_ls.builtins.diagnostics.mypy,
                null_ls.builtins.formatting.black,
                null_ls.builtins.formatting.isort,
                null_ls.builtins.formatting.ocdc, -- Install via pip
            },
        })
    end,
}

