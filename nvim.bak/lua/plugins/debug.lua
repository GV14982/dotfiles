return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        dependencies = { "nvim-neotest/nvim-nio" },
      },
      'leoluz/nvim-dap-go',
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      require('dap-go').setup()
      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "~/.local/share/nvim/mason/bin/js-debug-adapter",
          args = "${port}"
        }
      }
      dap.configurations["pwa-node"] = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          cwd = "${workspaceFolder}",
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach",
          processId = require('dap.utils').pick_process,
          cwd = "${workspaceFolder}",
        }
      }
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end

      vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'String', linehl = '', numhl = '' })
      vim.fn.sign_define('DapLogPoint', { text = '', texthl = 'Question', linehl = '', numhl = '' })
      vim.fn.sign_define('DapStopped', { text = '', texthl = '', linehl = '', numhl = '' })
      vim.fn.sign_define('DapBreakpointCondition', { text = '', texthl = 'Type', linehl = '', numhl = '' })
      vim.fn.sign_define('DapBreakpointRejected', { text = '', texthl = 'Error', linehl = '', numhl = '' })

      vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, { desc = "[T]oggle breakpoint" })
      vim.keymap.set("n", "<Leader>dc", dap.continue, { desc = "[C]ontinue" })
      vim.keymap.set("n", "<Leader>dd", dap.disconnect, { desc = "[D]isconnect" })
      vim.keymap.set("n", "<Leader>dp", dap.pause, { desc = "[P]ause" })
      vim.keymap.set("n", "<Leader>dr", dap.repl.toggle, { desc = "Toggle [r]epl" })
      vim.keymap.set('n', '<Leader>dl',
        function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end,
        { desc = "Toggle [l]ogpoint" })
      vim.keymap.set("n", "<Leader>dsi", dap.step_into, { desc = "Step [i]nto" })
      vim.keymap.set("n", "<Leader>dsb", dap.step_back, { desc = "Step [b]ack" })
      vim.keymap.set("n", "<Leader>dso", dap.step_out, { desc = "Step [o]ut" })
      vim.keymap.set("n", "<Leader>dsv", dap.step_over, { desc = "Step o[v]er" })
      vim.keymap.set("n", "<Leader>dut", dapui.toggle, { desc = "[T]oggle" })
    end
  }
}
