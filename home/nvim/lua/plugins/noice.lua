--------------------------------------------------------------------------------
--                             plugins/noice.lua                              --
--         Configures noice.nvim, which improves Neovim's default UI.         --
--------------------------------------------------------------------------------

local M = {}

function M.configure()
    local noice = require("noice")

    noice.setup({
        lsp = {
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
            },
        },
        presets = {
            bottom_search = false,
            command_palette = true,
            long_message_to_split = true,
            inc_rename = false,
            lsp_doc_border = false,
        },
        routes = {
            {
                -- Disables the "file written" notification.
                filter = {
                    event = "msg_show",
                    any = {
                        { find = "written" },
                    },
                },
                opts = { skip = true },
            },
        },
    })
end

return M
