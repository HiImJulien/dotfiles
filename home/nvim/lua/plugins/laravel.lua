--------------------------------------------------------------------------------
--                            plugins/laravel.lua                             --
--    Configures laravel.nvim by Adib Hanna, which provides utilities for     --
--                            Laravel development.                            --
--------------------------------------------------------------------------------

local M = {}

function M.configure()
    local laravel = require("laravel")

    laravel.setup({
        notifications = true,
        debug = false,
        keymaps = true,
        sail = {
            enabled = false,
        }
    })
end

return M
