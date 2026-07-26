vim.pack.add {
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/stevearc/oil.nvim',
  'https://github.com/brenoprata10/nvim-highlight-colors',
  'https://github.com/hrsh7th/nvim-cmp',
  'https://github.com/hrsh7th/cmp-nvim-lsp',
  'https://github.com/hrsh7th/cmp-buffer',
  'https://github.com/hrsh7th/cmp-path',
  'https://github.com/tpope/vim-dadbod',
  'https://github.com/folke/which-key.nvim',
  'https://github.com/kristijanhusak/vim-dadbod-ui',
  'https://github.com/kristijanhusak/vim-dadbod-completion',
  'https://github.com/slugbyte/lackluster.nvim',
  'https://github.com/akinsho/bufferline.nvim',
  'https://github.com/ibhagwan/fzf-lua',
  'https://github.com/L3MON4D3/LuaSnip',
  'https://github.com/saadparwaiz1/cmp_luasnip',
  'https://github.com/windwp/nvim-autopairs',
  'https://github.com/numToStr/Comment.nvim',
  'https://github.com/lewis6991/gitsigns.nvim',
  'https://github.com/lukas-reineke/indent-blankline.nvim',
  'https://github.com/nvim-lualine/lualine.nvim',
  'https://github.com/williamboman/mason.nvim',
  'https://github.com/williamboman/mason-lspconfig.nvim',
}

vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = 'main' },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-context", },
})

vim.cmd.packadd('nvim.undotree')
vim.cmd.packadd('nvim.difftool')

vim.g.mapleader = ' '
vim.opt.clipboard = 'unnamedplus'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.completeopt = 'menu,menuone,fuzzy,noinsert'
vim.opt.confirm = true
vim.opt.termguicolors = true
vim.opt.wildoptions:append { 'fuzzy' }
vim.opt.smoothscroll = true
vim.opt.grepprg = "rg --vimgrep --smart-case --hidden --glob '!.git' --glob '!node_modules'"
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.linebreak = true
vim.opt.statusline = '[%n] %<%f %h%w%m%r%=%-14.(%l,%c%V%) %P'
vim.opt.spelllang = { 'en', 'es' }

vim.cmd("colorscheme lackluster-hack")
vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
vim.api.nvim_set_hl(0, "OilDir", { fg = "#689d6a" })

-- spell
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "html", "markdown", "text", "tex", "typst" },
  callback = function()
    vim.opt_local.spell = true
  end,
})

-- LSP attach: signcolumn, inlay hints, keymaps
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local buf = args.buf

    vim.o.signcolumn = "yes:1"
    vim.lsp.inlay_hint.enable(true, { bufnr = buf })

    -- Enable built-in LSP completion with automatic popup
    vim.lsp.completion.enable(true, args.data.client_id, buf, {
      autotrigger = true,
    })

    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = buf, desc = "Hover" })
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = buf, desc = "Rename" })
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = buf, desc = "Code action" })
    vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { buffer = buf, desc = "Signature help" })

    -- Optional: manually trigger completion
    vim.keymap.set("i", "<C-Space>", function()
      vim.lsp.completion.get()
    end, { buffer = buf, desc = "Complete" })
  end,
})

-- oil: chdir into opened directory
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "oil://*",
  callback = function()
    local dir = require("oil").get_current_dir()
    if dir then
      vim.cmd("lcd " .. dir)
    end
  end,
})

-- grep
vim.keymap.set("n", "<leader>g", function()
  local query = vim.fn.input("Grep > ", vim.fn.expand("<cword>"))
  if query == "" then return end

  local cmd = "rg --vimgrep --smart-case --hidden --glob '!.git' --glob '!node_modules' "
    .. vim.fn.shellescape(query)

  local results = vim.fn.systemlist(cmd)

  if vim.v.shell_error ~= 0 then
    print("Ripgrep failed")
    return
  end

  if #results == 0 then
    print("No matches found")
    return
  end

  vim.fn.setqflist({}, " ", {
    title = "Grep: " .. query,
    lines = results,
    efm = "%f:%l:%c:%m",
  })

  vim.cmd("copen")
end, { desc = "Ripgrep search" })

-- buffer navigation
vim.keymap.set('n', '<leader>bd', '<cmd>bd<CR>', { desc = "Buffer delete" })
vim.keymap.set('n', ']b', '<cmd>bnext<CR>', { desc = "Next buffer" })
vim.keymap.set('n', '[b', '<cmd>bprevious<CR>', { desc = "Previous buffer" })
vim.keymap.set('n', '<leader>bl', '<cmd>blast<CR>', { desc = "Last buffer" })
vim.keymap.set('n', '<leader>bf', '<cmd>bfirst<CR>', { desc = "First buffer" })
for i = 1, 9 do
  vim.keymap.set('n', '<leader>' .. i, function()
    vim.cmd.buffer(i)
  end, { desc = 'Buffer ' .. i })
end

