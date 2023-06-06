-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

local function make_opts(o)
  return vim.tbl_extend("error", opts, o)
end

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Basics
keymap("n", "<F12>", ":w<CR>", opts)
keymap("i", "<F12>", "<ESC>:w<CR>i", opts)
keymap("n", "<C-`>", ":ToggleTerm<CR>", opts)
keymap("n", "<C-q>", "q", opts)
keymap("n", "q", ":quit<CR>", opts)
keymap("n", "gw", ":HopWord<CR>", opts)
keymap("n", "<F5>", ":OverseerRunCmd make<cr>", make_opts({ desc = "overseer make" }))
keymap("n", "<F6>", ":OverseerQuickAction open float<cr>", make_opts({ desc = "overseer popup" }))

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Clear highlights
keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)

-- Close buffers
keymap("n", "<S-q>", "<cmd>Bdelete!<CR>", opts)

-- Better paste
keymap("v", "p", 'P', opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Plugins --

-- NvimTree
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", make_opts({ desc = "tree" }))
keymap("n", "<F3>", ":NvimTreeToggle<CR>", make_opts({ desc = "tree" }))

-- Telescope
keymap("n", "<leader><leader>", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>s", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>ft", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>fp", ":Telescope projects<CR>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)
keymap("n", "<leader>fd", ":Telescope diagnostics<CR>", opts)
keymap("n", "<leader>fs", ":Telescope lsp_document_symbols<CR>", opts)
keymap("n", "<leader>fg", ":Telescope lsp_dynamic_workspace_symbols<CR>", opts)

-- Git

-- keymap("n", "<leader>gg", "<cmd>lua _TIG_TOGGLE()<CR>", make_opts({ desc = "tig" }))
keymap("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", make_opts({ desc = "lazygit" }))
keymap("n", "<leader>gs", ":Gitsigns stage_hunk<CR>", make_opts({ desc = "stage hunk" }))
keymap("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", make_opts({ desc = "preview hunk" }))
keymap("n", "<leader>gu", ":Gitsigns reset_hunk<CR>", make_opts({ desc = "reset hunk" }))
keymap("n", "<leader>gf", ":Gitsigns stage_buffer<CR>", make_opts({ desc = "stage buffer" }))

-- Comment
keymap("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", make_opts({ desc = "comment" }))
keymap("x", "<leader>/", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
  make_opts({ desc = "comment" }))

-- DAP
keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts)
keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", opts)
keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", opts)
keymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", opts)
keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", opts)
keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", opts)
keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts)
keymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", opts)

-- Lsp
keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", make_opts({ desc = "format" }))

-- Overseer
keymap("n", "<leader>ot", ":OverseerToggle<cr>", make_opts({ desc = "overseer sidebar" }))
keymap("n", "<leader>om", ":OverseerRunCmd make<cr>", make_opts({ desc = "overseer make" }))
keymap("n", "<leader>of", ":OverseerQuickAction open float<cr>", make_opts({ desc = "overseer popup" }))

-- Config
keymap("n", "<leader>cc", ":e $MYVIMRC<CR>", make_opts({ desc = "open" }))
keymap("n", "<leader>cf", ":cd ~/.config/nvim | Telescope find_files<CR>", make_opts({ desc = "open" }))
keymap("n", "<leader>cm", ":map<CR>", make_opts({ desc = "map" }))
