return {
  'LostbBlizzard/lazysql.nvim',
  opts = {}, -- automatically calls `require("lazysql").setup()`
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
  config = function()
    vim.keymap.set('n', '<leader>ls', '<cmd>LazySql<CR>', { desc = 'Toggle LazySql', noremap = true, silent = true })
  end,
}
