require("nvim-tree").setup({
	disable_netrw = true,
	update_focused_file = {
		enable = true,
	},
	view = {
		adaptive_size = true,
	},
	filters = {
		dotfiles = false,
		git_ignored = false,
	},
})

vim.keymap.set("n", "<C-b>", ":NvimTreeToggle<CR>", { silent = true })
