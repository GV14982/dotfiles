return {
  {
    "olimorris/codecompanion.nvim",
    config = true,
    opts = {
      adapters = {
        qwen14b = function()
          return require("codecompanion.adapters").extend("ollama", {
            name = "qwen14b",
            schema = {
              model = {
                default = "qwen2.5-coder:14b"
              },
            },
          })
        end
      },
      strategies = {
        chat = {
          adapter = "qwen14b"
        },
        inline = {
          adapter = "qwen14b"
        }
      }
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
  -- {
  --   "David-Kunz/gen.nvim",
  --   opts = {
  --     model = "qwen2.5-coder:14b", -- The default model to use.
  --     quit_map = "q",              -- set keymap to close the response window
  --     retry_map = "<c-r>",         -- set keymap to re-send the current prompt
  --     accept_map = "<c-cr>",       -- set keymap to replace the previous selection with the last result
  --     host = "localhost",          -- The host running the Ollama service.
  --     port = "11434",              -- The port on which the Ollama service is listening.
  --     display_mode = "float",      -- The display mode. Can be "float" or "split" or "horizontal-split".
  --     show_prompt = false,         -- Shows the prompt submitted to Ollama. Can be true (3 lines) or "full".
  --     show_model = true,           -- Displays which model you are using at the beginning of your chat session.
  --     no_auto_close = false,       -- Never closes the window automatically.
  --     file = false,                -- Write the payload to a temporary file to keep the command short.
  --     hidden = false,              -- Hide the generation window (if true, will implicitly set `prompt.replace = true`), requires Neovim >= 0.10
  --     init = function(options) pcall(io.popen, "ollama serve > /dev/null 2>&1 &") end,
  --     -- Function to initialize Ollama
  --     command = function(options)
  --       local body = { model = options.model, stream = true }
  --       return "curl --silent --no-buffer -X POST http://" .. options.host .. ":" .. options.port .. "/api/chat -d $body"
  --     end,
  --     -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
  --     -- This can also be a command string.
  --     -- The executed command must return a JSON object with { response, context }
  --     -- (context property is optional).
  --     -- list_models = '<omitted lua function>', -- Retrieves a list of model names
  --     result_filetype = "markdown", -- Configure filetype of the result buffer
  --     debug = false                 -- Prints errors and the command which is run.
  --   }
  -- },
  -- {
  --   'milanglacier/minuet-ai.nvim',
  --   opts = {
  --     cmp = {
  --       enable_auto_complete = true,
  --     },
  --     -- virtualtext = {
  --     --   enabled = true,
  --     --   -- Specify the filetypes to enable automatic virtual text completion,
  --     --   -- e.g., { 'python', 'lua' }. Note that you can still invoke manual
  --     --   -- completion even if the filetype is not on your auto_trigger_ft list.
  --     --   auto_trigger_ft = {},
  --     --   -- specify file types where automatic virtual text completion should be
  --     --   -- disabled. This option is useful when auto-completion is enabled for
  --     --   -- all file types i.e., when auto_trigger_ft = { '*' }
  --     --   auto_trigger_ignore_ft = {},
  --     --   keymap = {
  --     --     -- accept whole completion
  --     --     accept = '<A-A>',
  --     --     -- accept one line
  --     --     accept_line = '<A-a>',
  --     --     -- accept n lines (prompts for number)
  --     --     -- e.g. "A-z 2 CR" will accept 2 lines
  --     --     accept_n_lines = '<A-z>',
  --     --     -- Cycle to prev completion item, or manually invoke completion
  --     --     prev = '<A-[>',
  --     --     -- Cycle to next completion item, or manually invoke completion
  --     --     next = '<A-]>',
  --     --     dismiss = '<A-e>',
  --     --   },
  --     --   -- Whether show virtual text suggestion when the completion menu
  --     --   -- (nvim-cmp or blink-cmp) is visible.
  --     --   show_on_completion_menu = false,
  --     -- },
  --     provider = 'openai_fim_compatible',
  --     n_completions = 1, -- recommend for local model for resource saving
  --     -- I recommend beginning with a small context window size and incrementally
  --     -- expanding it, depending on your local computing power. A context window
  --     -- of 512, serves as an good starting point to estimate your computing
  --     -- power. Once you have a reliable estimate of your local computing power,
  --     -- you should adjust the context window to a larger value.
  --     context_window = 1024,
  --     notify = "verbose",
  --     provider_options = {
  --       openai_fim_compatible = {
  --         api_key = 'TERM',
  --         name = 'Ollama',
  --         end_point = 'http://localhost:11434/v1/completions',
  --         model = 'qwen2.5-coder:14b',
  --         optional = {
  --           max_tokens = 64,
  --           top_p = 0.9,
  --         },
  --       },
  --     },
  --   },
  -- },
  -- Enable this if they ever support Ollama
  -- {
  --   "yetone/avante.nvim",
  --   event = "VeryLazy",
  --   lazy = false,
  --   version = "0.0.20",
  --   -- version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
  --   opts = {
  --     provider = "ollama",
  --     vendors = {
  --       ollama = {
  --         __inherited_from = "openai",
  --         api_key_name = "",
  --         endpoint = "http://localhost:11434/v1",
  --         model = "qwen2.5-coder:14b",
  --       },
  --     },
  --     rag_service = {
  --       enabled = false,                      -- Enables the RAG service
  --       host_mount = os.getenv("HOME"),       -- Host mount path for the rag service
  --       provider = "ollama",                  -- The provider to use for RAG service (e.g. openai or ollama)
  --       llm_model = "qwen2.5-coder:1b",       -- The LLM model to use for RAG service
  --       embed_model = "",                     -- The embedding model to use for RAG service
  --       endpoint = "http://localhost:11434/", -- The API endpoint for RAG service
  --     },
  --   },
  --   -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  --   build = "make",
  --   -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
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
  --       -- support for image pasting
  --       "HakonHarnes/img-clip.nvim",
  --       event = "VeryLazy",
  --       opts = {
  --         -- recommended settings
  --         default = {
  --           embed_image_as_base64 = false,
  --           prompt_for_file_name = false,
  --           drag_and_drop = {
  --             insert_mode = true,
  --           },
  --           -- required for Windows users
  --           use_absolute_path = true,
  --         },
  --       },
  --     },
  --     {
  --       -- Make sure to set this up properly if you have lazy=true
  --       'MeanderingProgrammer/render-markdown.nvim',
  --       opts = {
  --         file_types = { "markdown", "Avante" },
  --       },
  --       ft = { "markdown", "Avante" },
  --     },
  --   },
  -- }
}
