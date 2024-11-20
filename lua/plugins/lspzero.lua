return {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v3.x',
  dependencies = {
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'neovim/nvim-lspconfig' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/nvim-cmp' },
    { 'L3MON4D3/LuaSnip' },
  },
  config = function()
    local lspconfig = require 'lspconfig'

    lspconfig.gleam.setup {}

    local configs = {
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' },
            },
            workspace = {
              checkThirdParty = false,
              telemetry = { enable = false },
              library = {
                vim.env.VIMRUNTIME,
                '${3rd}/love2d/library',
              },
            },
          },
        },
      },
    }

    require('mason').setup {}
    require('mason-lspconfig').setup {
      ensure_installed = { 'rust_analyzer', 'clangd', 'lua_ls' },
      handlers = {
        function(server_name)
          lspconfig[server_name].setup(configs[server_name] or {})
        end,
      },
    }

    local cmp = require 'cmp'

    cmp.setup {
      sources = {
        { name = 'nvim_lsp' },
      },
      mapping = {
        ['<C-y>'] = cmp.mapping.confirm { select = false },
        ['<C-e>'] = cmp.mapping.abort(),
        ['<C-p>'] = cmp.mapping.select_prev_item { behavior = 'select' },
        ['<C-n>'] = cmp.mapping.select_next_item { behavior = 'select' },
      },
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end,
      },
    }
  end,
}
