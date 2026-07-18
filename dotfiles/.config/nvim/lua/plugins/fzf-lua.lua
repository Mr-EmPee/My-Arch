vim.pack.add({
	"https://github.com/ibhagwan/fzf-lua",
})

require("fzf-lua").setup({})

vim.keymap.set("n", "<leader>ff", function ()
	require("fzf-lua").git_files()
end)

vim.keymap.set("n", "<leader>fs", function ()
	require("fzf-lua").files()
end)

vim.keymap.set("n", "<leader>fg", function ()
	require("fzf-lua").live_grep()
end)

vim.keymap.set("n", "<leader>fb", function ()
	require("fzf-lua").buffers()
end)
