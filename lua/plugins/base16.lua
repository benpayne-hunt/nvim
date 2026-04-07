return {
    "RRethy/base16-nvim",
    lazy = true,
    config = function()
        require("base16-colorscheme").with_config({
            telescope = false,
            indentblankline = false,
            notify = false,
            ts_rainbow = false,
            cmp = false,
            illuminate = false,
            dapui = false,
        })
    end,
}
