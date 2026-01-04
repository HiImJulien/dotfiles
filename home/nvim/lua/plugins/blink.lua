--------------------------------------------------------------------------------
--                             plugins/blink.lua                              --
--        Configures blink.cmp providing support for auto-completions.        --
--------------------------------------------------------------------------------

local M = {}

function M.configure()
    local blink = require("blink.cmp")

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    local opts = {
        keymap = {
            preset = "default",
            ["<C-Space>"] = { "accept" },
            ["<CR>"] = { "accept", "fallback" },
            ["<C-e>"] = { "cancel" },

            -- Missing keymaps?
            -- <C-b> scroll_docs(-4)
            -- <C-f> scroll_docs(4)
        },
        appearance = {
            nerd_font_variant = "mono",
        },
        completion = {},
        sources = {
            default = {
                "lsp",
                "path",
                "snippets",
                "buffer",
            },
        },
    }

    blink.setup(opts)
end

return M
