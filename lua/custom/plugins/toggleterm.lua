return {
  'akinsho/toggleterm.nvim',
  version = '*',
  opts = {},
  config = function()
    require('toggleterm').setup {
      size = function(term)
        if term.direction == 'horizontal' then
          return 20
        elseif term.direction == 'vertical' then
          return vim.o.columns * 0.4
        end
      end,
    }

    local Terminal = require('toggleterm.terminal').Terminal

    local floatTerminal = Terminal:new {
      direction = 'float',
    }

    vim.keymap.set('n', '<Leader>ts', function()
      local term = Terminal:new { direction = 'horizontal' }
      term:toggle()
    end, { desc = 'Toggle horizontal terminal' })

    vim.keymap.set('n', '<Leader>tv', function()
      local term = Terminal:new { direction = 'vertical' }
      term:toggle()
    end, { desc = 'Toggle vertical terminal' })

    vim.keymap.set('n', '<Leader>tf', function()
      floatTerminal:toggle()
    end, { desc = 'Toggle floating terminal' })

    function _G.set_terminal_keymaps()
      local opts = { buffer = 0 }
      vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
      vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
      vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
      vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
      vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
      vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
      vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
    end

    -- if you only want these mappings for toggle term use term://*toggleterm#* instead
    vim.cmd 'autocmd! TermOpen term://* lua set_terminal_keymaps()'

    local journalTerminal = Terminal:new {
      cmd = 'lazyjournal',
      direction = 'float',
    }

    vim.keymap.set('n', '<Leader>tj', function()
      journalTerminal:toggle()
      journalTerminal:focus()
    end, { desc = 'Toggle journal terminal' })
  end,
}
