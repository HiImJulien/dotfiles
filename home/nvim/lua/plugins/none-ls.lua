--------------------------------------------------------------------------------
--                            plugins/none-ls.lua                             --
--     Configures the none-ls plugin, used to run formatters and linters.     --
--------------------------------------------------------------------------------

local M = {}

function M.configure()
    -- null-ls was abandoned by it's author due to a lack of time.
    -- none-ls is a drop-in replacement, thus providing a module
    -- with the same name as the aforementioned plugin.
    local none_ls = require("null-ls")

    none_ls.setup({
        sources = {
            none_ls.builtins.formatting.stylua,
            none_ls.builtins.formatting.prettier.with({
                extra_filetypes = { "svelte", "astro", "mdx", "htmldjango" },
            }),
            none_ls.builtins.formatting.golines,
            none_ls.builtins.formatting.black,
            none_ls.builtins.formatting.pint
        },
    })

    vim.keymap.set("n", "<leader>F", vim.lsp.buf.format, {})
end

return M
