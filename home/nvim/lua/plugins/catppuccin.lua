--------------------------------------------------------------------------------
--                           plugins/catppuccin.lua                           --
--                   Configures the catppuccin colorscheme.                   --
--------------------------------------------------------------------------------

local M = {}

function M.configure()
    vim.cmd.colorscheme("catppuccin")
end

return M
