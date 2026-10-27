-- ========================================
-- PLUGINS
-- Requires a recent Neovim version with vim.pack.
-- nvim-treesitter main requires Neovim 0.12+.
-- ========================================

vim.pack.add({
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/brenoprata10/nvim-highlight-colors" },

  { src = "https://github.com/hrsh7th/nvim-cmp" },
  { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
  { src = "https://github.com/hrsh7th/cmp-buffer" },
  { src = "https://github.com/hrsh7th/cmp-path" },

  { src = "https://github.com/L3MON4D3/LuaSnip" },
  { src = "https://github.com/saadparwaiz1/cmp_luasnip" },
  { src = "https://github.com/windwp/nvim-autopairs" },

  { src = "https://github.com/tpope/vim-dadbod" },
  { src = "https://github.com/kristijanhusak/vim-dadbod-ui" },
  { src = "https://github.com/kristijanhusak/vim-dadbod-completion" },

  { src = "https://github.com/folke/which-key.nvim" },
  { src = "https://github.com/slugbyte/lackluster.nvim" },
  { src = "https://github.com/akinsho/bufferline.nvim" },
  { src = "https://github.com/ibhagwan/fzf-lua" },
  { src = "https://github.com/numToStr/Comment.nvim" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/lukas-reineke/indent-blankline.nvim" },
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  { src = "https://github.com/NeogitOrg/neogit" },
  { src = "https://github.com/chomosuke/typst-preview.nvim" },

  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
    version = "main",
  },
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter-context",
  },

  -- Add this if you want to keep using :colorscheme catppuccin:
  { src = "https://github.com/catppuccin/nvim" },
})

-- Custom packages installed in your Neovim pack directory.
vim.cmd.packadd("nvim.undotree")
vim.cmd.packadd("nvim.difftool")

-- ========================================
-- OPTIONS
-- ========================================

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.clipboard = "unnamedplus"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes:1"

vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
-- vim.opt.completeopt = 'menu,menuone,fuzzy,noinsert'
vim.opt.softtabstop = 2
vim.opt.shiftround = true

vim.opt.confirm = true
vim.opt.termguicolors = true
vim.opt.wildoptions:append("fuzzy")
vim.opt.smoothscroll = true
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.mouse = "a"

vim.opt.grepprg =
  "rg --vimgrep --smart-case --hidden --glob '!.git' --glob '!node_modules'"
vim.opt.grepformat = "%f:%l:%c:%m"

vim.opt.statusline =
  "[%n] %<%f %h%w%m%r%=%-14.(%l,%c%V%) %P"

vim.opt.spelllang = { "en", "es" }

-- ========================================
-- HELPERS
-- ========================================

local map = vim.keymap.set
local api = vim.api

local function notify(message, level)
  vim.notify(message, level or vim.log.levels.INFO)
end

-- Escape user input before using it as a Vim regex pattern.
local function escape_pattern(value)
  return vim.fn.escape(value, [[\/.*$^~[]])
end

-- Escape replacement text, including &, which means "whole match".
local function escape_replacement(value)
  return vim.fn.escape(value, [[\&~]])
end

-- ========================================
-- THEME
-- ========================================

vim.cmd.colorscheme("catppuccin")

api.nvim_set_hl(0, "Normal", { bg = "NONE" })
api.nvim_set_hl(0, "OilDir", { fg = "#689d6a" })

-- ========================================
-- AUTOCMDS
-- ========================================

local general = api.nvim_create_augroup("UserGeneral", { clear = true })

api.nvim_create_autocmd("FileType", {
  group = general,
  pattern = { "html", "markdown", "text", "tex", "typst" },
  callback = function()
    vim.opt_local.spell = true
  end,
})

api.nvim_create_autocmd("FileType", {
  group = general,
  pattern = "sql",
  callback = function()
    -- Keep SQL completion under nvim-cmp control.
    vim.bo.omnifunc = ""
  end,
})

-- Follow the directory opened in Oil.
api.nvim_create_autocmd("BufEnter", {
  group = general,
  pattern = "oil://*",
  callback = function()
    local ok, oil = pcall(require, "oil")
    if not ok then
      return
    end

    local dir = oil.get_current_dir()
    if dir then
      vim.cmd.lcd(vim.fn.fnameescape(dir))
    end
  end,
})

-- ========================================
-- LSP
-- ========================================

local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config("*", {
  capabilities = capabilities,
})

-- Configure server-specific settings before enabling servers.
vim.lsp.config("astro", {})

vim.lsp.config("pyright", {})

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        checkThirdParty = false,
      },
      completion = {
        callSnippet = "Replace",
      },
    },
  },
})

vim.lsp.config("bashls", {})
vim.lsp.config("ts_ls", {})
vim.lsp.config("nixd", {})

vim.lsp.config("tinymist", {
  cmd = { "tinymist" },
  filetypes = { "typst" },
  settings = {},
})

vim.lsp.config("rust_analyzer", {
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      },
      check = {
        command = "clippy",
      },
      procMacro = {
        enable = true,
      },
    },
  },
})

