return {
  {
    "snacks.nvim",
    opts = {
      picker = {
        sources = {
          files = {
            hidden = true,
          },
        },
      },
    },
    keys = {
      {
        "<leader>,",
        function()
          Snacks.picker.buffers({
            -- change to normal mode
            on_show = function()
              vim.cmd.stopinsert()
            end,
            finder = "buffers",
            format = "buffer",
            hidden = false,
            unloaded = true,
            current = true,
            sort_lastused = true,
            win = {
              input = {
                keys = {
                  ["d"] = "bufdelete",
                },
              },
              list = { keys = { ["d"] = "bufdelete" } },
            },
            -- In case you want to override the layout for this keymap
            -- layout = "ivy",
          })
        end,
        desc = "Snacks picker buffers",
      },
    },
  },
}
