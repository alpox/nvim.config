return {
  'stevearc/overseer.nvim',
  opts = {},
  config = function()
    require('overseer').setup {
      strategy = {
        'toggleterm',
        open_on_start = false,
      },
      task_list = {
        max_height = 40,
      },
    }

    local overseer = require 'overseer'

    vim.keymap.set('n', '<leader>oo', overseer.open, { desc = 'Overseer: Open task list' })
    vim.keymap.set('n', '<leader>oc', overseer.close, { desc = 'Overseer: Close task list' })
    vim.keymap.set('n', '<leader>ot', overseer.toggle, { desc = 'Overseer: Toggle task list' })
    vim.keymap.set('n', '<leader>or', overseer.run_template, { desc = 'Overseer: Run action' })
  end,
}
