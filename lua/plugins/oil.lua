return {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
        view_options = {
            show_hidden = true,
        },
        keymaps = {
            ["<C-p>"] = false,
            ["<C-c>"] = false,
            ["<Esc><Esc>"] = { "actions.close", mode = "n" },
        },
        win_options = {
            winbar = "%!v:lua.require('oil').get_current_dir()",
        },
    },
    keys = {
        {
            "<C-b>",
            function()
                require("oil").open()
            end,
            desc = "Open parent directory of current file",
        },
        {
            "<C-S-b>",
            function()
                require("oil").open()
            end,
            desc = "Open parent directory",
        },
        {
            "<C-S-n>",
            function()
                require("oil").open(vim.env.HOME .. "/Notes")
            end,
            desc = "Open notes directory",
        },
    },
    init = function()
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1
    end,
}
