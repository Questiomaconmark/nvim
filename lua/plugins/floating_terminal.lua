local state = require('config.terminal_state')

local M = {}

local function create_floating_window(opts)
	opts = opts or {}
	local width = opts.width or math.floor(vim.o.columns * 0.8)
	local height = opts.height or math.floor(vim.o.lines * 0.8)
	local col = opts.col or math.floor((vim.o.columns - width) / 2)
	local row = opts.row or math.floor((vim.o.lines - height) / 2)

	local buf
	if vim.api.nvim_buf_is_valid(state.buf) then
		buf = state.buf
	else
		buf = vim.api.nvim_create_buf(false, true)
		state.buf = buf -- Ensure the buffer ID is stored in the state
	end

	local win_config = {
		relative = "editor",
		width = width,
		height = height,
		col = col,
		row = row,
		style = "minimal",
		border = "double",
	}

	state.floating_win = vim.api.nvim_open_win(buf, true, win_config)

	return state
end

local function toggle_terminal()
	if not vim.api.nvim_win_is_valid(state.floating_win) then
		create_floating_window { buf = state.buf }
		if vim.bo[state.buf].buftype ~= "terminal" then
			vim.cmd('term')
			state.buf = vim.api.nvim_get_current_buf()
		end
	else
		vim.api.nvim_win_hide(state.floating_win)
	end
end

vim.api.nvim_create_user_command("FloatTerminal", toggle_terminal, {})
vim.keymap.set("n", "<space>tt", toggle_terminal)
vim.keymap.set({ "n", "t" }, "<C-\\>", toggle_terminal)

return M
