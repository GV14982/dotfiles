return {
  {
    'pwntester/octo.nvim',
    config = function()
      require("octo").setup()
    end,
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'nvim-tree/nvim-web-devicons',
    },
  },
  { 'akinsho/git-conflict.nvim', version = "*", config = true }
}
