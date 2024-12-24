require("config.lazy")
require("config.harpoon")
require("plugins.small_terminal")
require("plugins.floating_terminal")

vim.opt.shiftwidth = 4
vim.opt.clipboard = "unnamedplus"
vim.opt.number = true
vim.opt.relativenumber = true

vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")
vim.keymap.set("n", "<space>bn", ":bn<CR>")
vim.keymap.set("n", "<space>nh", ":noh<CR>")

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd('TermOpen', {
	group = vim.api.nvim_create_augroup('cusom-term-open', { clear = true }),
	callback = function()
		vim.opt.number = false
		vim.opt.relativenumber = false
	end,
})


vim.keymap.set("n", "<space>example", function()
	vim.fn.chansend(job_id, { "echo 'hi' \r\n" })
end)

-- Map <Esc><Esc> to exit terminal mode and go back to normal mode
vim.api.nvim_set_keymap('t', '<Esc><Esc>', '<C-\\><C-n>', { noremap = true, silent = true })
