--------------------------------------------------------------------------------
--                               lsp/lua_ls.lua                               --
--                      Configures lspconfig for Lua.                         --
--------------------------------------------------------------------------------

return {
    cmd = { "lua-language-server" },
    filetype = { "lua" },
    root_markers = { ".luarc.json", ".luarc.jsonc" },
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            signatureHelp = {
                enabled = true,
            },
        },
    },
}
