return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      -- A list of parsers to ensure installed
      ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },

      -- Enable syntax highlighting
      highlight = {
        enable = true,
      },
      -- Enable indentation
      indent = {
        enable = true,
      },
    })
  end
}
