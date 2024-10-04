return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "bash",
                "c",
                "cpp",
                "css",
                "dockerfile",
                "fish",
                "html",
                "javascript",
                "json",
                "lua",
                "make",
                "markdown",
                "markdown_inline",
                "python",
                "rst",
                "toml",
                "vim",
                "yaml",
            },
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = { "markdown" },
            },
            sync_install = false,
            auto_install = true,
        })
    end,
}
