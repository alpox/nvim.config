-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    { 'igorlfs/nvim-dap-view', opts = {} },

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go',
  },
  keys = {
    -- Basic debugging keymaps, feel free to change to your liking!
    {
      '<F5>',
      function()
        require('dap').continue()
      end,
      desc = 'Debug: Start/Continue',
    },
    {
      '<F1>',
      function()
        require('dap').step_into()
      end,
      desc = 'Debug: Step Into',
    },
    {
      '<F2>',
      function()
        require('dap').step_over()
      end,
      desc = 'Debug: Step Over',
    },
    {
      '<F3>',
      function()
        require('dap').step_out()
      end,
      desc = 'Debug: Step Out',
    },
    {
      '<leader>b',
      function()
        require('dap').toggle_breakpoint()
      end,
      desc = 'Debug: Toggle Breakpoint',
    },
    {
      '<leader>B',
      function()
        require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end,
      desc = 'Debug: Set Breakpoint',
    },
    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    {
      '<F7>',
      function()
        require('dap-view').toggle()
      end,
      desc = 'Debug: See last session result.',
    },
  },
  config = function()
    local dap = require 'dap'
    local dapview = require 'dap-view'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'delve',
      },
    }

    dap.adapters['pwa-node'] = {
      type = 'server',
      host = 'localhost',
      port = '${port}',
      executable = {
        command = 'node',
        -- TODO update with your correct path (when you install it in the next step)
        args = { '/opt/js-debug/src/dapDebugServer.js', '${port}' },
      },
    }

    -- Configure PHP/Xdebug
    dap.adapters.php = {
      type = 'executable',
      command = 'node',
      args = { vim.fn.stdpath 'data' .. '/mason/packages/php-debug-adapter/extension/out/phpDebug.js' },
    }

    dap.configurations.php = {
      {
        log = true,
        type = 'php',
        request = 'launch',
        name = 'Listen for Xdebug',
        port = 9003,
        stopOnEntry = false,
      },
    }

    -- Change breakpoint icons
    -- vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
    -- vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
    -- local breakpoint_icons = vim.g.have_nerd_font
    --     and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
    --   or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }
    -- for type, icon in pairs(breakpoint_icons) do
    --   local tp = 'Dap' .. type
    --   local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
    --   vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
    -- end

    local dv = require 'dap-view'
    dap.listeners.before.attach['dap-view-config'] = function()
      dv.open()
    end
    dap.listeners.before.launch['dap-view-config'] = function()
      dv.open()
    end
    dap.listeners.before.event_terminated['dap-view-config'] = function()
      dv.close()
    end
    dap.listeners.before.event_exited['dap-view-config'] = function()
      dv.close()
    end

    -- Install golang specific config
    require('dap-go').setup {
      delve = {
        -- On Windows delve must be run attached or it crashes.
        -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
        detached = vim.fn.has 'win32' == 0,
      },
    }

    -- Keymaps for debugging
    vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>dc', dap.continue, { desc = 'Continue' })
    vim.keymap.set('n', '<leader>ds', dap.step_over, { desc = 'Step Over' })
    vim.keymap.set('n', '<leader>di', dap.step_into, { desc = 'Step Into' })
    vim.keymap.set('n', '<leader>do', dap.step_out, { desc = 'Step Out' })
    vim.keymap.set('n', '<leader>dx', dap.terminate, { desc = 'Terminate' })
    vim.keymap.set('n', '<leader>du', dapview.toggle, { desc = 'Toggle UI' })
  end,
}
