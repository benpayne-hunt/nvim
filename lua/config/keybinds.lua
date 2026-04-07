-- Leader
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

-- LSP
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gf", vim.lsp.buf.code_action)
vim.keymap.set("n", "gi", vim.lsp.buf.hover)
vim.keymap.set("n", "gr", vim.lsp.buf.rename)
vim.keymap.set("n", "gu", vim.lsp.buf.references)

-- Diagnostics
vim.keymap.set("n", "ge", vim.diagnostic.open_float)

-- Comments
vim.keymap.set("n", "<leader>c", "gcc", { remap = true })
vim.keymap.set("v", "<leader>c", "gc", { remap = true })

-- Up and down
vim.keymap.set({ "n", "v" }, "j", "gj")
vim.keymap.set({ "n", "v" }, "k", "gk")

-- Copy/Paste
vim.keymap.set({ "n", "v" }, "<leader>y", "\"+y")
vim.keymap.set({ "n", "v" }, "<leader>yy", "\"+yy")
vim.keymap.set({ "n", "v" }, "<leader>p", "\"+p")
vim.keymap.set({ "n", "v" }, "<leader>P", "\"+P")
vim.keymap.set("n", "<leader>yf", function()
    local path = vim.fn.expand("%:~:.")
    vim.fn.setreg("+", path)
    vim.notify(path)
end, { desc = "Copy relative file path" })

-- Move down popup list with tab
vim.keymap.set("i", "<Tab>", function()
    if vim.fn.pumvisible() == 1 then
        vim.api.nvim_feedkeys(vim.keycode("<C-n>"), "i", false)
    else
        return "<Tab>"
    end
end, { noremap = true, expr = true })

-- Move up popup list with shift+tab
vim.keymap.set("i", "<S-Tab>", function()
    if vim.fn.pumvisible() == 1 then
        vim.api.nvim_feedkeys(vim.keycode("<C-p>"), "i", false)
    else
        return "<S-Tab>"
    end
end, { noremap = true, expr = true })

-- Make down behaviour work like C-n
vim.keymap.set("i", "<Down>", function()
    if vim.fn.pumvisible() == 1 then
        vim.api.nvim_feedkeys(vim.keycode("<C-n>"), "i", false)
    else
        return "<Down>"
    end
end, { noremap = true, expr = true })

-- Make up behaviour work like C-p
vim.keymap.set("i", "<Up>", function()
    if vim.fn.pumvisible() == 1 then
        vim.api.nvim_feedkeys(vim.keycode("<C-p>"), "i", false)
    else
        return "<Up>"
    end
end, { noremap = true, expr = true })

-- Use enter to accept completion in popup list
vim.keymap.set("i", "<CR>", function()
    if vim.fn.pumvisible() == 1 then
        vim.api.nvim_feedkeys(vim.keycode("<C-y>"), "i", false)
    else
        return "<CR>"
    end
end, { noremap = true, expr = true })
