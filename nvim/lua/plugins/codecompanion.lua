return {
  {
    "olimorris/codecompanion.nvim",
    config = true,
    opts = {
      strategies = {
        chat = {
          adapter = "copilot",
          model = "claude-sonnet-4",
          opts = {
            ---Decorate the user message before it's sent to the LLM
            ---@param message string
            ---@param adapter CodeCompanion.Adapter
            ---@param context table
            ---@return string
            prompt_decorator = function(message, adapter, context)
              return string.format([[<prompt>%s</prompt>]], message)
            end,
          },
        },
        inline = {
          adapter = "copilot",
        },
        cmd = {
          adapter = "copilot",
        },
      },
      display = {
        inline = {
          layout = "vertical",
        },
        diff = {
          enabled = true,
          layout = "vertical",
          provider = "mini_diff",
        },
      },
      extensions = {
        mcphub = {
          callback = "mcphub.extensions.codecompanion",
          opts = {
            show_result_in_chat = true, -- Show the mcp tool result in the chat buffer
            make_vars = true, -- make chat #variables from MCP server resources
            make_slash_commands = true, -- make /slash_commands from MCP server prompts
          },
        },
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "echasnovski/mini.nvim",
      "j-hui/fidget.nvim",
      {
        "ravitemer/mcphub.nvim",
        dependencies = {
          "nvim-lua/plenary.nvim", -- Required for Job and HTTP requests
        },
        cmd = "MCPHub", -- lazy load by default
        build = "npm install -g mcp-hub@latest", -- Installs required mcp-hub npm module
      },
      "zbirenbaum/copilot.lua",
    },
  },
}
