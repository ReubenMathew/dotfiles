local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
local uv = vim.uv or vim.loop

-- Auto-install lazy.nvim if not present
if not uv.fs_stat(lazypath) then
	print('Installing lazy.nvim....')
	vim.fn.system({
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable', -- latest stable release
		lazypath,
	})
	print('Done.')
end
vim.opt.rtp:prepend(lazypath)

-- lazy packages
require("lazy").setup({
	{ 'rose-pine/neovim',       name = 'rose-pine' },
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				ensure_installed = { "c", "lua", "vim", "vimdoc", "go", "rust", "css", "javascript", "html" },
				sync_install = false,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end
	},
	-- LSP Support
	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v3.x',
		lazy = true,
		config = false,
	},
	{
		'neovim/nvim-lspconfig',
		dependencies = {
			{ 'hrsh7th/cmp-nvim-lsp' },
		}
	},
	-- Autocompletion
	{
		'hrsh7th/nvim-cmp',
		dependencies = {
			{ 'L3MON4D3/LuaSnip' }
		},
	},
	-- Telescope
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.4',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},
	-- Utilities
	{ 'preservim/nerdcommenter' },
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{ "jose-elias-alvarez/null-ls.nvim", },
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("nvim-tree").setup {}
		end,
	},
	{ "lewis6991/gitsigns.nvim" },
	{ "nvim-treesitter/nvim-treesitter-context" },
	{
	  'nvim-lualine/lualine.nvim',
	  event = 'ColorScheme',
	  config = function()
		require('lualine').setup({
		  options = {
			--- @usage 'rose-pine' | 'rose-pine-alt'
			theme = 'rose-pine'
		  }
		})
	  end
	},
	{ 'github/copilot.vim' },
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{ 'mfussenegger/nvim-dap' },
	{ 'leoluz/nvim-dap-go' },
})

-- DAP Debugger
require('dap-go').setup()

-- todo-comments
require('todo-comments').setup()

-- lua_line
require('lualine').setup {
  options = {
    component_separators = '|',
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = {
      { 'mode', separator = { left = '' }, right_padding = 2 },
    },
    lualine_b = { 'filename', 'branch' },
    lualine_c = { 'diagnostics', 'diff' },
    lualine_x = {},
    lualine_y = { 'filetype', 'fileformat', 'progress' },
    lualine_z = {
      { 'location', separator = { right = '' }, left_padding = 2 },
    },
  },
  inactive_sections = {
    lualine_a = { 'filename' },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'location' },
  },
  tabline = {},
  extensions = {},
}

-- gitsigns
require('gitsigns').setup()

-- null-ls
local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.completion.spell,
		null_ls.builtins.code_actions.impl,
		null_ls.builtins.code_actions.gomodifytags,
		null_ls.builtins.diagnostics.shellcheck,
		null_ls.builtins.formatting.rustfmt,
	},
})

-- Colorscheme
--- Config
require('rose-pine').setup({
	--- @usage 'auto'|'main'|'moon'|'dawn'
	variant = 'auto',
	--- @usage 'main'|'moon'|'dawn'
	dark_variant = 'main',
	bold_vert_split = false,
	dim_nc_background = false,
	disable_background = true,
	disable_float_background = true,
	disable_italics = true,

	highlight_groups = {
		TelescopeBorder = { fg = "highlight_high", bg = "none" },
		TelescopeNormal = { bg = "none" },
		TelescopePromptNormal = { bg = "base" },
		TelescopeResultsNormal = { fg = "subtle", bg = "none" },
		TelescopeSelection = { fg = "text", bg = "base" },
		TelescopeSelectionCaret = { fg = "rose", bg = "rose" },
		StatusLine = { fg = "love", bg = "love", blend = 10 },
		StatusLineNC = { fg = "subtle", bg = "surface" },
	},
})
--- Set colorscheme after options
vim.cmd('colorscheme rose-pine')

-- VIM OPTIONS
--- Tab Sizing
vim.o.tabstop = 4
vim.o.shiftwidth = vim.o.tabstop
--- Options
vim.o.nocompatible = true
vim.o.wildmenu = true
vim.o.autoindent = true
vim.o.shell = "/bin/bash"
vim.o.number = true
vim.o.clipboard = "unnamed"
vim.o.termguicolors = true
-- Status Line
vim.opt.laststatus = 3 -- Or 3 for global statusline
vim.opt.statusline = " %f %m %= %l:%c "
-- Copilot
vim.g.copilot_enabled = false

-- MAPPINGS
--- Remap escape
vim.keymap.set("i", "<S-Tab>", "<ESC>", {})
vim.keymap.set("o", "<S-Tab>", "<ESC>", {})
--- ; same as :
vim.keymap.set("n", ";", ":", {})
--- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<c-p>', builtin.find_files, {})
vim.keymap.set('n', '<c-g>', builtin.git_files, {})
vim.keymap.set('n', '<c-f>', builtin.live_grep, {})
--- NvimTree
--local api = require("nvim-tree.api")
vim.keymap.set("n", "<leader>t", ":NvimTreeFindFileToggle<CR>", {silent = true})

-- LSP
--- Setup
local lsp_zero = require('lsp-zero')
lsp_zero.on_attach(function(client, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions
	lsp_zero.default_keymaps({ buffer = bufnr })
	vim.keymap.set({ 'n', 'v' }, '<leader>a', vim.lsp.buf.code_action, {buffer = bufnr})
end)

--- Language Servers
require('lspconfig').tsserver.setup({})
require('lspconfig').rust_analyzer.setup({})
require('lspconfig').gopls.setup({})
require('lspconfig').bashls.setup({})
require('lspconfig').jdtls.setup({})
require 'lspconfig'.lua_ls.setup {
	on_init = function(client)
		local path = client.workspace_folders[1].name
		if not vim.loop.fs_stat(path .. '/.luarc.json') and not vim.loop.fs_stat(path .. '/.luarc.jsonc') then
			client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
				Lua = {
					runtime = {
						-- Tell the language server which version of Lua you're using
						-- (most likely LuaJIT in the case of Neovim)
						version = 'LuaJIT'
					},
					-- Make the server aware of Neovim runtime files
					workspace = {
						checkThirdParty = false,
						library = {
							vim.env.VIMRUNTIME
							-- "${3rd}/luv/library"
							-- "${3rd}/busted/library",
						}
						-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
						-- library = vim.api.nvim_get_runtime_file("", true)
					}
				}
			})

			client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
		end
		return true
	end
}

-- Autocompletion
local cmp = require('cmp')
local cmp_action = lsp_zero.cmp_action()

cmp.setup({
	mapping = cmp.mapping.preset.insert({
		-- `Enter` key to confirm completion
		['<CR>'] = cmp.mapping.confirm({ select = false }),

		-- Ctrl+Space to trigger completion menu
		['<C-Space>'] = cmp.mapping.complete(),

		-- Navigate between snippet placeholder
		['<C-f>'] = cmp_action.luasnip_jump_forward(),
		['<C-b>'] = cmp_action.luasnip_jump_backward(),

		-- Scroll up and down in the completion documentation
		['<C-u>'] = cmp.mapping.scroll_docs(-4),
		['<C-d>'] = cmp.mapping.scroll_docs(4),
	})
})