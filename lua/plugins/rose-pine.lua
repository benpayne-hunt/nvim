return {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000,
    lazy = false,
    opts = {
        variant = "moon",
        dim_inactive_windows = false,
        extend_background_behind_borders = true,
        styles = {
            bold = true,
            italic = false,
            transparency = false,
        },
    },
    config = function(_, opts)
        require("rose-pine").setup(opts)
        vim.cmd.colorscheme("rose-pine-moon")
    end,
}
