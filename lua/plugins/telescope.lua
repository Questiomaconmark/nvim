return {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.8',
	dependencies = {
		{ 'nvim-lua/plenary.nvim' },
		{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' }
	},
	config = function()
		require('telescope').setup {
			pickers = {
				find_files = {
					theme = "ivy",
				}
			},
			extensions = {
				fzf = {}
			}
		}
		require('telescope').load_extension('fzf')

		--defaults (f)ind (f)iles, (f)ind (g)rep = live grep, (f)ind (b)uffers, (f)ind (h)elp
		local builtin = require('telescope.builtin')
		vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
		vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
		vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
		vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
		--(e)dit (n)eovim, find files in nvim/config
		vim.keymap.set("n", "<space>en", function()
			require('telescope.builtin').find_files {
				cwd = vim.fn.stdpath("config")
			}
		end)
		--(e)dit (p)ackages, search packages installed by plugins
		vim.keymap.set("n", "<space>ep", function()
			require('telescope.builtin').find_files {
				cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
			}
		end)
		require "config.telescope.multigrep".setup()
	end
}
