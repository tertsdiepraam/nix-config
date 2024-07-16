local cmp = require("cmp")
cmp.setup {
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'path' },
        { name = 'vsnip' },
        { name = 'spell' },
    }, {
        { name = 'buffer' },
    }),
    comparators = {
      -- compare.score_offset, -- not good at all
      cmp.config.compare.locality,
      cmp.config.compare.recently_used,
      cmp.config.compare.score,
      cmp.config.compare.offset,
      cmp.config.compare.order,
    },
}

-- key mapping
local opts = { noremap = true, silent = true }
local builtin = require('telescope.builtin')

-- comment
vim.keymap.set("n", "<C-/>", ":lua require('Comment.api').toggle.linewise.current()<CR> j", opts)
vim.keymap.set("v", "<C-/>", ":lua require('Comment.api').toggle.linewise.current()<CR> j", opts)

-- indent and dedent using tab/shift-tab
vim.keymap.set("n", "<tab>", ">>_")
vim.keymap.set("n", "<s-tab>", "<<_")
vim.keymap.set("i", "<s-tab>", "<c-d>")
vim.keymap.set("v", "<Tab>", ">gv")
vim.keymap.set("v", "<S-Tab>", "<gv")

vim.keymap.set('n', 'gr', builtin.lsp_references, {})
vim.keymap.set('n', 'gd', builtin.lsp_definitions, {})
vim.keymap.set('n', 'gi', builtin.lsp_implementations, {})
vim.keymap.set('n', 'gt', builtin.lsp_type_definitions, {})

-- format on wq and x and replace X, W and Q with x, w and q
vim.cmd [[cabbrev wq execute "Format sync" <bar> wq]]
vim.cmd [[cabbrev x execute "Format sync" <bar> x]]
vim.cmd [[cnoreabbrev W w]]
vim.cmd [[cnoreabbrev X execute "Format sync" <bar> x]]
vim.cmd [[cnoreabbrev Q q]]
vim.cmd [[nnoremap ; :]]

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader><leader>', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fh', builtin.search_history, {})
vim.keymap.set('n', '<leader>d', "<cmd>Telescope diagnostics bufnr=0<cr>", {})
vim.keymap.set('n', '<leader>ad', builtin.diagnostics, {})
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)

local gitsigns = require('gitsigns')
vim.keymap.set('n', '<leader>gr', gitsigns.reset_hunk)
vim.keymap.set('n', '<leader>gd', gitsigns.diffthis)

vim.keymap.set({'o', 'x'}, 'ig', ':<C-U>Gitsigns select_hunk<CR>')
vim.keymap.set('n', '<leader>t', ':Neotree toggle<CR>')

vim.keymap.set('n', "t", ":FloatermToggle myfloat<CR>", opts)
vim.keymap.set('t', "<Esc>", "<C-\\><C-n>:q<CR>", opts)

-- ============ files and directories ==============

-- don't change the directory when a file is opened
-- to work more like an IDE
vim.opt.autochdir = false

-- ============ tabs and indentation ==============
-- automatically indent the next line to the same depth as the current line
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.smarttab = true
-- backspace across lines
vim.opt.backspace = { "indent", "eol", "start" }

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- ============ line numbers ==============
-- set number,relativenumber
vim.opt.number = true
vim.opt.relativenumber = true
