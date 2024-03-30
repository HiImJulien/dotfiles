--------------------------------------------------------------------------------
--                                options.lua                                 --
--     Sets global options which may later be overwritten by plugins etc.     --
--------------------------------------------------------------------------------

-- Set the leader to <SPACE>
vim.g.mapleader       = " "

-- Enable (relative) line numbers 
vim.o.number          = true
vim.o.relativenumber  = true

-- Set general editing settings; may be overwritten by .editorconfig settings.
vim.o.shiftwidth      = 4
vim.o.tabstop         = 4
vim.o.expandtab       = true
vim.o.smarttab        = true
vim.o.colorcolumn     = "80"

