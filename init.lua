vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("i", "kk", "<Esc>l")

vim.keymap.set("n", " ex", vim.cmd.Ex)

vim.opt.tabstop = 4
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.list = true
vim.opt.listchars = { tab = "⟶ ", trail = "•", nbsp = '␣' }

vim.opt.cursorline = false
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.showmode = false

vim.opt.clipboard = "unnamed"


local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
