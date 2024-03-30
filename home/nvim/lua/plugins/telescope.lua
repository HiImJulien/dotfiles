--------------------------------------------------------------------------------
--                           plugins/telescope.lua                            --
--        Configures telescope.nvim and its extension which provide a         --
--            fuzzy file finder, live grepper and a file browser.             --
--------------------------------------------------------------------------------

local M = {}

function M.configure()
    local telescope = require("telescope")
    local themes = require("telescope.themes")
    telescope.setup({
        extensions = {
            ["ui-select"] = { themes.get_dropdown({}) },
            ["file_browser"] = { hijack_netrw = true },
        },
    })

    telescope.load_extension("ui-select")
    telescope.load_extension("file_browser")

    local builtin = require("telescope.builtin")
    local file_browser = require("telescope").extensions.file_browser
    vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
    vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
    vim.keymap.set("n", "<leader>fb", file_browser.file_browser, {})
end

return M
