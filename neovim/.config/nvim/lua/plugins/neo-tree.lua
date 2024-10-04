return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
        "3rd/image.nvim",
    },
    config = function()
        require("neo-tree").setup({
            default_component_configs = {
                symlink_target = { enabled = false },
            },
            window = {
                position = "current",
            },
        })

        vim.keymap.set('n', '<leader>ft', ":Neotree position=current<CR>", {})
    end,
}

