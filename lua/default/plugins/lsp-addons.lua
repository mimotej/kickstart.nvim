return {
  {
    'dnlhc/glance.nvim',
    cmd = 'Glance',
  },
  {
    'kosayoda/nvim-lightbulb',
    config = function()
      require('nvim-lightbulb').setup {
        sign = { enabled = true, priority = 10 },
        float = { enabled = false },
        virtual_text = { enabled = false },
        status_text = { enabled = true, text = '💡' },
        autocmd = { enabled = true },
      }
    end,
  },
  { 'folke/lsp-colors.nvim', lazy = true },
  { 'folke/trouble.nvim', lazy = true },
}
