
-- General preferences
vim.o.number        = true
vim.o.relativenumber= true
vim.o.shiftwidth    = 4
vim.o.tabstop       = 4
vim.o.expandtab     = true
vim.o.smarttab      = true
vim.o.colorcolumn   = 80
vim.g.mapleader     = " "

-- Bootstrap lazy.nvim if it's not present anymore.
local function bootstrap()
    local path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not vim.loop.fs_stat(path) then
        vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable",
            path
        })
    end

    vim.opt.rtp:prepend(path)
end

bootstrap()

require("lazy").setup("plugins")
