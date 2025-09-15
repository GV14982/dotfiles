return {
  "tris203/precognition.nvim",
  keys = {
    {
      "<leader>pt",
      function()
        if require("precognition").toggle() then
          vim.notify("precognition on")
        else
          vim.notify("precognition off")
        end
      end,
      desc = "Toggle Precognition",
    },
    {
      "<leader>pp",
      function()
        require("precognition").peek()
      end,
      desc = "Toggle Precognition",
    },
  },
}
