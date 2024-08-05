return {
  "hedyhli/outline.nvim",
  lazy = true,
  cmd = { "Outline", "OutlineOpen" },
  keys = {
      {"<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline"},
  },
  config = function()

    require("outline").setup {
      -- Your setup opts here (leave empty to use defaults)
    }
  end,
}