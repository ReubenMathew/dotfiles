local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local uv = vim.uv or vim.loop

-- Auto-install lazy.nvim if not present
if not uv.fs_stat(lazypath) then
	print("Installing lazy.nvim....")
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
	print("Done.")
end
vim.opt.rtp:prepend(lazypath)

-- lazy packages
require("lazy").setup({
	{ "rose-pine/neovim",            name = "rose-pine" },
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				ensure_installed = {
					"c",
					"lua",
					"vim",
					"vimdoc",
					"go",
					"rust",
					"css",
					"javascript",
					"html",
					"javascript",
					"typescript",
					"terraform",
				},
				sync_install = false,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
	-- Snippets
	{ "rafamadriz/friendly-snippets" },
	{
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!).
		--build = "make install_jsregexp",
		dependencies = { "rafamadriz/friendly-snippets" },
	},
	{ "saadparwaiz1/cmp_luasnip" },
	-- LSP Support
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v4.x",
		lazy = true,
		--config = false,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
		},
	},
	{
		"stevearc/aerial.nvim",
		opts = {},
		-- Optional dependencies
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
	},
	--- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{ "L3MON4D3/LuaSnip" },
		},
		sources = {
			name = "luasnip",
			option = {
				use_show_condition = false,
				show_autosnippets = true,
			},
		},
	},
	{
		"hrsh7th/cmp-path",
	},
	{ "hrsh7th/cmp-nvim-lsp-signature-help" },
	{ "onsails/lspkind.nvim" },
	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.4",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	-- Utilities
	{ "preservim/nerdcommenter" },
	{
		"folke/trouble.nvim",
		cmd = "Trouble",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			win = {
				wo = {
					wrap = true,
				},
			},
		},
	},
	{ "jose-elias-alvarez/null-ls.nvim" },
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("nvim-tree").setup({})
		end,
	},
	{ "lewis6991/gitsigns.nvim" },
	--{ "nvim-treesitter/nvim-treesitter-context" },
	{
		"nvim-lualine/lualine.nvim",
		event = "ColorScheme",
		config = function()
			require("lualine").setup({
				options = {
					--- @usage 'rose-pine' | 'rose-pine-alt'
					theme = "rose-pine",
				},
			})
		end,
	},
	--{ "github/copilot.vim" },
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"stevearc/dressing.nvim",
		opts = {},
	},
	{
		"ray-x/go.nvim",
		dependencies = { -- optional packages
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("go").setup()
		end,
		event = { "CmdlineEnter" },
		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
	{
		"rhysd/vim-fixjson",
		lazy = true,
	},
	{
		"sindrets/diffview.nvim",
	},
	{
		"j-hui/fidget.nvim",
		opts = {
			-- options
		},
	},
})

-- aerial
require("aerial").setup({
	-- optionally use on_attach to set keymaps when aerial has attached to a buffer
	on_attach = function(bufnr)
		-- Jump forwards/backwards with '{' and '}'
		vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
		vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
	end,
	show_guides = true,
	--min_width = 35,
	--max_width = 35,
	highlight_on_jump = 0,
})
-- You probably also want to set a keymap to toggle aerial
vim.keymap.set("n", "<leader>f", "<cmd>AerialToggle!<CR>")

-- todo-comments
require("todo-comments").setup()

-- lua_line
require("lualine").setup({
	options = {
		component_separators = "|",
		section_separators = { left = "", right = "" },
	},
	sections = {
		lualine_a = {
			{ "mode", separator = { left = "" }, right_padding = 2 },
		},
		lualine_b = { "filename", "branch" },
		lualine_c = { "diagnostics", "diff" },
		lualine_x = { "aerial" },
		lualine_y = { "filetype", "fileformat", "progress" },
		lualine_z = {
			{ "location", separator = { right = "" }, left_padding = 2 },
		},
	},
	inactive_sections = {
		lualine_a = { "filename" },
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = { "location" },
	},
	tabline = {},
	extensions = {},
})

-- gitsigns
require("gitsigns").setup()

