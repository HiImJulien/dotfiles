local M = {}

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

return M
