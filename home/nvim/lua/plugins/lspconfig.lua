--------------------------------------------------------------------------------
--                           plugins/lspconfig.lua                            --
--         Configures lspconfig to manage and start language servers.         --
--------------------------------------------------------------------------------

local M = {}

local function on_attach(_, bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }

    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "lr", vim.lsp.buf.rename, opts)
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
end

function M.configure()
    local lspconfig = require("lspconfig")
    local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()

    local opts = { on_attach = on_attach, capabilities = cmp_capabilities }
    lspconfig.astro.setup(opts)
    lspconfig.gopls.setup(opts)
    lspconfig.lua_ls.setup(opts)
    -- lspconfig.phpactor.setup(opts)
    lspconfig.intelephense.setup(opts)
    lspconfig.pyright.setup(opts)
    lspconfig.rust_analyzer.setup(opts)
    lspconfig.svelte.setup(opts)
    lspconfig.tailwindcss.setup(opts)
    lspconfig.tsserver.setup(opts)
    lspconfig.eslint.setup(opts)
    lspconfig.tinymist.setup(opts)

    lspconfig.jsonls.setup({
        -- It has a different name on nixOS.
        -- cmd = { "vscode-json-languageserver", "--stdio" },
        on_attach = on_attach,
        capabilities = cmp_capabilities,
        settings = {
            json = {
                schemas = require("schemastore").json.schemas(),
                validate = { enable = true },
            },
        },
    })

    -- Disable since this is handled by lsp_lines.
    -- Must be configured after lspconfig.
    vim.diagnostic.config({
        virtual_text = false,
    })

    vim.keymap.set(
        "",
        "<Leader>l",
        require("lsp_lines").toggle,
        { desc = "Toggle diagnostic lines" }
    )

    require("lsp_lines").setup()
end

return M
