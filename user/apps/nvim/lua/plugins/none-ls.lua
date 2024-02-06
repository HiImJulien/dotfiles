return {
    "nvimtools/none-ls.nvim",
    config = function()
        local null = require("null-ls")
        null.setup({
            sources = {
                null.builtins.formatting.stylua,
                null.builtins.formatting.biome,
                null.builtins.formatting.nixfmt,
            },
        })

        vim.keymap.set("n", "<leader>F", vim.lsp.buf.format, {})
    end,
}
