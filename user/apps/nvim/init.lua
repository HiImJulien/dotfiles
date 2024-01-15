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

    local telescope = require("telescope")
    telescope.setup {
        extensions = {
            ["ui-select"] = {
                require("telescope.themes").get_dropdown {}
            }
        }
    }

    -- Reload reevalute the plugin
    ---@diagnostic disable-next-line: redefined-local
    local telescope = require("telescope")
    telescope.load_extension("ui-select")
end

-- Setup treesitter
do
    local cfg = require("nvim-treesitter.configs")
    cfg.setup {
        highlight = { enable = true },
        indent = { enable = true }
    }
end


local function setup_nix_ld()
    local job = require("plenary.job")
    local cmd = "nix"
    local args = {
        "eval",
        "--impure",
        "--raw",
        "--expr",
        'let pkgs = import <nixpkgs> {}; NIX_LD = pkgs.lib.fileContents "${pkgs.stdenv.cc}/nix-support/dynamic-linker"; in NIX_LD'
    }

    local proc = job:new({
        command = cmd,
        args = args,
        enable_recording = true,
    })

    proc:sync()
    vim.env.NIX_LD = vim.trim(proc:result()[1])
end


-- Setup mason
do
    setup_nix_ld()

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

    vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
end

