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

-- zoxide
require("telescope").load_extension('zoxide')

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

vim.keymap.set('n', 'gr', builtin.lsp_references, { desc = "References" })
vim.keymap.set('n', 'gd', builtin.lsp_definitions, { desc = "Definitions" })
vim.keymap.set('n', 'gi', builtin.lsp_implementations, { desc = "Implementations"})
vim.keymap.set('n', 'gt', builtin.lsp_type_definitions, { desc = "Type definitions"})

-- format on wq and x and replace X, W and Q with x, w and q
-- vim.cmd [[cabbrev wq execute "Format sync" <bar> wq]]
-- vim.cmd [[cabbrev x execute "Format sync" <bar> x]]
vim.cmd [[cnoreabbrev W w]]
vim.cmd [[cnoreabbrev X execute "Format sync" <bar> x]]
vim.cmd [[cnoreabbrev Q q]]
vim.cmd [[nnoremap ; :]]

local wk = require('which-key')
wk.add({
    { "<leader>f", group = "Find" },
    { "<leader>g", group = "Git/Goto" },
})

vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find files" })
vim.keymap.set('n', '<leader><leader>', builtin.live_grep, { desc = "Live grep" })
vim.keymap.set('n', '<leader>fh', builtin.search_history, { desc = "Search history" })
vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, { desc = "Find document symbols" })
vim.keymap.set('n', '<leader>fS', builtin.lsp_dynamic_workspace_symbols, { desc = "Find workspace symbols" })
vim.keymap.set('n', '<leader>d', "<cmd>Telescope diagnostics bufnr=0<cr>", { desc = "Diagnostics" })
vim.keymap.set('n', '<leader>ad', builtin.diagnostics, { desc = "All diagnostics" })
vim.keymap.set('n', '<leader>k', "<cmd>Lspsaga hover_doc<cr>", { desc = "Hover doc" })
vim.keymap.set('n', '<leader>a', "<cmd>Lspsaga code_action<cr>", { desc = "Code action" })
vim.keymap.set("n", "<leader>z", require("telescope").extensions.zoxide.list, { desc = "Jump with zoxide" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)

local gitsigns = require('gitsigns')
local neogit = require('neogit')
vim.keymap.set('n', '<leader>gr', gitsigns.reset_hunk, { desc = "Reset hunk" })
vim.keymap.set('n', '<leader>gd', gitsigns.diffthis, { desc = "Diff this" })
vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = "Git branches" })
vim.keymap.set('n', '<leader>gg', neogit.open, { desc = "Git status" })

vim.keymap.set({'o', 'x'}, 'ig', ':<C-U>Gitsigns select_hunk<CR>')
vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>', { desc = "Toggle explorer" })

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

vim.keymap.set(
    {'n', 'v', 's', 'x', 'o', 'i', 'l', 'c', 't'},
    '<C-S-v>',
    function() vim.api.nvim_paste(vim.fn.getreg('+'), true, -1) end,
    { noremap = true, silent = true }
)