vim.lsp.config("tailwindcss", {
  cmd = {
    "pnpm",
    "exec",
    "tailwindcss-language-server",
    "--stdio",
  },
  filetypes = {
    "astro",
    "html",
    "css",
    "scss",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "vue",
    "svelte",
  },
  root_markers = {
    "pnpm-lock.yaml",
    "tailwind.config.js",
    "tailwind.config.ts",
    "package.json",
    ".git",
  },
})

vim.lsp.enable({
  "astro",
  "pyright",
  "lua_ls",
  "bashls",
  "ts_ls",
  "tinymist",
  "nixd",
  "rust_analyzer",
  "tailwindcss",
})

-- Buffer-local maps only exist when an LSP attaches.
api.nvim_create_autocmd("LspAttach", {
  group = general,
  callback = function(args)
    local buf = args.buf

    local function lmap(lhs, rhs, desc, modes)
      map(modes or "n", lhs, rhs, {
        buffer = buf,
        desc = desc,
        silent = true,
      })
    end

    lmap("K", vim.lsp.buf.hover, "Hover")
    lmap("gd", vim.lsp.buf.definition, "Go to definition")
    lmap("gD", vim.lsp.buf.declaration, "Go to declaration")
    lmap("gr", vim.lsp.buf.references, "References")
    lmap("gi", vim.lsp.buf.implementation, "Implementation")
    lmap("<leader>rn", vim.lsp.buf.rename, "Rename")
    lmap(
      "<leader>ca",
      vim.lsp.buf.code_action,
      "Code action",
      { "n", "v" }
    )
    lmap("<leader>ds", vim.lsp.buf.document_symbol, "Document symbols")
    lmap("<leader>ws", vim.lsp.buf.workspace_symbol, "Workspace symbols")

    if vim.lsp.inlay_hint then
      vim.lsp.inlay_hint.enable(true, { bufnr = buf })
    end
  end,
})

-- Diagnostic navigation.
map("n", "]g", function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Next diagnostic" })

map("n", "[g", function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Previous diagnostic" })

-- ========================================
-- TREESITTER (main branch API)
-- ========================================

local ts_languages = {
  "bash",
  "dockerfile",
  "git_config",
  "git_rebase",
  "gitattributes",
  "gitcommit",
  "gitignore",
  "json",
  "toml",
  "yaml",
  "lua",
  "make",
  "markdown",
  "markdown_inline",
  "python",
  "sql",
  "vim",
  "vimdoc",
}

require("nvim-treesitter").install(ts_languages)

api.nvim_create_autocmd("FileType", {
  group = general,
  pattern = {
    "bash",
    "sh",
    "dockerfile",
    "gitconfig",
    "gitcommit",
    "gitrebase",
    "json",
    "toml",
    "yaml",
    "lua",
    "make",
    "markdown",
    "python",
    "sql",
    "vim",
    "vimdoc",
  },
  callback = function(args)
    -- Parser installation is asynchronous. A missing parser should not
    -- prevent the buffer from opening.
    pcall(vim.treesitter.start, args.buf)
  end,
})

require("treesitter-context").setup({
  max_lines = 3,
  multiline_threshold = 1,
  separator = "-",
  min_window_height = 20,
  line_numbers = true,
})

-- ========================================
-- COMPLETION
-- ========================================

local cmp = require("cmp")
local luasnip = require("luasnip")

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  mapping = cmp.mapping.preset.insert({
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-p>"] = cmp.mapping.select_prev_item(),

    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),

    ["<CR>"] = cmp.mapping.confirm({
      select = false,
      behavior = cmp.ConfirmBehavior.Replace,
    }),

    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),

  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "path" },
    { name = "buffer", keyword_length = 3 },
  }),

  completion = {
    autocomplete = { cmp.TriggerEvent.TextChanged },
  },

  experimental = {
    ghost_text = false,
  },
})

-- Dadbod SQL completion through nvim-cmp.
cmp.setup.filetype({ "sql" }, {
  sources = cmp.config.sources({
    { name = "vim-dadbod-completion" },
    { name = "buffer", keyword_length = 3 },
  }),
})

-- ========================================
-- PLUGIN SETUP
-- ========================================

require("which-key").setup({})

require("bufferline").setup({})

require("nvim-highlight-colors").setup({
  render = "virtual",
  virtual_symbol = "■",
  virtual_symbol_suffix = "",
})

require("oil").setup({
  delete_to_trash = true,
  skip_confirm_for_simple_edits = true,
  columns = { "icon", "size", "mtime" },
})

require("nvim-autopairs").setup({})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on(
  "confirm_done",
  cmp_autopairs.on_confirm_done({ map_char = { tex = "" } })
)

require("Comment").setup({})

local gs = require("gitsigns")
gs.setup({
  signs = {
    add = { text = "+" },
    change = { text = "~" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
  },
})

require("ibl").setup({
  indent = { char = "│" },
  scope = { enabled = false },
})

require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "auto",
    component_separators = "|",
    section_separators = "",
  },
})

vim.g.db_ui_use_nerd_fonts = 1
vim.g.db_ui_auto_executable_table_helpers = 1

-- ========================================
-- KEYMAPS
-- ========================================

