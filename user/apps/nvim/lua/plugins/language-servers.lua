return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("nix").setup_nix_ld()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            local cfg = require("mason-lspconfig")
            cfg.setup({
                ensure_installed = {
                    "biome",
                    "docker_compose_language_service",
                    "dockerls",
                    "lua_ls",
                    "rust_analyzer",
                    "tailwindcss",
                    "tsserver",
                    "nil_ls"
                    -- "nix"
                },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            local cfg = require("lspconfig")
            cfg.lua_ls.setup({ capabilities = capabilities })
            cfg.biome.setup({ capabilities = capabilities })
            cfg.tsserver.setup({ capabilities = capabilities })
            cfg.tailwindcss.setup({ capabilities = capabilities })

            -- Not working?
            -- cfg.nix_ls.setup({ capabilities = capabilities })
            local lsc = require("lspconfig.configs")
            if not lsc.nix_ls then
                lsc.nix_ls = {
                    default_config = {
                        cmd = { "nil" },
                        root_dir = cfg.util.root_pattern(".git"),
                        filetypes = { "nix" }
                    }
                }
            end

            cfg.nix_ls.setup({ capabilities = capabilities })


            vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
            vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
        end,
    },
}
