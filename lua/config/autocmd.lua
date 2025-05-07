-- Move help buffers from horizontal to vertical splits
vim.api.nvim_create_autocmd("BufWinEnter", {
    group = vim.api.nvim_create_augroup("help_vertical", {}),
    pattern = { "*.txt" },
    callback = function()
        if vim.bo.filetype == "help" then
            vim.cmd.wincmd("L")
        end
    end,
})

-- Automatically close terminals when process exits
vim.api.nvim_create_autocmd("TermClose", {
    pattern = "*",
    callback = function(event)
        vim.schedule(function()
            pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
        end)
    end,
})

-- When a new tab is opened, close the tab and open that buffer in the current tab
vim.api.nvim_create_autocmd("TabNew", {
    callback = function()
        local bufnr = vim.api.nvim_get_current_buf()
        vim.cmd("tabclose")
        vim.api.nvim_win_set_buf(0, bufnr)
    end,
})
