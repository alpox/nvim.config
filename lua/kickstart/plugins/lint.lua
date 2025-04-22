return {

  { -- Linting
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'
      lint.linters_by_ft = {
        markdown = { 'markdownlint' },
        json = { 'jsonlint' },
        clojure = { 'clj-kondo' },
        javascript = { 'eslint' },
        typescript = { 'eslint' },
        php = { 'phpstan' },
        json = { 'jsonlint' },
        yaml = { 'yamllint' },
      }

      -- PHPStan configuration
      lint.linters.phpstan = {
        cmd = 'phpstan',
        args = {
          'analyze',
          '--error-format=raw',
          '--no-progress',
          '--level=5', -- Adjust level as needed (0-9)
        },
        stdin = false,
        append_fname = true,
        -- Custom parser for PHPStan output
        parser = function(output, _)
          local diagnostics = {}
          for line in output:gmatch '[^\r\n]+' do
            local file, line_number, message = line:match '^(.+):(%d+):(.+)'
            if file and line_number and message then
              table.insert(diagnostics, {
                lnum = tonumber(line_number) - 1,
                col = 0,
                end_lnum = tonumber(line_number) - 1,
                end_col = 0,
                severity = vim.diagnostic.severity.ERROR,
                message = message:gsub('^%s*', ''),
                source = 'phpstan',
              })
            end
          end
          return diagnostics
        end,
      }

      -- Create .phpstan.neon if needed
      vim.api.nvim_create_user_command('PhpstanInit', function()
        local file = io.open('.phpstan.neon', 'w')
        if file then
          file:write 'parameters:\n  level: 5\n  paths:\n    - src\n'
          file:close()
          print 'Created .phpstan.neon configuration file'
        else
          print 'Failed to create .phpstan.neon file'
        end
      end, {})

      -- To allow other plugins to add linters to require('lint').linters_by_ft,
      -- instead set linters_by_ft like this:
      -- lint.linters_by_ft = lint.linters_by_ft or {}
      -- lint.linters_by_ft['markdown'] = { 'markdownlint' }
      --
      -- However, note that this will enable a set of default linters,
      -- which will cause errors unless these tools are available:
      -- {
      --   clojure = { "clj-kondo" },
      --   dockerfile = { "hadolint" },
      --   inko = { "inko" },
      --   janet = { "janet" },
      --   json = { "jsonlint" },
      --   markdown = { "vale" },
      --   rst = { "vale" },
      --   ruby = { "ruby" },
      --   terraform = { "tflint" },
      --   text = { "vale" }
      -- }
      --
      -- You can disable the default linters by setting their filetypes to nil:
      -- lint.linters_by_ft['clojure'] = nil
      -- lint.linters_by_ft['dockerfile'] = nil
      -- lint.linters_by_ft['inko'] = nil
      -- lint.linters_by_ft['janet'] = nil
      -- lint.linters_by_ft['json'] = nil
      -- lint.linters_by_ft['markdown'] = nil
      -- lint.linters_by_ft['rst'] = nil
      -- lint.linters_by_ft['ruby'] = nil
      -- lint.linters_by_ft['terraform'] = nil
      -- lint.linters_by_ft['text'] = nil

      -- Create autocommand which carries out the actual linting
      -- on the specified events.
      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          -- Only run the linter in buffers that you can modify in order to
          -- avoid superfluous noise, notably within the handy LSP pop-ups that
          -- describe the hovered symbol using Markdown.
          if vim.opt_local.modifiable:get() then
            lint.try_lint()
          end
        end,
      })
    end,
  },
}
