return {
  "neovim/nvim-lspconfig",
  config = function()
    vim.lsp.set_log_level("off")

    vim.lsp.config("intelephense", {
      settings = {
        intelephense = {
          environment = {
            phpVersion = "8.2",
          },
          files = {
            maxSize = 5000000,
          },
          stubs = {
            "apache", "bcmath", "bz2", "calendar", "com_dotnet", "Core", "ctype",
            "curl", "date", "dba", "dom", "enchant", "exif", "FFI", "fileinfo",
            "filter", "fpm", "ftp", "gd", "gettext", "gmp", "hash", "iconv",
            "imap", "intl", "json", "ldap", "libxml", "mbstring", "meta", "mysqli",
            "oci8", "odbc", "openssl", "pcntl", "pcre", "PDO", "pdo_ibm",
            "pdo_mysql", "pdo_pgsql", "pdo_sqlite", "pgsql", "Phar", "posix",
            "pspell", "readline", "Reflection", "session", "shmop", "SimpleXML",
            "snmp", "soap", "sockets", "sodium", "SPL", "sqlite3", "standard",
            "superglobals", "sysvmsg", "sysvsem", "sysvshm", "tidy", "tokenizer",
            "xml", "xmlreader", "xmlrpc", "xmlwriter", "xsl", "Zend OPcache",
            "zip", "zlib",
          },
        },
      },
    })

    vim.lsp.config("vtsls", {
      filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
      settings = {
        vtsls = {
          tsserver = {
            globalPlugins = {
              {
                name = "@vue/typescript-plugin",
                location = vim.fn.stdpath("data")
                  .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
                languages = { "vue" },
                configNamespace = "typescript",
                enableForWorkspaceTypeScriptVersions = true,
              },
            },
          },
        },
        -- typescript = {
        --   preferences = {
        --     importModuleSpecifier = "non-relative",
        --   },
        -- },
      },
    })
  end,
}
