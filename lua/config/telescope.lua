local telescope = require("telescope")
local telescope_functions = require("telescope.builtin")

telescope.setup({
	defaults = {
		file_ignore_patterns = { ".git/" },
	},
	pickers = {
		find_files = {
			hidden = true,
		},
		colorscheme = {
			enable_preview = true,
		},
	},
})

vim.keymap.set("n", "<C-p>", telescope_functions.find_files)
vim.keymap.set("n", "<C-f>", telescope_functions.live_grep)

vim.keymap.set("n", "<leader><C-p>", function()
	telescope_functions.find_files({
		hidden = true,
		no_ignore = true,
		follow = true,
	})
end)

vim.keymap.set("n", "<leader><C-f>", function()
	telescope_functions.live_grep({
		additional_args = function()
			return { "--hidden", "--no-ignore", "--follow" }
		end,
	})
end)
