return {
  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
          require('conform').formatters.prettier = {
            prepend_args = function()
              return { '--single-quote', '--no-bracket-spacing', '--config-precendence', 'prefer-file' }
            end,
          }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true, typescript = true, typescriptreact = true, yaml = true }
        local lsp_format_opt
        if disable_filetypes[vim.bo[bufnr].filetype] then
          --  lsp_format_opt = 'never'
          -- Configuration taken from https://github.com/nvim-lua/kickstart.nvim/pull/1395
          return nil
        else
          --  lsp_format_opt = 'fallback'
          return {
            timeout_ms = 500,
            lsp_format = 'fallback',
          }
        end
        --  return {
        --    timeout_ms = 500,
        --    lsp_format = lsp_format_opt,
        --  }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        go = { 'goimports', 'gofmt' },
        typescript = { 'prettier' },
        typescriptreact = { 'prettier' },
        javascript = { 'prettier' },
        javascriptreact = { 'prettier' },
        java = { 'checkstyle' },
        --       xml = { 'xmlformatter' },
        json = { 'jq' },
        yaml = { 'yamlfix' },
        python = { 'isort', 'black' },
        hcl = { 'packer_fmt' },
        terraform = { 'terraform_fmt' },
        tf = { 'terraform_fmt' },
        ['terraform-vars'] = { 'terraform_fmt' },
        -- Conform can also run multiple formatters sequentially
        --
        -- You can use 'stop_after_first' to run the first available formatter from the list
      },
    },
  },
}
