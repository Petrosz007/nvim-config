-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.number = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true


-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and nvim, :help clipboard
vim.opt.clipboard = 'unnamedplus'
-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true

vim.o.background = 'dark'
vim.cmd([[colorscheme retrobox]]) -- TODO: Is there a more lua way of doing this?

vim.keymap.set('i', 'jk', '<ESC>')
vim.keymap.set('n', 'gb', '<C-T>', { desc = '[g]o [b]ack' }) -- TODO: This might not work all the time, investigate
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set('n', '<Leader>cr', '<CMD>source $MYVIMRC<CR>', { desc = '[c]onfig [r]eload' })

vim.pack.add({
  { src = 'https://github.com/nvim-lua/plenary.nvim',         name = 'planery',       version = 'v0.1.4' },
  { src = 'https://github.com/folke/todo-comments.nvim',      name = 'todo-comments', version = 'v1.4.0' },
  { src = 'https://github.com/nvim-telescope/telescope.nvim', name = 'telescope',     version = '0.1.8' },
  { src = 'https://github.com/nvim-mini/mini.nvim',           name = 'mini',          version = 'v0.16.0' },
})

-- NOTE: Run := vim.pack.update()
-- NOTE: Restart of nvim is required for the packages to be available


require('todo-comments').setup()


local miniclue = require('mini.clue')
miniclue.setup({
  triggers = {
    -- Leader triggers
    { mode = 'n', keys = '<Leader>' },
    { mode = 'x', keys = '<Leader>' },

    -- Built-in completion
    { mode = 'i', keys = '<C-x>' },

    -- `g` key
    { mode = 'n', keys = 'g' },
    { mode = 'x', keys = 'g' },

    -- Marks
    { mode = 'n', keys = "'" },
    { mode = 'n', keys = '`' },
    { mode = 'x', keys = "'" },
    { mode = 'x', keys = '`' },

    -- Registers
    { mode = 'n', keys = '"' },
    { mode = 'x', keys = '"' },
    { mode = 'i', keys = '<C-r>' },
    { mode = 'c', keys = '<C-r>' },

    -- Window commands
    { mode = 'n', keys = '<C-w>' },

    -- `z` key
    { mode = 'n', keys = 'z' },
    { mode = 'x', keys = 'z' },
  },
  cshlues = {
    -- Enhance this by adding descriptions for <Leader> mapping groups
    miniclue.gen_clues.builtin_completion(),
    miniclue.gen_clues.g(),
    miniclue.gen_clues.marks(),
    miniclue.gen_clues.registers(),
    miniclue.gen_clues.windows(),
    miniclue.gen_clues.z(),
    { mode = 'n', keys = '<Leader>b', desc = '+Buffer' },
    { mode = 'n', keys = '<Leader>c', desc = '+Config' },
    { mode = 'n', keys = '<Leader>h', desc = '+Help' },
    { mode = 'n', keys = '<Leader>s', desc = '+Search' },
    { mode = 'n', keys = '<Leader>t', desc = '+Toggle' },
  },
})

-----------------
-- Telescope
local builtin = require('telescope.builtin')

vim.keymap.set("n", "<Leader>sf", builtin.find_files, { desc = "[s]earch [f]iles" })
vim.keymap.set("n", "<Leader>cc", builtin.colorscheme, { desc = "[c]onfig [c]olorscheme" })
vim.keymap.set("n", "<Leader>ls", builtin.lsp_document_symbols, { desc = "[l]sp [s]ymbols" })
vim.keymap.set("n", "<Leader>hh", builtin.help_tags, { desc = "[h]elp [h]elp" })
vim.keymap.set("n", "<Leader>hk", builtin.keymaps, { desc = "[h]elp [k]eymaps" })

------------------
-- Mini
local map = require('mini.map')
map.setup({
  integrations = {
    map.gen_integration.builtin_search(),
    map.gen_integration.diagnostic(),
  },
})
require('mini.icons').setup()
require('mini.notify').setup()
require('mini.icons').setup()
require('mini.completion').setup()
require('mini.statusline').setup({
  use_icons = true, -- TODO: Somehow the icons don't show up properly on the statusline
})
require('mini.diff').setup({
  view = { style = 'sign' }
})
require('mini.colors').setup()

-- Open minimap by default
MiniMap.open()

vim.keymap.set("n", "<Leader>tm", MiniMap.toggle, { desc = "MiniMap toggle" })


-- Show icons on LSP autocompletion
MiniIcons.tweak_lsp_kind()

------------
-- LSP
vim.keymap.set("n", "<Leader>bf", vim.lsp.buf.format, { desc = "[b]uffer [f]ormat" })
vim.keymap.set("n", "<Leader>ld", vim.diagnostic.setloclist, { desc = "[l]sp [d]iagnostics" })

vim.lsp.enable({
  'lua_ls',
  'golangci_lint_ls',
  'gopls',
})


vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    if client:supports_method('textDocument/implementation') then
      -- Create a keymap for vim.lsp.buf.implementation ...
    end

    -- Auto-format ("lint") on save.
    -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
    if not client:supports_method('textDocument/willSaveWaitUntil')
        and client:supports_method('textDocument/formatting') then
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
        end,
      })
    end
  end,
})

-- TODO:
-- Treesitter
-- Nerd icons / mini.icons should work
--
--

-- From: https://yobibyte.github.io/vim.html
-- Other inspiration: https://erock-git-dotfiles.pgs.sh/tree/main/item/dot_config/nvim/init.lua.html
vim.keymap.set("n", "<space>x", function()
  vim.ui.input({}, function(c)
    if c and c ~= "" then
      vim.cmd("noswapfile vnew")
      vim.bo.buftype = "nofile"
      vim.bo.bufhidden = "wipe"
      vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.fn.systemlist(c))
    end
  end)
end, { desc = "e[x]ecute" })
