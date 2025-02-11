local conform = require("conform")

require("mason-tool-installer").setup({
	ensure_installed = {
		"pint",
		"prettierd",
		"stylua",
		"eslint_d",
	},
	run_on_start = true,
})

conform.setup({
	formatters_by_ft = {
		["*"] = { "squeeze_blanks", "trim_whitespace", "trim_newlines" },

		lua = { "stylua" },
		php = { "pint" },

		json = { "prettierd" },
		jsonc = { "prettierd" },
		css = { "prettierd" },
		scss = { "prettierd" },
		html = { "prettierd" },
		xml = { "prettierd" },
		svg = { "prettierd" },

		javascript = { "eslint_d", "prettierd" },
		typescript = { "eslint_d", "prettierd" },
		javascriptreact = { "eslint_d", "prettierd" },
		typescriptreact = { "eslint_d", "prettierd" },
		astro = { "eslint_d", "prettierd" },
		svelte = { "eslint_d", "prettierd" },
		vue = { "eslint_d", "prettierd" },

		-- php = function(bufnr)
		-- 	-- Run LSP formatter first
		-- 	vim.lsp.buf.format({ bufnr = bufnr })
		-- 	return { "pint" }
		-- end,
	},
	format_on_save = true,
	notify_on_error = true,
})
-- Create "Format" command
vim.api.nvim_create_user_command("Format", function(args)
	local range = nil

	if args.count ~= -1 then
		local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
		range = {
			start = { args.line1, 0 },
			["end"] = { args.line2, end_line:len() },
		}
	end

	conform.format({ async = true, lsp_format = "fallback", range = range })
end, { range = true })