-- Colorscheme
--- Config
require("rose-pine").setup({
	--- @usage 'auto'|'main'|'moon'|'dawn'
	variant = "auto",
	--- @usage 'main'|'moon'|'dawn'
	dark_variant = "main",
	bold_vert_split = false,
	dim_nc_background = true,
	disable_background = true,
	disable_float_background = false,
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
vim.cmd.colorscheme("rose-pine")

-- VIM OPTIONS
--- Swap File
vim.o.swapfile = false
--- Tab Sizing
vim.o.tabstop = 4
vim.o.shiftwidth = vim.o.tabstop
--- Options
--vim.o.nocompatible = true
vim.o.wildmenu = true
vim.o.autoindent = true
vim.o.shell = "/bin/zsh"
vim.o.number = true
vim.o.clipboard = "unnamed"
vim.o.termguicolors = true
vim.o.scrolloff = 8
vim.o.signcolumn = "yes"
vim.o.updatetime = 50
-- Status Line
vim.o.laststatus = 3 -- Or 3 for global statusline
vim.o.statusline = " %f %m %= %l:%c "
-- Copilot
--vim.g.copilot_enabled = false
-- Undo
vim.o.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.o.undofile = true

-- MAPPINGS
--- Remap escape
vim.keymap.set("i", "<S-Tab>", "<ESC>", {})
vim.keymap.set("o", "<S-Tab>", "<ESC>", {})
--- ; same as :
vim.keymap.set("n", ";", ":", {})
--- Telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<c-p>", builtin.find_files, {})
vim.keymap.set("n", "<c-g>", builtin.git_files, {})
vim.keymap.set("n", "<c-f>", builtin.live_grep, {})
--- NvimTree
vim.keymap.set("n", "<leader>t", ":NvimTreeFindFileToggle<CR>", { silent = true })
--- Trouble
vim.keymap.set("n", "<c-t>", ":Trouble diagnostics toggle<CR>", { silent = true })
--- Open line diagnostic in floating window
vim.keymap.set("n", "H", ":lua vim.diagnostic.open_float(nil, { focus = false })<CR>", { silent = true })

-- LSP
--- Setup
local lsp_zero = require("lsp-zero")
local lsp_attach = function(client, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions
	lsp_zero.default_keymaps({ buffer = bufnr })
	vim.keymap.set({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action, { buffer = bufnr })
	vim.keymap.set({ "n", "v", "i" }, "<c-s>", vim.lsp.buf.format, { buffer = bufnr })
	vim.keymap.set({ "n" }, "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr })
end
lsp_zero.extend_lspconfig({
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	lsp_attach = lsp_attach,
	float_border = "rounded",
	sign_text = true,
})
--- Language Servers
require("lspconfig").terraformls.setup({})
require("lspconfig").jedi_language_server.setup({ lazy = true })
require("lspconfig").yamlls.setup({ lazy = true })
require("lspconfig").bashls.setup({})
require("lspconfig").html.setup({ lazy = true })
require("lspconfig").ts_ls.setup({ lazy = true })
require("lspconfig").denols.setup({ lazy = true })
require("lspconfig").rust_analyzer.setup({
	cmd = { "rust-analyzer" },

	settings = {
		["rust-analyzer"] = {
			diagnostics = {
				enable = false,
			},
		},
	},
	lazy = true,
})
require("lspconfig").jdtls.setup({
	lazy = true,
})
require("lspconfig").gopls.setup({
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl", "tmpl", "templ" },
	settings = {
		gopls = {
			completeUnimported = true,
			usePlaceholders = true,
			experimentalPostfixCompletions = true,
			analyses = {
				unusedparams = true,
				shadow = true,
			},
			staticcheck = true,
			gofumpt = false,
		},
	},
	init_options = {
		usePlaceholders = true,
	},
})
require("lspconfig").templ.setup({})
require("lspconfig").lua_ls.setup({
	on_init = function(client)
		local path = client.workspace_folders[1].name
		if not vim.loop.fs_stat(path .. "/.luarc.json") and not vim.loop.fs_stat(path .. "/.luarc.jsonc") then
			client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
				Lua = {
					runtime = {
						-- Tell the language server which version of Lua you're using
						-- (most likely LuaJIT in the case of Neovim)
						version = "LuaJIT",
					},
					-- Make the server aware of Neovim runtime files
					workspace = {
						checkThirdParty = false,
						library = {
							vim.env.VIMRUNTIME,
							"${3rd}/luv/library",
							-- "${3rd}/busted/library",
						},
						-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
						-- library = vim.api.nvim_get_runtime_file("", true)
					},
				},
			})

			client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
		end
		return true
	end,
})
require("lspconfig").nixd.setup({})

-- Autocmds
--- Formatting
vim.cmd([[autocmd BufWritePre rust,go,java,html,js,sh lua vim.lsp.buf.format()]])
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = { "*.tf", "*.tfvars" },
	callback = function()
		vim.lsp.buf.format()
	end,
})
--- Treesitter
vim.api.nvim_create_autocmd({ "InsertLeave", "InsertEnter" }, {
	pattern = "*",
	callback = function()
		if vim.api.nvim_buf_line_count(0) > 8000 then
			vim.cmd("TSToggle highlight")
		end
	end,
})

-- Diagnostics config
--- Show line diagnostics automatically in hover window
vim.diagnostic.config({
	virtual_text = false,
	underline = true,
	signs = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		source = true,
		border = "rounded",
		scope = "cursor",
	},
})
--vim.cmd([[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]])

-- Autocompletion
local cmp = require("cmp")
local cmp_action = lsp_zero.cmp_action()
local lspkind = require("lspkind")

--- default sources for all buffers
local default_cmp_sources = cmp.config.sources({
	{ name = "nvim_lsp" },
	{ name = "nvim_lsp_signature_help" },
}, {
	{ name = "luasnip" },
	{ name = "path" },
})

cmp.setup({
	preselect = "item",
	completion = {
		completeopt = "menu,menuone,noinsert",
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "path" },
		{ name = "luasnip" },
		{ name = "nvim_lsp_signature_help" },
	},
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		-- `Enter` key to confirm completion
		["<CR>"] = cmp.mapping.confirm({ select = false }),

		-- Ctrl+Space to trigger completion menu
		["<C-Space>"] = cmp.mapping.complete(),

		-- Navigate between snippet placeholder
		["<C-f>"] = cmp_action.luasnip_jump_forward(),
		["<C-b>"] = cmp_action.luasnip_jump_backward(),

		-- Scroll up and down in the completion documentation
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),

		-- Complete on tab
		["<Tab>"] = cmp.mapping.confirm({ select = false }),
	}),
	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol", -- show only symbol annotations
			maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
			-- can also be a function to dynamically calculate max width such as
			-- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
			ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
			show_labelDetails = true, -- show labelDetails in menu. Disabled by default

			-- The function below will be called before any actual modifications from lspkind
			-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
			--before = function (entry, vim_item)
			--...
			--return vim_item
			--end
		}),
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	enabled = function()
		-- disable completion in comments
		local context = require("cmp.config.context")
		-- keep command mode completion enabled when cursor is in a comment
		if vim.api.nvim_get_mode().mode == "c" then
			return true
		else
			return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
		end
	end,
})

-- Snippets
require("luasnip.loaders.from_vscode").lazy_load({
	include = {
		"go",
		"rust",
		"lua",
		"sh",
	},
})
