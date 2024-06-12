--------------------------------------------------------------------------------
--                              plugins/init.lua                              --
--           This module loads the configurations for each plugin.            --
--------------------------------------------------------------------------------

local function load_plugin(name)
    local path = "plugins." .. name
    local plugin = require(path)
    plugin.configure()
end

load_plugin("catppuccin")
load_plugin("cmp")
load_plugin("dbee")
load_plugin("lspconfig")
load_plugin("noice")
load_plugin("none-ls")
load_plugin("telescope")
load_plugin("treesitter")
