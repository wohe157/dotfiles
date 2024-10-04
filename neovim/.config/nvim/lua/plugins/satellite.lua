return {
    "lewis6991/satellite.nvim",
    dependencies = {
        "lewis6991/gitsigns.nvim",
    },
    config = function()
        require("gitsigns").setup()
        require("satellite").setup()
    end,
}
