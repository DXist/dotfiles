-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.g.mapleader = ","

-- save file
-- vim.keymap.del({ "i", "x", "n", "s" }, "<ctrl-s>", { desc = "Save File" })
vim.keymap.set({ "x", "n", "s" }, "<leader>s", "<cmd>w<cr><esc>", { desc = "Save File" })
vim.keymap.set({ "n" }, "<leader>gd", "<cmd>Gdiffsplit!<cr>", { desc = "Git Diff" })
vim.keymap.set({ "n" }, "dgl", "<cmd>diffget //2<CR><cmd>diffupdate<CR>", { desc = "Diffget from left" })
vim.keymap.set({ "n" }, "dgr", "<cmd>diffget //3<CR><cmd>diffupdate<CR>", { desc = "Diffget from right" })
