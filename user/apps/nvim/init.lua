-- General preferences
vim.o.number        = true
vim.o.relativenumber= true
vim.o.shiftwidth    = 4
vim.o.tabstop       = 4
vim.o.expandtab     = true
vim.o.smarttab      = true
vim.o.colorcolumn   = 80
vim.g.mapleader     = " "

vim.cmd.colorscheme = "catppuccin"

-- Setup telescope
do
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
    vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
end

-- Setup treesitter
do
    local cfg = require("nvim-treesitter.configs")
    cfg.setup {
        highlight = { enable = true },
        indent = { enable = true }
    }
end

-- Setup mason
do
    local mason = require("mason")
    mason.setup()
end

-- Setup mason-lspconfig
do
    local cfg = require("mason-lspconfig")
    cfg.setup {
        ensure_installed = {
            "biome",
            "docker_compose_language_service",
            "dockerls",
            "lua_ls",
            "rust_analyzer",
            "tailwindcss"
        }
    }
end

-- Setup lsp-config
do
    local cfg = require("lspconfig")
    cfg.lua_ls.setup({})
end
