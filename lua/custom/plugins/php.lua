return {
  -- PHP Language Server (intelephense)
  {
    'neovim/nvim-lspconfig',
    opts = function(_, opts)
      -- Make sure the servers table exists
      if not opts.servers then
        opts.servers = {}
      end

      -- Add intelephense to the list of servers
      opts.servers.intelephense = {
        settings = {
          intelephense = {
            stubs = {
              'apache',
              'bcmath',
              'bz2',
              'calendar',
              'com_dotnet',
              'Core',
              'ctype',
              'curl',
              'date',
              'dba',
              'dom',
              'enchant',
              'exif',
              'FFI',
              'fileinfo',
              'filter',
              'fpm',
              'ftp',
              'gd',
              'gettext',
              'gmp',
              'hash',
              'iconv',
              'imap',
              'intl',
              'json',
              'ldap',
              'libxml',
              'mbstring',
              'meta',
              'mysqli',
              'oci8',
              'odbc',
              'openssl',
              'pcntl',
              'pcre',
              'PDO',
              'pdo_ibm',
              'pdo_mysql',
              'pdo_pgsql',
              'pdo_sqlite',
              'pgsql',
              'Phar',
              'posix',
              'pspell',
              'readline',
              'Reflection',
              'session',
              'shmop',
              'SimpleXML',
              'snmp',
              'soap',
              'sockets',
              'sodium',
              'SPL',
              'sqlite3',
              'standard',
              'superglobals',
              'sysvmsg',
              'sysvsem',
              'sysvshm',
              'tidy',
              'tokenizer',
              'xml',
              'xmlreader',
              'xmlrpc',
              'xmlwriter',
              'xsl',
              'Zend OPcache',
              'zip',
              'zlib',
            },
            environment = {
              includePaths = {},
            },
            files = {
              maxSize = 5000000,
            },
            diagnostics = {
              enable = true,
            },
            format = {
              enable = true,
            },
          },
        },
      }

      return opts
    end,
  },

  -- PHP CS Fixer for formatting
  {
    'stevearc/conform.nvim',
    opts = function(_, opts)
      -- Make sure formatters_by_ft table exists
      if not opts.formatters_by_ft then
        opts.formatters_by_ft = {}
      end

      -- Add PHP formatter
      opts.formatters_by_ft.php = { 'php_cs_fixer' }

      -- Configure php_cs_fixer
      if not opts.formatters then
        opts.formatters = {}
      end

      opts.formatters.php_cs_fixer = {
        command = 'php-cs-fixer',
        args = { 'fix', '--no-interaction', '--quiet', '$FILENAME' },
        stdin = false,
      }

      return opts
    end,
  },

  -- PHP Linting
  {
    'mfussenegger/nvim-lint',
    opts = function(_, opts)
      -- Make sure linters_by_ft table exists
      if not opts.linters_by_ft then
        opts.linters_by_ft = {}
      end

      -- Add PHP linter
      opts.linters_by_ft.php = { 'php' }

      return opts
    end,
  },

  -- Add PHP to Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      -- Make sure ensure_installed table exists
      if not opts.ensure_installed then
        opts.ensure_installed = {}
      end

      -- Add PHP to ensure_installed
      table.insert(opts.ensure_installed, 'php')

      return opts
    end,
  },
}
