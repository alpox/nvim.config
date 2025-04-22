return {
  'LukasPietzschmann/telescope-tabs',
  dependencies = { 'nvim-telescope/telescope.nvim' },
  config = function()
    require('telescope').load_extension 'telescope-tabs'
    require('telescope-tabs').setup {
      -- Your custom config :^)
    }

    local Tabs = require 'telescope-tabs'

    vim.keymap.set('n', '<leader>st', Tabs.list_tabs, { desc = '[T]oggle [S]elect [T]ab' })
  end,
}
