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
        keympas = true,
    })
end

return M
