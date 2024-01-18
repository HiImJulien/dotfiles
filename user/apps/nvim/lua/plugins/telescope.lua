return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
        "jonarrien/telescope-cmdline.nvim",
    },
    config = function()
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
        telescope.load_extension("cmdline")

        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
        vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
        vim.keymap.set("n", "<C-p>", "<Cmd>Telescope cmdline<CR>", {})
    end,
}