-- Files and directories.
map("n", "-", "<cmd>Oil<CR>", { desc = "Open parent directory" })

-- Search and navigation.
map("n", "<leader>ff", function()
  require("fzf-lua").files()
end, { desc = "Find files" })

map("n", "<leader>fg", function()
  require("fzf-lua").live_grep()
end, { desc = "Live grep" })

map("n", "<leader>fb", function()
  require("fzf-lua").buffers()
end, { desc = "Find buffers" })

map("n", "<leader>fh", function()
  require("fzf-lua").help_tags()
end, { desc = "Help tags" })

map("n", "<leader>fr", function()
  require("fzf-lua").resume()
end, { desc = "Resume fzf-lua" })

map("n", "<leader>f;", function()
  require("fzf-lua").commands()
end, { desc = "Commands" })

-- Grep current working directory and populate quickfix.
map("n", "<leader>g", function()
  local query = vim.fn.input("Grep > ", vim.fn.expand("<cword>"))
  if query == "" then
    return
  end

  local cmd = {
    "rg",
    "--vimgrep",
    "--smart-case",
    "--hidden",
    "--glob", "!.git",
    "--glob", "!node_modules",
    "--",
    query,
  }

  local results = vim.fn.systemlist(
    vim.iter(cmd):map(vim.fn.shellescape):join(" ")
  )

  local exit_code = vim.v.shell_error

  if exit_code > 1 then
    notify("Ripgrep failed: " .. table.concat(results, "\n"), vim.log.levels.ERROR)
    return
  end

  if #results == 0 then
    notify("No matches found")
    return
  end

  vim.fn.setqflist({}, " ", {
    title = "Grep: " .. query,
    lines = results,
    efm = "%f:%l:%c:%m",
  })

  vim.cmd.copen()
end, { desc = "Ripgrep search" })

-- Buffers.
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })
map("n", "]b", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "[b", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
map("n", "<leader>bl", "<cmd>blast<CR>", { desc = "Last buffer" })
map("n", "<leader>bf", "<cmd>bfirst<CR>", { desc = "First buffer" })

for i = 1, 9 do
  map("n", "<leader>" .. i, function()
    local buffers = vim.fn.getbufinfo({ buflisted = 1 })
    local target = buffers[i]

    if target then
      vim.cmd.buffer(target.bufnr)
    else
      notify("No listed buffer at position " .. i, vim.log.levels.WARN)
    end
  end, { desc = "Buffer " .. i })
end

-- Search highlighting.
map("n", "<C-c>", "<cmd>nohlsearch<CR>", {
  desc = "Clear search highlighting",
  silent = true,
})

-- Indentation and visual line movement.
map("x", ">", ">gv", { desc = "Indent and keep selection" })
map("x", "<", "<gv", { desc = "Unindent and keep selection" })
map("x", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("x", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Git hunks.
map("n", "]h", gs.next_hunk, { desc = "Next hunk" })
map("n", "[h", gs.prev_hunk, { desc = "Previous hunk" })
map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage hunk" })
map("v", "<leader>hs", function()
  gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
end, { desc = "Stage selection" })
map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset hunk" })
map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })

-- Fix spelling at the previous misspelled word.
map("i", "<C-l>", "<C-g>u<Esc>[s1z=`]a<C-g>u", {
  desc = "Fix spelling",
  silent = true,
})

-- Window navigation.
map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window up" })
map("n", "<C-l>", "<C-w>l", { desc = "Window right" })

-- Replace a literal string throughout the current file.
map("n", "<leader>sr", function()
  local old = vim.fn.input("Find literal: ")
  if old == "" then
    return
  end

  local new = vim.fn.input("Replace with: ")
  local cmd = "%s/" .. escape_pattern(old) .. "/"
    .. escape_replacement(new) .. "/g"

  local ok, err = pcall(vim.cmd, cmd)
  if not ok then
    notify(tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Replace in file" })

-- Save.
map({ "n", "i", "x" }, "<C-s>", "<cmd>write<CR>", {
  desc = "Save",
})

-- Run current Python file in a terminal.
map("n", "<leader><F8>", function()
  if vim.bo.filetype ~= "python" then
    notify("Current buffer is not Python", vim.log.levels.WARN)
    return
  end

  vim.cmd("split | terminal python3 " .. vim.fn.shellescape(vim.fn.expand("%:p")))
end, { desc = "Run Python file" })

-- Dadbod UI.
map("n", "<leader>db", "<cmd>DBUI<CR>", { desc = "Open DB UI" })
map("n", "<leader>dt", "<cmd>DBUIToggle<CR>", { desc = "Toggle DB UI" })

-- Optional formatting.
map("n", "<leader>lf", function()
  vim.lsp.buf.format({ async = true })
end, { desc = "Format buffer" })

-- oil-nvim mapper
vim.api.nvim_create_autocmd("FileType", {
  pattern = "oil",
  callback = function(ev)
    vim.keymap.set("n", "\\", function()
      require("which-key").show({
        buf = ev.buf,
      })
    end, {
    buffer = ev.buf,
    desc = "Show Oil keybindings",
  })
end,
})
