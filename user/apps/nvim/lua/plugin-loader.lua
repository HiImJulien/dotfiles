-- This module implements a function to setup
-- and configure plugins.
--
-- If the environment is NOT managed by home-manager,
-- then the function bootstraps lazy.nvim and uses it
-- to setup functions.
-- Otherwise it emulates lazy.nvim setup mechanism
-- and loads the configurations from the directory
-- plugin.
--

local M = {}

local function bootstrap_lazy()
    local path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not vim.loop.fs_stat(path) then
        vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable",
            path,
        })
    end

    vim.opt.rtp:prepend(path)
end

local function load_plugins()
    local config_dir = vim.fn.stdpath("config")
    local files = vim.fn.readdir(config_dir .. "/lua/plugins", [[v:val =~ '\.lua$']])
    for _, file in ipairs(files) do
        local m = require("plugins/" .. file:gsub("%.lua$", ""))

        -- TODO: This function is wonky at best; this needs to properly reworked.
        for key, value in pairs(m) do
            if key == "config" then
                value()
            end

            if type(value) == "table" then
                if value.config ~= nil then
                    value.config()
                end
            end
        end
    end
end

function M.detect_home_manager()
    local val = vim.g.home_manager
    return val ~= nil and val == true
end

function M.setup()
    if not M.detect_home_manager() then
        bootstrap_lazy()
    else
        load_plugins()
    end
end

return M