-- fzf-lua
vim.keymap.set('n', '<leader>ff', function() require("fzf-lua").files() end, { desc = 'Find files' })
vim.keymap.set('n', '<leader>fg', function() require("fzf-lua").live_grep() end, { desc = 'Live grep' })
vim.keymap.set('n', '<leader>fb', function() require("fzf-lua").buffers() end, { desc = 'Find buffers' })
vim.keymap.set('n', '<leader>fh', function() require("fzf-lua").help_tags() end, { desc = 'Help tags' })
vim.keymap.set('n', '<leader>fr', function() require("fzf-lua").resume() end, { desc = 'Resume fzf-lua' })
vim.keymap.set('n', '<leader>f;', function() require("fzf-lua").commands() end, { desc = 'Commands' })

-- -- format
-- vim.keymap.set('n', '<leader>f', function()
--   vim.lsp.buf.format()
-- end, { desc = 'Format buffer' })

-- spell fix
vim.api.nvim_set_keymap('i', '<C-l>', '<C-g>u<Esc>[s1z=`]a<C-g>u', { noremap = true, silent = true })

-- window navigation
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })

-- local replace
vim.keymap.set("n", "<leader>sr", function()
  local old_var = vim.fn.input("Old variable: ")
  local new_var = vim.fn.input("New variable: ")
  if old_var ~= "" and new_var ~= "" then
    vim.cmd(string.format("%%s/%s/%s/g", old_var, new_var))
  end
end, { desc = "Replace in file" })

-- save
vim.keymap.set('n', '<C-s>', '<cmd>w<CR>', { noremap = true, desc = 'Save' })

-- python run
vim.keymap.set('n', '<leader><F8>', '<cmd>term python3 %<CR>', { noremap = true, silent = true, desc = 'Run python' })

-- diagnostic navigation
vim.keymap.set("n", "]g", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
vim.keymap.set("n", "[g", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })

-- go to definition / declaration
vim.keymap.set('n', "gD", vim.lsp.buf.declaration, { desc = "Open declaration" })
vim.keymap.set('n', "gd", vim.lsp.buf.definition, { desc = "Open definition" })

-- dadbod
vim.keymap.set("n", "<leader>db", "<cmd>DBUI<CR>", { desc = "Open DB UI" })
vim.keymap.set("n", "<leader>dt", "<cmd>DBUIToggle<CR>", { desc = "Toggle DB UI" })

-- ========================================
-- PLUGIN CONFIGURATIONS
-- ========================================

vim.g.db_ui_use_nerd_fonts = 1
vim.g.db_ui_auto_executable_table_helpers = 1

require("which-key").setup({})

require("bufferline").setup {}

require("nvim-highlight-colors").setup {
  render = 'virtual',
  virtual_symbol = '■',
  virtual_symbol_suffix = '',
}

require("oil").setup {
  delete_to_trash = true,
  skip_confirm_for_simple_edits = true,
}
require("oil").set_columns { "icon", "size", "mtime" }
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

require("nvim-autopairs").setup()
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp = require('cmp')
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })

require("Comment").setup()

require("gitsigns").setup {
  signs = {
    add          = { text = '+' },
    change       = { text = '~' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
  },
}

require("ibl").setup {
  indent = { char = '│' },
  scope = { enabled = false },
}

require("lualine").setup {
  options = { icons_enabled = true, theme = 'auto', component_separators = '|', section_separators = '' },
}

-- ========================================
-- LSP: MASON (auto-installs LSP servers)
-- ========================================

require("mason").setup()
require("mason-lspconfig").setup {
  ensure_installed = { "ts_ls", "pyright", "lua_ls", "bashls", "astro" },
}
vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH

-- ========================================
-- LSP: SERVER CONFIGS
-- ========================================

vim.lsp.config('astro', {})
vim.lsp.enable('astro')

vim.lsp.config('pyright', {})
vim.lsp.enable('pyright')

vim.lsp.config('lua_ls', {})
vim.lsp.enable('lua_ls')

vim.lsp.config('bashls', {})
vim.lsp.enable('bashls')

vim.lsp.config('ts_ls', {})
vim.lsp.enable('ts_ls')

vim.lsp.config['tinymist'] = {
  cmd = { "tinymist" },
  filetypes = { "typst" },
  settings = {},
}
vim.lsp.enable('tinymist')

-- ========================================
-- TREESITTER
-- ========================================

require("nvim-treesitter.config").setup {
  ensure_installed = {
    "bash", "dockerfile",
    "git_config", "git_rebase", "gitattributes", "gitcommit", "gitignore",
    "json", "toml", "yaml",
    "lua",
    "make",
    "markdown",
    "python",
    "sql",
    "vim", "vimdoc",
  },
  auto_install = true,
  highlight = { enable = true },
  indent = { enable = true },
}

require("treesitter-context").setup {
  max_lines = 3,
  multiline_threshold = 1,
  separator = '-',
  min_window_height = 20,
  line_numbers = true,
}

-- ========================================
-- COMPLETION (nvim-cmp)
-- ========================================

local luasnip = require("luasnip")

cmp.setup.filetype({ 'sql', 'mysql', 'plsql' }, {
  sources = {
    { name = 'vim-dadbod-completion' },
  },
})

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
  },
})
