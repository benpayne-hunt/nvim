require("nvim-treesitter.configs").setup({
	ensure_installed = { "html", "javascript", "css", "typescript", "php" },
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = { "html", "astro" },
	},
})

vim.g.skip_ts_context_commentstring_module = true

vim.filetype.add({
	pattern = {
		[".*%.antlers%.html"] = "html",
	},
})
