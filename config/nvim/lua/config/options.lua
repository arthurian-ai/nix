-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options hereby

-- LSP Server to use for Python.
-- Set to "basedpyright" to use basedpyright instead of pyright.
vim.g.lazyvim_python_lsp = "pyright"
-- Set to "ruff_lsp" to use the old LSP implementation version.
vim.g.lazyvim_python_ruff = "ruff"

vim.opt.scrolloff = 999
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.wrap = false

-- Open new splits below and to the right
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Allow going past end of line in visual block mode
vim.opt.virtualedit = "block"

-- Preview changes in find and replace in split
vim.opt.inccommand = "split"

-- Don't require uppercase first character for plugin commands
vim.opt.ignorecase = true

-- Allow full color range
vim.opt.termguicolors = true

-- For transparent themes only
-- vim.opt.cursorlineopt = "number"
