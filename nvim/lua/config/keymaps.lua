-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.g.mapleader = ","

-- save file
-- vim.keymap.del({ "i", "x", "n", "s" }, "<ctrl-s>", { desc = "Save File" })
vim.keymap.set({ "x", "n", "s" }, "<leader>s", "<cmd>w<cr><esc>", { desc = "Save File" })
