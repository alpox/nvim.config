return {
  'nvim-neorg/neorg',
  lazy = false,
  version = '*',
  dependencies = {
    "nvim-neorg/neorg-telescope"
  },
  config = function()
    require('neorg').setup {
      load = {
        ['core.defaults'] = {},
        ['core.concealer'] = {},
        ['core.integrations.telescope'] = {},
        ['core.dirman'] = {
          config = {
            workspaces = {
              notes = '~/notes',
            },
            default_workspace = 'notes',
          },
        },
      },
    }

    vim.wo.foldlevel = 99
    vim.wo.conceallevel = 2

    vim.keymap.set("n", "<leader>soh", "<Plug>(neorg.telescope.search_headings)")
    vim.keymap.set("n", "<leader>sof", "<Plug>(neorg.telescope.find_norg_files)")
    vim.keymap.set("n", "<leader>sow", "<Plug>(neorg.telescope.switch_workspace)")
  end,
}
