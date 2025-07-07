return {
  -- {
  --   "yetone/avante.nvim",
  --   event = "VeryLazy",
  --   version = false, -- Never set this value to "*"! Never!
  --   build = "make",
  --   opts = {
  --     provider = "openai",
  --     behaviour = {
  --       enable_claude_text_editor_tool_mode = true,
  --     },
  --     providers = {
  --       ---@type AvanteProvider
  --       lmstudio = {
  --         __inherited_from = "openai",
  --         api_key_name = "",
  --         endpoint = "http://localhost:1234/v1",
  --         model = "devstral-small-2505-mlx",
  --         max_tokens = 8192,
  --       },
  --     },
  --     claude = {
  --       api_key_name = "cmd:cat /Users/gvqz/.secrets/anthropic_api_key.txt",
  --       model = "claude-3-5-haiku-20241022",
  --       max_tokens = 8192,
  --     },
  --     openai = {
  --       endpoint = "https://api.openai.com/v1",
  --       model = "gpt-4.1-mini",       -- your desired model (or use gpt-4o, etc.)
  --       timeout = 30000,              -- Timeout in milliseconds, increase this for reasoning models
  --       temperature = 0,
  --       max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
  --       api_key_name = "cmd:cat /Users/gvqz/.secrets/openai_api_key.txt"
  --     },
  --     ollama = {
  --       model = "qwen2.5-coder:14b"
  --     },
  --     rag_service = {
  --       enabled = false,                     -- Enables the RAG service
  --       host_mount = os.getenv("HOME"),      -- Host mount path for the rag service
  --       provider = "ollama",                 -- The provider to use for RAG service (e.g. openai or ollama)
  --       llm_model = "qwen2.5-coder:14b",     -- The LLM model to use for RAG service
  --       endpoint = "http://localhost:11434", -- The API endpoint for RAG service
  --     },
  --     web_search_engine = {
  --       provider = "brave", -- tavily, serpapi, searchapi, google, kagi, brave, or searxng
  --     },
  --     disabled_tools = {
  --       "list_files",
  --       "search_files",
  --       "read_file",
  --       "create_file",
  --       "rename_file",
  --       "delete_file",
  --       "create_dir",
  --       "rename_dir",
  --       "delete_dir",
  --       "bash",
  --     },
  --     -- other config
  --     -- The system_prompt type supports both a string and a function that returns a string. Using a function here allows dynamically updating the prompt with mcphub
  --     system_prompt = function()
  --       local hub = require("mcphub").get_hub_instance()
  --       return hub:get_active_servers_prompt()
  --     end,
  --     -- The custom_tools type supports both a list and a function that returns a list. Using a function here prevents requiring mcphub before it's loaded
  --     custom_tools = function()
  --       return {
  --         require("mcphub.extensions.avante").mcp_tool(),
  --       }
  --     end,
  --   },

  --   dependencies = {
  --     "nvim-treesitter/nvim-treesitter",
  --     "stevearc/dressing.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "MunifTanjim/nui.nvim",
  --     --- The below dependencies are optional,
  --     "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
  --     "hrsh7th/nvim-cmp",              -- autocompletion for avante commands and mentions
  --     "nvim-tree/nvim-web-devicons",   -- or echasnovski/mini.icons
  --     {
  --       -- Make sure to set this up properly if you have lazy=true
  --       'MeanderingProgrammer/render-markdown.nvim',
  --       opts = {
  --         file_types = { "markdown", "Avante" },
  --       },
  --       ft = { "markdown", "Avante" },
  --     },
  --
  --     "ravitemer/mcphub.nvim",
  --   },
  -- },
  {
    "olimorris/codecompanion.nvim",
    config = true,
    opts = {
      adapters = {
        gemma12b = function()
          return require("codecompanion.adapters").extend("ollama", {
            name = "gemma12b",
            schema = {
              model = {
                default = "gemma3:8b"
              },
            },
          })
        end,
        qwencoder = function()
          return require("codecompanion.adapters").extend("ollama", {
            name = "qwencoder",
            schema = {
              model = {
                default = "qwen2.5-coder:7b"
              },
            },
          })
        end,
        qwencodermlx = function()
          return require("codecompanion.adapters").extend("openai_compatible", {
            name = "qwencodermlx",
            env = {
              url = "http://localhost:1234",
            },
            schema = {
              model = {
                default = "qwen2.5-coder-7b-instruct-mlx"
              }
            }
          })
        end,
        anthropic = function()
          return require('codecompanion.adapters').extend("anthropic", {
            name = "anthropic",
            schema = {
              model = {
                default = "claude-3-5-haiku-20241022",
                choices = {
                  "claude-3-7-sonnet-20250219",
                  "claude-3-5-haiku-20241022"
                }
              },
            },
            env = {
              api_key = "cmd:cat ~/.secrets/anthropic_api_key.txt"
            }
          })
        end,
      },
      strategies = {
        chat = {
          adapter = "copilot",
        },
        inline = {
          adapter = "copilot",
        },
        cmd = {
          adapter = "copilot",
        }
      },
      display = {
        inline = {
          layout = "vertical"
        },
        diff = {
          enabled = true,
          layout = "vertical",
          provider = "mini_diff"
        }
      },
      extensions = {
        mcphub = {
          callback = "mcphub.extensions.codecompanion",
          opts = {
            show_result_in_chat = true, -- Show the mcp tool result in the chat buffer
            make_vars = true,           -- make chat #variables from MCP server resources
            make_slash_commands = true, -- make /slash_commands from MCP server prompts
          },
        }
      }
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "echasnovski/mini.nvim",
      "j-hui/fidget.nvim",
      "ravitemer/mcphub.nvim",
      "zbirenbaum/copilot.lua"
    },

  },
  {
    "ravitemer/mcphub.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim", -- Required for Job and HTTP requests
      {
        "deathbeam/CopilotChat.nvim",
        dependencies = {
          { "zbirenbaum/copilot.lua" },
          { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
        },
        branch = "tools",
        build = "make tiktoken", -- Only on MacOS or Linux
      }
    },
    cmd = "MCPHub",                          -- lazy load by default
    build = "npm install -g mcp-hub@latest", -- Installs required mcp-hub npm module
    config = function()
      require("copilot").setup({
        enabled = false
      })
      local chat = require("CopilotChat")
      chat.setup()
      local mcp = require("mcphub")
      mcp.on({ "servers_updated", "tool_list_changed", "resource_list_changed" }, function()
        local hub = mcp.get_hub_instance()
        if not hub then
          return
        end

        local async = require("plenary.async")
        local call_tool = async.wrap(function(server, tool, input, callback)
          hub:call_tool(server, tool, input, {
            callback = function(res, err)
              callback(res, err)
            end,
          })
        end, 4)

        local access_resource = async.wrap(function(server, uri, callback)
          hub:access_resource(server, uri, {
            callback = function(res, err)
              callback(res, err)
            end,
          })
        end, 3)

        for name, tool in pairs(chat.config.functions) do
          if tool.id and tool.id:sub(1, 3) == "mcp" then
            chat.config.functions[name] = nil
          end
        end
        local resources = hub:get_resources()
        for _, resource in ipairs(resources) do
          local name = resource.name:lower():gsub(" ", "_"):gsub(":", "")
          chat.config.functions[name] = {
            id = "mcp:" .. resource.server_name .. ":" .. name,
            uri = resource.uri,
            description = type(resource.description) == "string" and resource.description or "",
            resolve = function()
              local res, err = access_resource(resource.server_name, resource.uri)
              if err then
                error(err)
              end

              res = res or {}
              local result = res.result or {}
              local content = result.contents or {}
              local out = {}

              for _, message in ipairs(content) do
                if message.text then
                  table.insert(out, {
                    uri = message.uri,
                    data = message.text,
                    mimetype = message.mimeType,
                  })
                end
              end

              return out
            end,
          }
        end

        local tools = hub:get_tools()
        for _, tool in ipairs(tools) do
          chat.config.functions[tool.name] = {
            id = "mcp:" .. tool.server_name .. ":" .. tool.name,
            group = tool.server_name,
            description = tool.description,
            schema = tool.inputSchema,
            resolve = function(input)
              local res, err = call_tool(tool.server_name, tool.name, input)
              if err then
                error(err)
              end

              res = res or {}
              local result = res.result or {}
              local content = result.content or {}
              local out = {}

              for _, message in ipairs(content) do
                if message.type == "text" then
                  table.insert(out, {
                    data = message.text,
                  })
                elseif message.type == "resource" and message.resource and message.resource.text then
                  table.insert(out, {
                    uri = message.resource.uri,
                    data = message.resource.text,
                    mimetype = message.resource.mimeType,
                  })
                end
              end

              return out
            end,
          }
        end
      end)
      mcp.setup({
        port = 6969,
        extensions = {
          avante = {
            make_slash_commands = true
          },
          codecompanion = {
            -- Show the mcp tool result in the chat buffer
            show_result_in_chat = true,
            make_vars = true,           -- make chat #variables from MCP server resources
            make_slash_commands = true, -- make /slash_commands from MCP server prompts
          },
        }
      })
    end,
  },
}
