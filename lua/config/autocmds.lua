local function augroup(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

local autocmd = vim.api.nvim_create_autocmd

-- close some filetypes with <q>
autocmd('FileType', {
  group = augroup('close_with_q'),
  pattern = {
    'help',
    'man',
    'checkhealth',
    'dap-float',
  },
  callback = function(args)
    vim.bo[args.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = args.buf, silent = true })
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
autocmd('BufWritePre', {
  group = augroup('auto_create_dir'),
  callback = function(args)
    if args.match:match('^%w%w+://') then
      return
    end
    local file = vim.uv.fs_realpath(args.match) or args.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
  end,
})

-- Auto delete whitespace at the end of lines
autocmd('BufWritePre', {
  group = augroup('auto_delete_whitespace'),
  command = [[%s/\s\+$//e]],
})

local function set_makeprg_for_java()
  local cwd = vim.fn.getcwd()
  local gradle = cwd .. '/gradlew'
  local maven = cwd .. '/mvnw'

  if vim.fn.filereadable(gradle) == 1 then
    vim.o.makeprg = gradle .. ' assemble'
  elseif vim.fn.filereadable(maven) == 1 then
    vim.o.makeprg = maven .. ' compile'
  else
    vim.o.makeprg = 'echo "No build tool found"'
  end
end

autocmd('LspAttach', {
  group = augroup('lsp_attach'),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end
    if client.name == 'jdtls' then
      set_makeprg_for_java()
    end
  end,
})

autocmd('FileType', {
  group = augroup('ft_indentation'),
  pattern = {
    'r',
    'rmd',
    'html',
    'javascript',
    'typescript',
    'json',
    'jsonc',
    'css',
    'scss',
    'vue',
    'dart',
    'yaml',
    'markdown',
    'groovy',
    'lua',
    'xml',
    'java',
  },
  callback = function(args)
    vim.bo[args.buf].tabstop = 2
    vim.bo[args.buf].softtabstop = 2
    vim.bo[args.buf].shiftwidth = 2
  end,
})

autocmd('FileType', {
  group = augroup('tex_fold'),
  pattern = { 'plaintex', 'tex', 'latex' },
  callback = function(args)
    vim.g.tex_flavor = 'latex'
    vim.opt.wrap = true
    vim.bo[args.buf].textwidth = 100
    vim.wo.foldmethod = 'expr'
    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
  end,
})

autocmd('FileType', {
  group = augroup('java'),
  pattern = 'java',
  callback = function(args)
    vim.keymap.set('n', '<leader>f', function()
      local view = vim.fn.winsaveview()
      vim.cmd('silent %!google-java-format --skip-javadoc-formatting -')
      vim.fn.winrestview(view)
    end, { buffer = args.buf })
  end,
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lspconfig-lsp-attach', { clear = true }),
  callback = function(event)
    -- The following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while.
    --    See `:help CursorHold` for information about when this is executed
    --
    -- When you move your cursor, the highlights will be cleared (the second autocommand).
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method('textDocument/documentHighlight', event.buf) then
      local highlight_augroup = vim.api.nvim_create_augroup('lspconfig-lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('lspconfig-lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds({ group = 'lspconfig-lsp-highlight', buffer = event2.buf })
        end,
      })
    end
    -- The following code creates a keymap to toggle inlay hints in your
    -- code, if the language server you are using supports them
    --
    -- This may be unwanted, since they displace some of your code
    if client and client:supports_method('textDocument/inlayHint', event.buf) then
      vim.keymap.set('n', '<leader>th', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
      end, { buffer = event.buf, desc = 'LSP: [T]oggle Inlay [H]ints' })
    end
  end,
})
