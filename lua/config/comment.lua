require("Comment").setup({
	-- Add a space b/w comment and the line
	padding = true,

	-- Whether the cursor should stay at its position
	sticky = true,

	-- Ignore empty lines
	ignore = "^$",

	-- Keymaps for normal mode
	toggler = {
		line = "<leader>c<leader>",
		block = "<leader>b<leader>",
	},

	-- Keymaps for visual mode
	opleader = {
		line = "<leader>c<leader>",
	},

	-- Function to call before comment toggle
	pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
})
