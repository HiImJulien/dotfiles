--------------------------------------------------------------------------------
--                           plugins/treesitter.lua                           --
--    Configures treesitter.nvim, which implements incremental parsing for    --
--                       improved syntax highlighting.                        --
--------------------------------------------------------------------------------

local M = {}

function M.configure()
    local treesitter = require("nvim-treesitter.configs")
    treesitter.setup({
        highlight = { enable = true },
        indent = { enable = true },
    })

    print("Loaded treesitter")
end

return M
