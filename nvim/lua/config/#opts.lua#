require('lualine').setup{
   options = { theme = 'dracula' }
}

vim.opt.number = true

vim.api.nvim_create_autocmd("FileType", {
  pattern = "gitcommit",
  command = "setlocal spell spelllang=en_us textwidth=72",
})
