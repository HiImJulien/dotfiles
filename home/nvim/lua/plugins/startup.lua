--------------------------------------------------------------------------------
--                           plugins/startup.lua                              --
--       Configures startup.nvim to provide me with a custom and slick        --
--                              start up screen.                              --
--------------------------------------------------------------------------------

local M = {}

function M.configure()
    local startup = require("startup")

    startup.setup({
        theme = "dashboard"
    })
end

return M
