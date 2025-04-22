return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'olimorris/neotest-phpunit',
    'nvim-neotest/neotest-jest',
    'marilari88/neotest-vitest',
  },
  config = function()
    require('neotest').setup {
      adapters = {
        require 'neotest-phpunit',

        require 'neotest-vitest',

        require 'neotest-jest' {
          jestConfigFile = 'jest.config.js',
        },
      },
    }

    local neotest = require 'neotest'

    -- Keymaps for Neotest
    vim.keymap.set('n', '<Leader>ttc', function()
      neotest.run.run()
    end, { desc = 'Run closest test' })

    vim.keymap.set('n', '<Leader>tt', function()
      local term = Terminal:new { direction = 'tab' }
      term:toggle()
    end, { desc = 'Toggle tab terminal' })

    vim.keymap.set('n', '<Leader>ttd', function()
      neotest.run.run { strategy = 'dap' }
    end, { desc = 'Debug closest test' })

    vim.keymap.set('n', '<Leader>ttf', function()
      neotest.run.run(vim.fn.expand '%')
    end, { desc = 'Run tests in file' })

    vim.keymap.set('n', '<Leader>tta', function()
      neotest.run.run(vim.fn.getcwd())
    end, { desc = 'Run all tests' })

    vim.keymap.set('n', '<Leader>tts', function()
      neotest.summary.toggle()
    end, { desc = 'Open Neotest summary' })

    vim.keymap.set('n', '<Leader>ttS', function()
      neotest.run.stop()
    end, { desc = 'Open Neotest summary' })

    vim.keymap.set('n', '<Leader>tto', function()
      neotest.output_panel.toggle()
    end, { desc = 'Open Neotest output' })
  end,
}
