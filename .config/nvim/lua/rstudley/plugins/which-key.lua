-- NOTE: Plugins can also be configured to run Lua code when they are loaded.
--
-- This is often very useful to both group configuration, as well as handle
-- lazy loading plugins that don't need to be loaded immediately at startup.
--
-- For example, in the following configuration, we use:
--  event = 'VimEnter'
--
-- which loads which-key before all the UI elements are loaded. Events can be
-- normal autocommands events (`:help autocmd-events`).
--
-- Then, because we use the `config` key, the configuration only runs
-- after the plugin has been loaded:
--  config = function() ... end

return {
  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VeryLazy', -- Sets the loading event to 'VimEnter'
    opts = {
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default whick-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },

      -- Document existing key chains
      spec = {
        { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>f', group = '[F]ind' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },

        { '<leader>e', group = '[E]xplorer' },
        { '<leader>ec', '<cmd>Neotree close<CR>', desc = 'Close file explorer' },
        { '<leader>ef', '<cmd>Neotree focus<CR>', desc = 'Focus file explorer' },
        { '<leader>er', '<cmd>Neotree reveal<CR>', desc = 'Reveal file explorer' },

        { '<leader>o', group = '[O]pen' },
        { '<leader>ot', group = '[T]erminal' },
        { '<leader>oth', '<cmd>split | terminal<CR><C-End>i', desc = 'Open a terminal in a horizontal split' },
        { '<leader>otv', '<cmd>vsplit | terminal<CR><C-End>i', desc = 'Open a terminal in vertical split' },
        { '<leader>otb', '<cmd>terminal<CR><C-End>i', desc = 'Open a terminal in a new buffer' },
        { '<leader><Tab>', '<cmd>BufferLineCycleNext<CR>', desc = 'Next Buffer' },

        { '<leader>a', group = 'T[a]bs' },
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
        { '<leader>bsd', '<cmd>BufferLineSortByDirectory<CR>', desc = 'Sort By Directory' },
        { '<leader>bse', '<cmd>BufferLineSortByExtension<CR>', desc = 'Sort By File Extension' },
        { '<leader>bsr', '<cmd>BufferLineSortByRelativeDirectory<CR>', desc = 'Sort by Relative Directory' },
        { '<leader>bst', '<cmd>BufferLineSortByTabs<CR>', desc = 'Sort By Tabs' },

        { '<leader>bc', group = '[C]lose' },
        { '<leader>bcc', '<cmd>bd!<CR>', desc = 'Close Current' },
        { '<leader>bcl', '<cmd>BufferLineCloseLeft<CR>', desc = 'Close Left' },
        { '<leader>bcr', '<cmd>BufferLineCloseRight<CR>', desc = 'Close Right' },
        { '<leader>bco', '<cmd>BufferLineCloseOthers<CR>', desc = 'Close Others' },

        { '<leader>bm', group = '[M]ove' },
        { '<leader>bmn', '<cmd>BufferLineMoveNext<CR>', desc = 'Move Next' },
        { '<leader>bmp', '<cmd>BufferLineMovePrev<CR>', desc = 'Move Previous' },
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
