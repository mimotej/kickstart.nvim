return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'zbirenbaum/copilot.lua' }, -- or zbirenbaum/copilot.lua
      { 'nvim-lua/plenary.nvim', branch = 'master' }, -- for curl, log and async functions
    },
    build = 'make tiktoken', -- Only on MacOS or Linux
    opts = {
      window = {
        width = 0.3,
      },
      question_header = '## User ',
      answer_header = '## Copilot ',
      error_header = '## Error ',
      -- See Configuration section for options
    },

    -- Adjust chat display settings
    config = function()
      require('CopilotChat').setup {
        highlight_headers = false,
        separator = '---',
        error_header = '> [!ERROR] Error',
      }
    end,
    -- See Commands section for default commands if you want to lazy load on them
  },
}
