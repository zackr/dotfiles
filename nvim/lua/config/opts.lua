require('lualine').setup{
   options = { theme = 'dracula' }
}

vim.opt.number = true

vim.api.nvim_create_autocmd("FileType", {
  pattern = "gitcommit",
  command = "setlocal spell spelllang=en_us textwidth=72",
})

-- Strip leading and trailing whitespace from each line in the buffer
local function strip_line_whitespace()
  local cursor = vim.api.nvim_win_get_cursor(0)
  vim.cmd([[%s/\s\+$//e]])
  vim.cmd([[%s/^\s\+//e]])
  vim.api.nvim_win_set_cursor(0, cursor)
end

vim.keymap.set("n", "<leader>sw", strip_line_whitespace, { desc = "Strip leading/trailing whitespace from lines" })
