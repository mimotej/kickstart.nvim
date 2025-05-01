return {
  'olimorris/codecompanion.nvim',
  lazy = false,
  opts = {
    strategies = {
      chat = { adapter = 'copilot' },
      inline = { adapter = 'copilot' },
    },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
}
