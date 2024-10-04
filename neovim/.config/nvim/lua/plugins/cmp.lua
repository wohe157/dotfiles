return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "neovim/nvim-lspconfig",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
    },
    config = function()
        require("cmp").setup({
            snippet = {
                expand = function(args)
                    vim.snippet.expand(args.body)
                end,
            },
        })
    end,
}
