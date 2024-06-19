return {
  "VonHeikemen/lsp-zero.nvim",
  branch = "v3.x",
  dependencies = {
    {"williamboman/mason.nvim"},
    {"williamboman/mason-lspconfig.nvim"},
    {"neovim/nvim-lspconfig"},
    {"hrsh7th/cmp-nvim-lsp"},
    {"hrsh7th/nvim-cmp"},
    {"L3MON4D3/LuaSnip"},
  },
  config = function()
    local lsp_zero = require("lsp-zero")

    lsp_zero.on_attach(function(_, bufnr)
      -- see :help lsp-zero-keybindings
      -- to learn the available actions
      lsp_zero.default_keymaps({
        buffer = bufnr,
        preserve_mappings = false,
      })
    end)

    lsp_zero.format_on_save({
      format_opts = {
        async = false,
        timeout_ms = 10000,
      },
      servers = {
        ["rust_analyzer"] = {"rust"},
      },
    })

    local lspconfig = require("lspconfig")

    lspconfig.gleam.setup({})

    local configs = {
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      },
    }

    require("mason").setup({})
    require("mason-lspconfig").setup({
      ensure_installed = { "rust_analyzer", "clangd", "lua_ls" },
      handlers = {
        function(server_name)
          lspconfig[server_name].setup(configs[server_name] or {})
        end,
      },
    })

    local cmp = require("cmp")

    cmp.setup({
      sources = {
        {name = "nvim_lsp"},
      },
      mapping = {
        ["<C-y>"] = cmp.mapping.confirm({select = false}),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<C-p>"] = cmp.mapping.select_prev_item({behavior = "select"}),
        ["<C-n>"] = cmp.mapping.select_next_item({behavior = "select"}),
        ["<C-Space>"] = cmp.mapping(function() cmp.complete() end)
      },
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
    })
  end
}
