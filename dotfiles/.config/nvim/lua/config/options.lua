-- Clear BK
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })

vim.g.mapleader = " "         -- Set leader key to space

vim.opt.number = true         -- line number
vim.opt.relativenumber = true -- relative line number
vim.opt.wrap = false          -- do not wrap lines by defaults
vim.opt.scrolloff = 10        -- keep height margin when scrolling
vim.opt.sidescrolloff = 10    -- keep side margin when scrolling

vim.opt.tabstop = 2           -- tab width
vim.opt.shiftwidth = 2        -- indent width
vim.opt.softtabstop = 2       -- tab width
vim.opt.expandtab = true      -- Use spaces instead of tab
vim.opt.smartindent = true    -- Smart auto indent
vim.opt.autoindent = true     -- Copy indent from current line

vim.opt.ignorecase = true     -- Case insensitive search
vim.opt.smartcase = true      -- Case sensitive if uppercase in string
vim.opt.hlsearch = true       -- Highlight search
vim.opt.incsearch = true      -- Show matches as you type

vim.opt.updatetime = 300      -- faster completion
vim.opt.timeoutlen = 500      -- timeout duration
vim.opt.ttimeoutlen = 0       -- key code for timeout

vim.opt.autoread = true       -- hot reload external file changes
vim.opt.autowrite = false     -- do not auto-save

vim.opt.encoding = "utf-8"    -- char encoding

local undodir = vim.fn.expand("~/.vim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
    vim.fn.mkdir(undodir, "p")
end

vim.opt.undofile = true     -- create undofiles
vim.opt.undodir = undodir   -- path of undodir

vim.opt.backup = false      -- No backup files
vim.opt.writebackup = false -- Do not write backup files

vim.opt.swapfile = false    -- No swap file
