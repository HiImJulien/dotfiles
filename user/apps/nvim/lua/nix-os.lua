-- This module provides minor patches nixOS
-- to ensure the correct functioning of
-- plugins.

local M = {}

--- Checks whether the file at the specified path is a ELF binary or not.
---@param file string Path to the binary to test.
local function is_elf_binary(file)
    -- TODO:
end

--- Patches the ELF binary at the specified path to use the proper link paths.
---@param file string Path to the binary to patch.
local function patch_elf_binary(file)
    -- TODO:
end


--- Sets up the env var "NIX_LD".
-- Sets up the env var "NIX_LD", which instructs the nixOS application launcher
-- to use another dynamic linker. This allows for arbitrary binaries, downloaded
-- by plugins, to be run on nixOS.
--
---@deprecated
function M.setup_nix_ld()
    local job = require("plenary.job")
    local cmd = "nix"
    local args = {
        "eval",
        "--impure",
        "--raw",
        "--expr",
        'let pkgs = import <nixpkgs> {}; NIX_LD = pkgs.lib.fileContents "${pkgs.stdenv.cc}/nix-support/dynamic-linker"; in NIX_LD',
    }

    local proc = job:new({
        command = cmd,
        args = args,
        enable_recording = true,
    })

    proc:sync()
    vim.env.NIX_LD = vim.trim(proc:result()[1])
end

--- Patches executable binaries installed by mason.
-- Mason installs binaries, which do not work out-of-the-box
-- on nixOS, since the linker entries reference paths that
-- do not match with the OS store mechanism.
--
-- The binaries need to be patched to use the proper linker upon
-- install.
--
function M.on_mason_install_patch_binaries()
    local mason_registry = require("mason-registry")
    mason_registry:on("package:install:success", function(package)
        package:get_receipt():if_present(function(receipt)
            for bin, rel_path in pairs(receipt.links.bin) do
                local bin_abs_path = package:get_install_path() .. "/" .. rel_path
            end
        end)
    end)
end

return M
