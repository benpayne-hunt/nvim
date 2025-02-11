local lspconfig = require("lspconfig")
local mason_lspconfig = require("mason-lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local mason_registry = require("mason-registry")

vim.diagnostic.config({
	virtual_text = false,
})

mason_lspconfig.setup({
	ensure_installed = {
		"astro",
		"cssls",
		"emmet_language_server",
		"html",
		"jsonls",
		"lua_ls",
		"phpactor",
		"svelte",
		"tailwindcss",
		"volar",
		"vtsls",
		"eslint",
	},
})

mason_lspconfig.setup_handlers({
	function(server_name)
		-- Add additional emmet file types
		lspconfig.emmet_language_server.setup({
			filetypes = { "php", "astro", "vue" },
		})

		-- Additional Vue setup
		lspconfig.vtsls.setup({
			filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
			settings = {
				vtsls = {
					tsserver = {
						globalPlugins = {
							{
								name = "@vue/typescript-plugin",
								location = mason_registry.get_package("vue-language-server"):get_install_path()
									.. "/node_modules/@vue/language-server",
								languages = { "vue" },
								configNamespace = "typescript",
								enableForWorkspaceTypeScriptVersions = true,
							},
						},
					},
				},
				typescript = {
					preferences = {
						importModuleSpecifier = "non-relative",
					},
				},
			},
		})

		-- General LSP setup
		lspconfig[server_name].setup({
			root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git"),

			capabilities = cmp_nvim_lsp.default_capabilities(),

			on_attach = function()
				-- Keymaps
				vim.keymap.set("n", "gd", vim.lsp.buf.definition)
				vim.keymap.set("n", "gr", vim.lsp.buf.rename)
				vim.keymap.set("n", "ge", vim.diagnostic.open_float)
				vim.keymap.set("n", "gf", vim.lsp.buf.code_action)
			end,
		})
	end,
})
