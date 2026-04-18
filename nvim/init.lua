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
vim.opt.grepprg = "rg --vimgrep --smart-case --hidden --glob '!.git' '!node_modules"
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.linebreak = true
vim.opt.statusline = '[%n] %<%f %h%w%m%r%=%-14.(%l,%c%V%) %P'
vim.opt.spelllang = {'en', 'es'}
vim.cmd("colorscheme lackluster-hack")
vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
vim.api.nvim_set_hl(0, "OilDir", { fg = "#689d6a" })

-- 
vim.api.nvim_create_autocmd("FileType", {
  pattern = {"html", "markdown","text", "tex","typst"},
  callback = function()
    vim.opt_local.spell = true
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
vim.keymap.set('n', '<leader>bd', ':bd<CR>', {desc = "Buffer delete" })

--format
vim.keymap.set('n', '<leader>f', function()
  vim.lsp.buf.format()
end)

-- correct words on the fly
vim.api.nvim_set_keymap('i', '<C-l>', '<C-g>u<Esc>[s1z=`]a<C-g>u', { noremap = true, silent = true})

-- move through windows
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
end, { desc = "Replace variable in file" })

-- save
vim.keymap.set('n', '<C-s>', ":w<CR>", { noremap = true})

-- python run
vim.keymap.set('n', '<leader><F8>', ':term python3 %<CR>', { noremap = true, silent = true} )

-- navigate errors
vim.keymap.set("n", "]g", vim.diagnostic.goto_next)
vim.keymap.set("n", "[g", vim.diagnostic.goto_prev)

-- goto dec
vim.keymap.set('n', "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", {desc = "Open declaration"}, { silent = true, noremap = true})

vim.keymap.set('n', "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", {desc = "Open definition"}, { silent = true, noremap = true})

vim.keymap.set("n", "<leader>db", ":DBUI<CR>", { desc = "Open Dadbod UI" })
vim.keymap.set("n", "<leader>dt", ":DBUIToggle<CR>", { desc = "Toggle DB UI" })

-- Configs of plugins

vim.g.db_ui_use_nerd_fonts = 1
vim.g.db_ui_auto_executable_table_helpers = 1

require("bufferline").setup{}

require("nvim-highlight-colors").setup {
  render = 'virtual',
  virtual_symbol = '■',
  virtual_symbol_suffix = '',
}

require("oil").setup({
  delete_to_trash = true,
  skip_confirm_for_simple_edits = true,
})
require("oil").set_columns({
  "icon",
  "size",
  "mtime",
})
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

local cmp = require('cmp')

cmp.setup.filetype( { 'sql', 'mysql', 'plsql' }, { 
  sources = {
    { name = 'vim-dadbod-completion' },
    { name = 'buffer' },
  },
})

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
  },
})

-- LSP
vim.lsp.config('astro', {})
vim.lsp.enable('astro')

vim.lsp.config('sqls', {})
vim.lsp.enable('sqls')

vim.lsp.config('pyright', {})
vim.lsp.enable('pyright')

vim.lsp.config('lua_ls', {})
vim.lsp.enable('lua_ls')

vim.lsp.config('bashls', {})
vim.lsp.enable('bashls')

vim.lsp.config('bashls', {})
vim.lsp.enable('bashls')

vim.lsp.config('ts_ls', {})
vim.lsp.enable('ts_ls')

vim.lsp.config["tinymist"] = {
  cmd = { "tinymist" },
  filetypes = { "typst" },
  settings = {
  }
}

vim.lsp.enable('tinymist')

local ts_parsers = {
  "bash",
  "dockerfile",
  "git_config", "git_rebase", "gitattributes", "gitcommit", "gitignore",
  "json", "toml", "yaml",
  "lua",
  "make",
  "markdown",
  "python",
  "sql",
  "vim", "vimdoc",
}

local nts = require("nvim-treesitter")
nts.install(ts_parsers)
vim.api.nvim_create_autocmd('PackChanged', { 
    callback = function()
        nts.update()
    end
})

require("treesitter-context").setup({
  max_lines = 3,
  multiline_threshold = 1,
  separator = '-',
  min_window_height = 20,
  line_numbers = true,
})


vim.api.nvim_create_autocmd("FileType", { -- enable treesitter highlighting and indents
  callback = function(args)
    local filetype = args.match
    local lang = vim.treesitter.language.get_lang(filetype)
    if vim.treesitter.language.add(lang) then
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      vim.treesitter.start()
    end
  end
})


-- vim.api.nvim_create_autocmd('LspAttach', {
--     callback = function(args)
--         vim.o.signcolumn = 'yes:1'
--         local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
--         if client:supports_method('textDocument/completion') then
--             vim.o.complete = 'o,.,w,b,u'
--             vim.o.completeopt = 'menu,menuone,popup,noinsert'
--             vim.lsp.completion.enable(true, client.id, args.buf)
--         end
--     end
-- })

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function()
    vim.o.signcolumn = 'yes:1'
  end
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "oil://*",
  callback = function()
    local dir = require("oil").get_current_dir()
    if dir then
      vim.cmd("lcd " .. dir)
    end
  end,
})

