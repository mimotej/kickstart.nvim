return {
  'pwntester/octo.nvim',
  requires = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
    -- OR 'ibhagwan/fzf-lua',
    -- OR 'folke/snacks.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('octo').setup {
      colors = { -- used for highlight groups (see Colors section below)
        white = '#ffffff',
        grey = '#2A354C',
        black = '#000000',
        red = '#fdb8c0',
        dark_red = '#da3633',
        green = '#acf2bd',
        dark_green = '#238636',
        yellow = '#d3c846',
        dark_yellow = '#735c0f',
        blue = '#58A6FF',
        dark_blue = '#0366d6',
        purple = '#6f42c1',
      },
    }
  end,
}
