local cmp = require 'cmp'
local autopairs = require 'nvim-autopairs.completion.cmp'
local lspkind = require 'lspkind'

cmp.event:on('confirm_done', autopairs.on_confirm_done())

cmp.setup {
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  snippet = {
    expand = function(args)
      vim.snippet.expand(args.body)
    end,
  },
  sources = cmp.config.sources {
    { name = 'nvim_lsp' },
    { name = 'copilot' },
    { name = 'path' },
  },
  formatting = {
    format = lspkind.cmp_format {
      preset = 'codicons',
      mode = 'symbol',
      symbol_map = {
        Copilot = '🤖',
      },
    },
  },
  mapping = cmp.mapping.preset.insert {
    ['<CR>'] = cmp.mapping.confirm { select = false },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
}
