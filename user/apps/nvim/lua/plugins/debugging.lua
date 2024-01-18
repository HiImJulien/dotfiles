return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "leoluz/nvim-dap-go",
        "rcarriga/nvim-dap-ui",
    },
    config = function()
        local dap = require("dap")
        local ui = require("dapui")

        ui.setup()

        dap.listeners.before.attach.dapui_config = function()
            ui.open()
        end

        dap.listeners.before.launch.dapui_config = function()
            ui.open()
        end

        dap.listeners.before.event_terminated.dapui_config = function()
            ui.close()
        end

        dap.listeners.before.event_exited.dapui_config = function()
            ui.close()
        end

        vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, {})
        vim.keymap.set("n", "<Leader>dc", dap.continue, {})
        vim.keymap.set("n", "<Leader>dx", dap.terminate, {})
        vim.keymap.set("n", "<Leader>do", dap.step_over, {})
    end,
}
