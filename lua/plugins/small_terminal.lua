local state = require('config.terminal_state')

local M = {}

local function toggle_small_terminal()
	if state.buf ~= -1 and vim.api.nvim_buf_is_valid(state.buf) then
		local term_winid = vim.fn.win_getid(vim.fn.bufwinid(state.buf))

		if term_winid ~= -1 and vim.fn.winnr('$') > 1 then
			vim.api.nvim_win_close(term_winid, true)
		else
			vim.cmd('botright split')
			vim.api.nvim_set_current_buf(state.buf)
			vim.cmd('resize 10')
		end
	else
		vim.cmd('botright split | term')
		state.buf = vim.api.nvim_get_current_buf()
		vim.cmd('resize 10')
	end
	state.small_win = vim.fn.win_getid()
end

vim.api.nvim_create_user_command("SmallTerminal", toggle_small_terminal, {})
vim.keymap.set({ "n", "t" }, "<C-_", toggle_small_terminal)
vim.keymap.set({ 'n', 't' }, '<C-_>', toggle_small_terminal, { noremap = true, silent = true })

return M
