--------------------------------------------------------------------------------
--                           lsp/rust_analyzer.lua                            --
--                     Configures rust_analyzer for Rust.                     --
--------------------------------------------------------------------------------

return {
    cmd = { "rust-analyzer" },
    settings = {
        ["rust-analyzer"] = {
            files = { watcher = "server" },
            cargo = { targetDir = true },
            check = { command = "clippy" },
            inlayHints = {
                bindingModeHints = { enabled = true },
                closureCaptureHints = { enabled = true },
                closureReturnTypeHints = { enable = "always" },
                maxLength = 100,
            },
            rustc = { source = "discover" },
        },
    },
    root_markers = {
        "Cargo.toml",
    },
}
