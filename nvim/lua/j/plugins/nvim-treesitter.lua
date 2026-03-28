return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local ok, configs = pcall(require, "nvim-treesitter.configs")
        if not ok then return end
        configs.setup({
            ensure_installed = { "c", "lua", "vim", "vimdoc", "javascript", "html", "css", "astro", "python", "http", "json", "typescript" },
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true },
        })
    end,
}
