---@type vim.lsp.Config
local opts = {
  flags = {
    allow_incremental_sync = false,
  },
  ---@type lspconfig.settings.jdtls
  settings = {
    java = {
      configuration = {
        runtimes = {
          {
            name = 'JavaSE-17',
            path = '/usr/lib/jvm/java-17-openjdk/',
          },
          {
            name = 'JavaSE-21',
            path = '/usr/lib/jvm/java-21-openjdk/',
          },
          {
            name = 'JavaSE-25',
            path = '/usr/lib/jvm/java-25-openjdk/',
            default = true,
          },
        },
      },
      format = {
        settings = {
          url = 'https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml',
          profile = 'GoogleStyle',
        },
      },
      inlayHints = {
        parameterNames = {
          enabled = 'all',
        },
      },
    },
    redhat = {
      telemetry = {
        enabled = false,
      },
    },
  },
}
local bundles = {
  vim.fn.stdpath('data') .. '/mason/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar',
}
local java_test_bundles = vim.split(vim.fn.glob(vim.fn.stdpath('data') .. '/mason/share/java-test/*.jar', true), '\n')
local excluded = {
  'com.microsoft.java.test.plugin.jar',
  'com.microsoft.java.test.runner-jar-with-dependencies.jar',
  'jacocoagent.jar',
}
for _, java_test_jar in ipairs(java_test_bundles) do
  local fname = vim.fn.fnamemodify(java_test_jar, ':t')
  if not vim.tbl_contains(excluded, fname) then
    table.insert(bundles, java_test_jar)
  end
end

opts['init_options'] = {
  bundles = bundles,
}

if vim.env.MAVEN_ARGS then
  opts.settings.java.configuration.maven = {
    userSettings = vim.fn.slice(vim.env.MAVEN_ARGS, 3),
  }
end

local lombok_jar = vim.fn.stdpath('data') .. '/mason/share/jdtls/lombok.jar'
vim.env.JDTLS_JVM_ARGS = string.format('-javaagent:%s', lombok_jar)

return opts
