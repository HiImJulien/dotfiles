--------------------------------------------------------------------------------
--                              plugins/init.lua                              --
--           This module loads the configurations for each plugin.            --
--------------------------------------------------------------------------------

local function load_plugin(name)
    local path = "plugins." .. name
    local plugin = require(path)
    plugin.configure()
end

-- Not really used lately:
-- load_plugin("startup")
-- load_plugin("dbee")
-- load_plugin("laravel")

load_plugin("blink")
load_plugin("catppuccin")
load_plugin("noice")
load_plugin("none-ls")
load_plugin("telescope")

-- API seems to have changed.
-- load_plugin("treesitter")
-- load_plugin("lspconfig")
