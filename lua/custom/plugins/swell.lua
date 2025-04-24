return {
  'itsfrank/swell.nvim',
  config = function()
    vim.keymap.set('n', '<leader>z', '<Plug>(swell-toggle)')
  end,
}
