--------------------------------------------------------------------------------
--                           plugins/dbee.lua                                 --
--     Configues nvim-dbee, a plugin to connect to and browser database.      --
--------------------------------------------------------------------------------

local M = {}

function M.configure()
    local dbee = require("dbee")

    dbee.setup()
    vim.api.nvim_create_user_command("Db", ":lua require('dbee').open()", {})
end


return M
