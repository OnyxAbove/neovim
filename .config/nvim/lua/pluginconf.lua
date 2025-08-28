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

require('neo-tree').setup {
  enable_git_status = true,
  enable_diagnostics = true,

  commands = {},
  window = {
    position = 'left',
    width = 40,
    mapping_options = {
      noremap = true,
      nowait = true,
    },
    mappings = {
      ['<space>'] = {
        'toggle_node',
        nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
      },
      ['<2-LeftMouse>'] = 'open',
      ['<cr>'] = 'open',
      ['<esc>'] = 'cancel', -- close preview or floating neo-tree window
      ['P'] = {
        'toggle_preview',
        config = {
          use_float = true,
          use_snacks_image = true,
          use_image_nvim = true,
        },
      },
      -- Read `# Preview Mode` for more information
      ['l'] = 'focus_preview',
      ['S'] = 'open_split',
      ['s'] = 'open_vsplit',
      -- ["S"] = "split_with_window_picker",
      -- ["s"] = "vsplit_with_window_picker",
      ['t'] = 'open_tabnew',
      -- ["<cr>"] = "open_drop",
      -- ["t"] = "open_tab_drop",
      ['w'] = 'open_with_window_picker',
      --["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
      ['C'] = 'close_node',
      -- ['C'] = 'close_all_subnodes',
      ['z'] = 'close_all_nodes',
      --["Z"] = "expand_all_nodes",
      --["Z"] = "expand_all_subnodes",
      ['a'] = {
        'add',
        -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
        -- some commands may take optional config options, see `:h neo-tree-mappings` for details
        config = {
          show_path = 'none', -- "none", "relative", "absolute"
        },
      },
      ['A'] = 'add_directory', -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
      ['d'] = 'delete',
      ['r'] = 'rename',
      ['b'] = 'rename_basename',
      ['y'] = 'copy_to_clipboard',
      ['x'] = 'cut_to_clipboard',
      ['p'] = 'paste_from_clipboard',
      ['c'] = 'copy', -- takes text input for destination, also accepts the optional config.show_path option like "add":
      -- ["c"] = {
      --  "copy",
      --  config = {
      --    show_path = "none" -- "none", "relative", "absolute"
      --  }
      --}
      ['m'] = 'move', -- takes text input for destination, also accepts the optional config.show_path option like "add".
      ['q'] = 'close_window',
      ['R'] = 'refresh',
      ['?'] = 'show_help',
      ['<'] = 'prev_source',
      ['>'] = 'next_source',
      ['i'] = 'show_file_details',
      -- ["i"] = {
      --   "show_file_details",
      --   -- format strings of the timestamps shown for date created and last modified (see `:h os.date()`)
      --   -- both options accept a string or a function that takes in the date in seconds and returns a string to display
      --   -- config = {
      --   --   created_format = "%Y-%m-%d %I:%M %p",
      --   --   modified_format = "relative", -- equivalent to the line below
      --   --   modified_format = function(seconds) return require('neo-tree.utils').relative_date(seconds) end
      --   -- }
      -- },
    },
  },

  git_status = {
    window = {
      position = 'float',
      mappings = {
        ['A'] = 'git_add_all',
        ['gu'] = 'git_unstage_file',
        ['gU'] = 'git_undo_last_commit',
        ['ga'] = 'git_add_file',
        ['gr'] = 'git_revert_file',
        ['gc'] = 'git_commit',
        ['gp'] = 'git_push',
        ['gg'] = 'git_commit_and_push',
        ['o'] = {
          'show_help',
          nowait = false,
          config = { title = 'Order by', prefix_key = 'o' },
        },
        ['oc'] = { 'order_by_created', nowait = false },
        ['od'] = { 'order_by_diagnostics', nowait = false },
        ['om'] = { 'order_by_modified', nowait = false },
        ['on'] = { 'order_by_name', nowait = false },
        ['os'] = { 'order_by_size', nowait = false },
        ['ot'] = { 'order_by_type', nowait = false },
      },
    },
  },

  nesting_rules = {},
  filesystem = {
    filtered_items = {
      visible = false, -- when true, they will just be displayed differently than normal items
      hide_dotfiles = false,
      hide_gitignored = false,
      hide_hidden = false, -- only works on Windows for hidden files/directories
      hide_by_name = {
        --"node_modules"
      },
      hide_by_pattern = { -- uses glob style patterns
        --"*.meta",
        --"*/src/*/tsconfig.json",
      },
      always_show = { -- remains visible even if other settings would normally hide it
        --".gitignored",
      },
      always_show_by_pattern = { -- uses glob style patterns
        --".env*",
      },
      never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
        --".DS_Store",
        --"thumbs.db"
      },
      never_show_by_pattern = { -- uses glob style patterns
        --".null-ls_*",
      },
    },
    follow_current_file = {
      enabled = false, -- This will find and focus the file in the active buffer every time
      --               -- the current file is changed while the tree is open.
      leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
    },
    group_empty_dirs = false, -- when true, empty folders will be grouped together
    hijack_netrw_behavior = 'open_default', -- netrw disabled, opening a directory opens neo-tree
    -- in whatever position is specified in window.position
    -- "open_current",  -- netrw disabled, opening a directory opens within the
    -- window like netrw would, regardless of window.position
    -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
    use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
    -- instead of relying on nvim autocmd events.
    window = {
      mappings = {
        ['<bs>'] = 'navigate_up',
        ['.'] = 'set_root',
        ['H'] = 'toggle_hidden',
        ['/'] = 'fuzzy_finder',
        ['D'] = 'fuzzy_finder_directory',
        ['#'] = 'fuzzy_sorter', -- fuzzy sorting using the fzy algorithm
        -- ["D"] = "fuzzy_sorter_directory",
        ['f'] = 'filter_on_submit',
        ['<c-x>'] = 'clear_filter',
        ['[g'] = 'prev_git_modified',
        [']g'] = 'next_git_modified',
        ['o'] = {
          'show_help',
          nowait = false,
          config = { title = 'Order by', prefix_key = 'o' },
        },
        ['oc'] = { 'order_by_created', nowait = false },
        ['od'] = { 'order_by_diagnostics', nowait = false },
        ['og'] = { 'order_by_git_status', nowait = false },
        ['om'] = { 'order_by_modified', nowait = false },
        ['on'] = { 'order_by_name', nowait = false },
        ['os'] = { 'order_by_size', nowait = false },
        ['ot'] = { 'order_by_type', nowait = false },
        -- ['<key>'] = function(state) ... end,
      },
      fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
        ['<down>'] = 'move_cursor_down',
        ['<C-n>'] = 'move_cursor_down',
        ['<up>'] = 'move_cursor_up',
        ['<C-p>'] = 'move_cursor_up',
        ['<esc>'] = 'close',
        ['<S-CR>'] = 'close_keep_filter',
        ['<C-CR>'] = 'close_clear_filter',
        ['<C-w>'] = { '<C-S-w>', raw = true },
        {
          -- normal mode mappings
          n = {
            ['j'] = 'move_cursor_down',
            ['k'] = 'move_cursor_up',
            ['<S-CR>'] = 'close_keep_filter',
            ['<C-CR>'] = 'close_clear_filter',
            ['<esc>'] = 'close',
          },
        },
        -- ["<esc>"] = "noop", -- if you want to use normal mode
        -- ["key"] = function(state, scroll_padding) ... end,
      },
    },

    commands = {}, -- Add a custom command or override a global one using the same function name
  },
}
