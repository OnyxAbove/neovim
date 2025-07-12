-- PLUGIN CONFIGURATION

require('bufferline').setup {}

require('cmp').setup {
  mapping = {
    ['<CR>'] = function(fallback)
      if require('cmp').visible() then
        require('cmp').confirm()
      else
        fallback()
      end
    end,
  },
}

local wk = require 'which-key'

wk.setup {
  -- your existing configuration options
}

wk.add {
  { '<leader>e', group = '[E]xplorer' },
  { '<leader>ec', '<cmd>NvimTreeClose<CR>', desc = 'Close file explorer' },
  { '<leader>ee', '<cmd>NvimTreeFocus<CR>', desc = 'Focus file explorer' },
  { '<leader>ef', '<cmd>NvimTreeFindFileToggle<CR>', desc = 'Toggle file explorer on current file' },
  { '<leader>er', '<cmd>NvimTreeRefresh<CR>', desc = 'Refresh file explorer' },
  { '<leader>o', group = '[O]pen' },
  { '<leader>ot', '<cmd>terminal<CR>', desc = 'Open a terminal in a new buffer' },
  { '<leader><Tab>', '<cmd>BufferLineCycleNext<CR>', desc = 'Next Buffer' },
}

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Completion Plugin Setup
local cmp = require 'cmp'
cmp.setup {
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
      vim.fn['vsnip#anonymous'](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-S-f>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    },
  },
  -- Installed sources:
  sources = {
    { name = 'path' }, -- file paths
    { name = 'nvim_lsp', keyword_length = 3 }, -- from language server
    { name = 'nvim_lsp_signature_help' }, -- display function signatures with current parameter emphasized
    { name = 'nvim_lua', keyword_length = 2 }, -- complete neovim's Lua runtime API such vim.lsp.*
    { name = 'buffer', keyword_length = 2 }, -- source current buffer
    { name = 'vsnip', keyword_length = 2 }, -- nvim-cmp source for vim-vsnip
    { name = 'calc' }, -- source for math calculation
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
}

-- Treesitter Plugin Setup
require('nvim-treesitter.configs').setup {
  -- Required fields
  modules = {},
  sync_install = false,
  ignore_install = {},

  -- Previously configured options
  ensure_installed = { 'lua', 'rust', 'toml' },
  auto_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  --  indent = { enable = true },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  },
}
