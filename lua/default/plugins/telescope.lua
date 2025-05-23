return {
  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'debugloop/telescope-undo.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        vimgrep_arguments = {
          'rg',
          '--follow', -- Follow symbolic links
          '--hidden', -- Search for hidden files
          '--no-heading', -- Don't group matches by each file
          '--with-filename', -- Print the file path with the matched lines
          '--line-number', -- Show line numbers
          '--column', -- Show column numbers
          '--smart-case', -- Smart case search
          '--no-require-git',
          '--no-ignore-vcs',
          '--ignore-file=/Users/michal.drla/.config/nvim/static/ripgrep/.ignore',
          '--ignore-file=/home/mimotej/.config/nvim/static/ripgrep/.ignore',
          -- Exclude some patterns from search
        },
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        -- defaults = {
        --   mappings = {
        --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        --   },
        -- },
        -- pickers = {}
        pickers = {
          live_grep = {
            additional_args = function(opts)
              return {
                '--hidden',
                '--no-require-git',
                '--no-ignore-vcs',
                '--ignore-file=/Users/micha.drla/.config/nvim/static/ripgrep/.ignore',
                '--ignore-file=/home/mimotej/.config/nvim/static/ripgrep/.ignore',
              }
            end,
          },
          find_files = {
            hidden = true,
            find_command = {
              'rg',
              '--files',
              '--hidden',
              '--no-require-git',
              '--no-ignore-vcs',
              '--ignore-file=/Users/michal.drla/.config/nvim/static/ripgrep/.ignore',
              '--ignore-file=/home/mimotej/.config/nvim/static/ripgrep/.ignore',
            },
          },
        },
        defaults = {
          path_display = { 'filename_first' },
          file_ignore_patterns = {
            --            'node_modules',
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
          fzf = {},
          undo = {
            side_by_side = true,
            layout_strategy = 'vertical',
            layout_config = {
              preview_height = 0.6,
            },
          },
          aerial = {
            -- Set the width of the first two columns (the second
            -- is relevant only when show_columns is set to 'both')
            col1_width = 4,
            col2_width = 30,
            -- How to format the symbols
            format_symbol = function(symbol_path, filetype)
              if filetype == 'json' or filetype == 'yaml' then
                return table.concat(symbol_path, '.')
              else
                return symbol_path[#symbol_path]
              end
            end,
            -- Available modes: symbols, lines, both
            show_columns = 'both',
          },
        },
      }
      require('telescope').load_extension 'fzf'
      require('telescope').load_extension 'undo'
      require('telescope').load_extension 'aerial'
      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>sa', ':Telescope aerial<CR>', { desc = '[S]earch [A]erial' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })
      -- Shortcut to projects folder
      vim.keymap.set('n', '<leader>sp', function()
        builtin.find_files { cwd = '~/projects/' }
      end, { desc = '[S]earch [P]roject files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })

      -- Shortcut for searching your project
      vim.keymap.set('n', '<leader>sc', function()
        builtin.find_files { cwd = vim.fn.systemlist('git rev-parse --show-toplevel')[1] }
      end, { desc = '[S]earch [C]urrent project' })
      vim.keymap.set('n', '<leader>su', ':Telescope undo<CR>', { desc = '[S]earch [U]ndo history' })
    end,
  },
}
