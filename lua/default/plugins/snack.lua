return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      explorer = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      picker = { enabled = false },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      git = { enabled = true },
      gitbrowse = { enabled = true },
      lazygit = { enabled = true },
      terminal = { win = { height = 0.3 } },
    },
    keys = {
      {
        '<leader>to',
        function()
          Snacks.terminal()
        end,
        desc = '[T]erminal [O]pen',
      },
      {
        '<leader>gb',
        function()
          Snacks.picker.git_branches()
        end,
        desc = 'Git Branches',
      },
      {
        '<leader>gl',
        function()
          Snacks.picker.git_log()
        end,
        desc = 'Git Log',
      },
      {
        '<leader>gL',
        function()
          Snacks.picker.git_log_line()
        end,
        desc = 'Git Log Line',
      },
      {
        '<leader>gs',
        function()
          Snacks.picker.git_status()
        end,
        desc = 'Git Status',
      },
      {
        '<leader>gS',
        function()
          Snacks.picker.git_stash()
        end,
        desc = 'Git Stash',
      },
      {
        '<leader>gd',
        function()
          Snacks.picker.git_diff()
        end,
        desc = 'Git Diff (Hunks)',
      },
      {
        '<leader>gf',
        function()
          Snacks.picker.git_log_file()
        end,
        desc = 'Git Log File',
      },
      -- LSP
      {
        'gd',
        function()
          Snacks.picker.lsp_definitions()
        end,
        desc = 'Goto Definition',
      },
      {
        'gD',
        function()
          Snacks.picker.lsp_declarations()
        end,
        desc = 'Goto Declaration',
      },
      {
        'gr',
        function()
          Snacks.picker.lsp_references()
        end,
        nowait = true,
        desc = 'References',
      },
      {
        'gI',
        function()
          Snacks.picker.lsp_implementations()
        end,
        desc = 'Goto Implementation',
      },
      {
        'gy',
        function()
          Snacks.picker.lsp_type_definitions()
        end,
        desc = 'Goto T[y]pe Definition',
      },
      {
        '<leader>ss',
        function()
          Snacks.picker.lsp_symbols()
        end,
        desc = 'LSP Symbols',
      },
      {
        '<leader>gb',
        function()
          Snacks.git.blame_line()
        end,
        desc = 'Git Blame Line',
      },
      {
        '<leader>sS',
        function()
          Snacks.picker.lsp_workspace_symbols()
        end,
        desc = 'LSP Workspace Symbols',
      },
    },
  },
}
