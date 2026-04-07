return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "FileType",
    dependencies = { "hiphish/rainbow-delimiters.nvim" },
    config = function()
        local highlight = {
            "RainbowDelimiterRed",
            "RainbowDelimiterYellow",
            "RainbowDelimiterBlue",
            "RainbowDelimiterOrange",
            "RainbowDelimiterGreen",
            "RainbowDelimiterViolet",
            "RainbowDelimiterCyan",
        }

        local hooks = require("ibl.hooks")
        hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)

        vim.g.rainbow_delimiters = { highlight = highlight }

        require("ibl").setup({
            indent = { char = "│" },
            scope = { highlight = highlight },
        })
    end,
}
