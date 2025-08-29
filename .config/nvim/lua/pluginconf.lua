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

  { '<leader>a', 'T[a]bs' },
  { '<leader>an', '<cmd>tabnew<CR>', desc = 'New Tab' },
  { '<leader>a<Tab>', '<cmd>tabNext<CR>', desc = 'Next Tab' },
  { '<leader>ap', '<cmd>tabprevious<CR>', desc = 'Previous Tab' },
  { '<leader>ac', '<cmd>tabclose<CR>', desc = 'Close Tab' },
  { '<leader>ao', '<cmd>tabonly<CR>', desc = 'Close Other Tab' },
  { '<leader>af', '<cmd>tabfirst<CR>', desc = 'Go To First Tab' },
  { '<leader>al', '<cmd>tablast<CR>', desc = 'Go To Last Tab' },

  { '<leader>am', desc = '[M]ove' },
  { '<leader>amn', '<cmd>tabmove +N<CR>', desc = 'Move Tab Next' },
  { '<leader>amp', '<cmd>tabmove -N<CR>', desc = 'Move Tab Previous' },
  { '<leader>amf', '<cmd>tabmove 0<CR>', desc = 'Move Tab First' },
  { '<leader>aml', '<cmd>tabmove<CR>', desc = 'Move Tab Last' },

  { '<leader>b', group = '[B]uffer' },
  { '<leader>b1', '<cmd>BufferLineGoTo 1<CR>', desc = 'Go To Buffer 1' },
  { '<leader>b2', '<cmd>BufferLineGoTo 2<CR>', desc = 'Go To Buffer 2' },
  { '<leader>b3', '<cmd>BufferLineGoTo 3<CR>', desc = 'Go To Buffer 3' },
  { '<leader>b4', '<cmd>BufferLineGoTo 4<CR>', desc = 'Go To Buffer 4' },
  { '<leader>b5', '<cmd>BufferLineGoTo 5<CR>', desc = 'Go To Buffer 5' },
  { '<leader>b6', '<cmd>BufferLineGoTo 6<CR>', desc = 'Go To Buffer 6' },
  { '<leader>b7', '<cmd>BufferLineGoTo 7<CR>', desc = 'Go To Buffer 7' },
  { '<leader>b8', '<cmd>BufferLineGoTo 8<CR>', desc = 'Go To Buffer 8' },
  { '<leader>b9', '<cmd>BufferLineGoTo 9<CR>', desc = 'Go To Buffer 9' },
  { '<leader>b0', '<cmd>BufferLineGoTo 10<CR>', desc = 'Go To Buffer 10' },

  { '<leader>bp', '<cmd>BufferLineTogglePin<CR>', desc = 'Toggle Pinned Buffer' },

  { '<leader>bs', group = '[S]ort' },
  { '<leader>bsd', '<cmd>BufferLineSortByDirectory<CR>', desc = 'Close Left' },
  { '<leader>bse', '<cmd>BufferLineSortByExtension<CR>', desc = 'Close Left' },
  { '<leader>bsr', '<cmd>BufferLineSortByRelativeDirectory<CR>', desc = 'Close Left' },
  { '<leader>bst', '<cmd>BufferLineSortByTabs<CR>', desc = 'Close Left' },

  { '<leader>bc', group = '[C]lose' },
  { '<leader>bsc', '<cmd>bd<CR>', desc = 'Close Current' },
  { '<leader>bcl', '<cmd>BufferLineCloseLeft<CR>', desc = 'Close Left' },
  { '<leader>bcr', '<cmd>BufferLineCloseRight<CR>', desc = 'Close Right' },
  { '<leader>bco', '<cmd>BufferLineCloseOthers<CR>', desc = 'Close Others' },

  { '<leader>bm', group = '[M]ove' },
  { '<leader>bmn', '<cmd>BufferLineMoveNext<CR>', desc = 'Move Next' },
  { '<leader>bmp', '<cmd>BufferLineMovePrev<CR>', desc = 'Move Previous' },
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
