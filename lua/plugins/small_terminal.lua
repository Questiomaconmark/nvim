local M = {}
term_bufnr = nil

function toggle_terminal()
	if term_bufnr and vim.api.nvim_buf_is_valid(term_bufnr) then
		local term_winid = vim.fn.win_getid(vim.fn.bufwinid(term_bufnr))

		if term_winid ~= -1 and vim.fn.winnr('$') > 1 then
			-- Close the terminal if it's open and there are other windows
			vim.api.nvim_win_close(term_winid, true)
		else
			-- Open the existing terminal buffer if it's closed
			vim.cmd('botright split')
			vim.api.nvim_set_current_buf(term_bufnr)
			vim.cmd('resize 10') -- Adjust height as needed
		end
	else
		-- Open a new terminal and store its buffer number
		vim.cmd('botright split | term')
		term_bufnr = vim.api.nvim_get_current_buf()
		vim.cmd('resize 10') -- Adjust height as needed
	end
end

-- Map <space>st to the toggle_terminal function
vim.api.nvim_set_keymap('n', '<space>st', ':lua toggle_terminal()<CR>', { noremap = true, silent = true })
return M
