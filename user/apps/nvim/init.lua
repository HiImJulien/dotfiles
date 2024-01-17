-- General preferences
vim.o.number = true
vim.o.relativenumber = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.smarttab = true
vim.o.colorcolumn = 80
vim.g.mapleader = " "

vim.cmd.colorscheme = "catppuccin"

-- Setup telescope
do
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
    vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})

    local telescope = require("telescope")
    telescope.setup({
        extensions = {
            ["ui-select"] = {
                require("telescope.themes").get_dropdown({}),
            },
        },
    })

    -- Reload reevalute the plugin
    telescope = require("telescope")
    telescope.load_extension("ui-select")
end

-- Setup treesitter
do
    local cfg = require("nvim-treesitter.configs")
    cfg.setup({
        highlight = { enable = true },
        indent = { enable = true },
    })
end

local function setup_nix_ld()
    local job = require("plenary.job")
    local cmd = "nix"
    local args = {
        "eval",
        "--impure",
        "--raw",
        "--expr",
        'let pkgs = import <nixpkgs> {}; NIX_LD = pkgs.lib.fileContents "${pkgs.stdenv.cc}/nix-support/dynamic-linker"; in NIX_LD',
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
    cfg.setup({
        ensure_installed = {
            "biome",
            "docker_compose_language_service",
            "dockerls",
            "lua_ls",
            "rust_analyzer",
            "tailwindcss",
            -- "nix"
        },
    })
end

-- Setup lsp-config
do
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    local cfg = require("lspconfig")
    cfg.lua_ls.setup({ capabilities = capabilities })

    vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
end

-- Setup none-ls (maintained fork of null-ls)
do
    local null_ls = require("null-ls")
    null_ls.setup({
        sources = {
            null_ls.builtins.formatting.stylua,
        },
    })

    vim.keymap.set("n", "<leader>F", vim.lsp.buf.format, {})
end

-- Setup nvm cmp
do
    local cmp = require("cmp")
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
        snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body)
            end,
        },
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
            ["<C-b>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<C-e>"] = cmp.mapping.abort(),
            ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
            { name = "nvim_lsp" },
            { name = "luasnip" },
        }, {
            { name = "buffer" },
        }),
    })
end

-- Setup DAP
do
    local dap = require("dap")
    local ui = require("dapui")

    ui.setup()

    dap.listeners.before.attach.dapui_config = function()
        ui.open()
    end

    dap.listeners.before.launch.dapui_config = function()
        ui.open()
    end

    dap.listeners.before.event_terminated.dapui_config = function()
        ui.close()
    end

    dap.listeners.before.event_exited.dapui_config = function()
        ui.close()
    end

    vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, {})
    vim.keymap.set("n", "<Leader>dc", dap.continue, {})
    vim.keymap.set("n", "<Leader>dx", dap.terminate, {})
    vim.keymap.set("n", "<Leader>do", dap.step_over, {})
end
