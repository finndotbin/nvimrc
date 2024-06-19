return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    "3rd/image.nvim",
  },
  keys = {
    { '\\', ':Neotree reveal<CR>', { desc = 'NeoTree reveal' } },
  },
  opts = {
    window = {
      width = 30,
    },
    filesystem = {
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = true,
    },
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
    },
  },
}
