return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
    },
    config = function()
        local telescope = require("telescope")
        telescope.setup({
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown({}),
                },
                ["file_browser"] = {
                    hijack_netrw = true,
                }
            },
        })

        -- Reload reevalute the plugin
        telescope = require("telescope")
        telescope.load_extension("ui-select")
        telescope.load_extension("file_browser")

        local builtin = require("telescope.builtin")
        local fb = require("telescope").extensions.file_browser

        vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
        vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
        vim.keymap.set("n", "<leader>fb", fb.file_browser, {})
    end,
}
