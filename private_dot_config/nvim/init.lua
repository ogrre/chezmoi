-- Config neovim
vim.g.mapleader = " "
vim.opt.termguicolors = true
vim.opt.encoding = "UTF-8"
vim.opt.number = true
vim.wo.scrolloff = 20
local km = vim.keymap

-- Lazy 
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- Theme
	{ "bluz71/vim-moonfly-colors",        name = "moonfly",   lazy = false, priority = 1000 },
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			-- Configuration spécifique pour Tokyo Night
			style = "storm",
			transparent = false,  -- Désactiver pour un fond opaque
			terminal_colors = true,  -- Active les couleurs pour le terminal intégré
			styles = {
				comments = { italic = true },
				keywords = { italic = true },
				functions = {},
				variables = {},
				sidebars = "dark",  -- Style pour NvimTree, etc.
				floats = "dark",    -- Style pour les fenêtres flottantes
			},
			on_colors = function(colors)
				-- Ajustements mineurs pour correspondre exactement aux previews
				colors.bg = "#1f2335"
				colors.bg_dark = "#1a1b26"
				colors.blue = "#7aa2f7"
			end,
			on_highlights = function(hl, c)
				-- Personnalisations supplémentaires si besoin
				hl.CursorLine = { bg = "#2a2e3f" }
			end,
		},
		config = function(_, opts)
			require("tokyonight").setup(opts)
			vim.cmd[[colorscheme tokyonight]]
		end
	},
	-- LSP moderne
	{ 'williamboman/mason.nvim' },
	{ 'williamboman/mason-lspconfig.nvim' },
	{ 'neovim/nvim-lspconfig' },
	{ 'hrsh7th/cmp-nvim-lsp' },
	{ 'hrsh7th/nvim-cmp' },
	{ 'L3MON4D3/LuaSnip' },
	-- Treesitter
	{ "nvim-treesitter/nvim-treesitter",  build = ":TSUpdate" },
	-- Telescope
	{ "nvim-telescope/telescope.nvim",    tag = '0.1.5',      dependencies = { 'nvim-lua/plenary.nvim' } },
	-- Noice (command in middle of screen)
	{"folke/noice.nvim",
	event = "VeryLazy",
	opts = {
		-- add any options here
	},
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	}
},
-- Fern
{"lambdalisue/fern.vim",
dependencies = {
	"lambdalisue/fern-git-status.vim",
	"lambdalisue/fern-hijack.vim",
	'lambdalisue/nerdfont.vim',
	"lambdalisue/fern-renderer-nerdfont.vim",
	"yuki-yano/fern-preview.vim",
}
    },
    -- nvim-cmp
    {'hrsh7th/nvim-cmp',
    requires = {
	    { 'hrsh7th/cmp-nvim-lsp' },
	    { 'hrsh7th/cmp-buffer' },
	    { 'hrsh7th/cmp-path' },
	    { 'hrsh7th/cmp-nvim-lua' },
    }
},
-- Comment nvim
{'numToStr/Comment.nvim',
opts = {
	-- add any options here
},
lazy = false,
    },
    -- Neogit
    {"NeogitOrg/neogit",
    dependencies = {
	    "nvim-lua/plenary.nvim",         -- required
	    "sindrets/diffview.nvim",        -- optional
	    "ibhagwan/fzf-lua",              -- optional
    },
    config = true
},
{"github/copilot.vim"},
-- Cheatsheet.nvim
{
	'sudormrfbin/cheatsheet.nvim',
	requires = {
		{'nvim-telescope/telescope.nvim'},
		{'nvim-lua/popup.nvim'},
		{'nvim-lua/plenary.nvim'},
	}
},
-- Grug-far.nvim
{
	'MagicDuck/grug-far.nvim',
	cond = vim.fn.has('nvim-0.10') == 1,  -- Ne charger que si nvim 0.10+
	config = function()
		require('grug-far').setup()
	end
},
-- Which-key
{
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
},
-- Barbar.nvim
{'romgrk/barbar.nvim',
dependencies = {
	'nvim-tree/nvim-web-devicons',
},
init = function() vim.g.barbar_auto_setup = false end,
opts = {
	animation = true,
	icons = {
		buffer_index = true,
		filetype = { enabled = true },
		separator = {left = '▎', right = ''},
		modified = {button = '●'},
		pinned = {button = '📌'},
	},
},
    },
    -- Vim-airline
    {'vim-airline/vim-airline',
    dependencies = {'vim-airline/vim-airline-themes'}
},
-- Markdown preview
{'iamcco/markdown-preview.nvim',
ft = {'markdown'},
build = ':call mkdp#util#install()',
init = function()
	vim.g.mkdp_filetypes = { "markdown" }
end,
    },
})

-- Configuration LSP moderne (Neovim 0.11+)
local lspconfig = require('lspconfig')
local cmp_nvim_lsp = require('cmp_nvim_lsp')

-- Capacités étendues pour l'autocomplétion
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Configuration globale des keymaps LSP
local on_attach = function(client, bufnr)
  local opts = { buffer = bufnr }
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
end

-- Mason
require('mason').setup({})
require('mason-lspconfig').setup({
	ensure_installed = {
		'lua_ls',
		'cssls',
		'jsonls',
		'html',
		'intelephense',
		'tailwindcss',
		'dockerls',
		'docker_compose_language_service',
		'yamlls',
		'sqlls',
	},
	handlers = {
		-- Configuration par défaut pour tous les serveurs
		function(server_name)
			lspconfig[server_name].setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})
		end,
	},
})

-- Configuration spécifique d'Intelephense avec amélioration
require('mason-lspconfig').setup({
	handlers = {
	['intelephense'] = function()
		lspconfig.intelephense.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			init_options = {
				clearCache = true,
			},
			settings = {
				intelephense = {
					stubs = {
						"apache", "bcmath", "bz2", "calendar", "com_dotnet", "Core", "ctype",
						"curl", "date", "dba", "dom", "enchant", "exif", "fileinfo", "filter",
						"fpm", "ftp", "gd", "gettext", "gmp", "hash", "iconv", "imap", "intl",
						"json", "ldap", "libxml", "mbstring", "mcrypt", "meta", "mysql", "mysqli",
						"oci8", "odbc", "openssl", "pcntl", "pcre", "PDO", "pdo_ibm", "pdo_mysql",
						"pdo_pgsql", "pdo_sqlite", "pgsql", "Phar", "posix", "pspell", "readline",
						"recode", "Reflection", "regex", "session", "shmop", "SimpleXML", "snmp",
						"soap", "sockets", "sodium", "SPL", "sqlite3", "standard", "superglobals",
						"sysvmsg", "sysvsem", "sysvshm", "tidy", "tokenizer", "xml", "xmlreader",
						"xmlrpc", "xmlwriter", "xsl", "Zend OPcache", "zip", "zlib", "wordpress",
						"phpunit", "laravel"
					},
					environment = {
						includePaths = {},
					},
					files = {
						maxSize = 5000000,
					},
					completion = {
						insertUseDeclaration = true,
						fullyQualifyGlobalConstantsAndFunctions = false,
						maxItems = 100
					},
					diagnostics = {
						enable = true,
						undefinedVariables = false,  -- Désactiver pour Laravel
						undefinedFunctions = false,
						undefinedConstants = false,
						undefinedClassConstants = false,
						undefinedMethods = false,
						undefinedProperties = false,
						undefinedTypes = false,
						duplicateSymbols = false,
					},
					format = {
						enable = true,
					},
				}
			}
		})
	end,
	}
})


-- Autocompletion LSP
local cmp = require('cmp')

cmp.setup({
	sources = {
		{name = 'nvim_lsp', priority = 1000},  -- Priorité plus élevée pour les suggestions LSP
		{name = 'buffer', priority = 500},
		{name = 'path', priority = 250},
		{name = 'luasnip', priority = 750},
	},
	mapping = {
		-- Confirmation et annulation
		['<C-y>'] = cmp.mapping.confirm({select = false}),
		['<C-e>'] = cmp.mapping.abort(),

		-- Navigation dans le menu
		['<Up>'] = cmp.mapping.select_prev_item({behavior = 'select'}),
		['<Down>'] = cmp.mapping.select_next_item({behavior = 'select'}),
		['<C-p>'] = cmp.mapping.select_prev_item({behavior = 'insert'}),
		['<C-n>'] = cmp.mapping.select_next_item({behavior = 'insert'}),

		-- Ouverture du menu
		['<C-Space>'] = cmp.mapping.complete(),

		-- Défilement de la documentation
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),

		-- Touche Tab pour confirmer la sélection
		['<Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end, { 'i', 's' }),
		['<S-Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end, { 'i', 's' }),

		-- Entrée pour confirmer la sélection
		['<CR>'] = cmp.mapping.confirm({ select = true }),
	},
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	formatting = {
		format = function(entry, vim_item)
			-- Ajouter des icônes
			vim_item.menu = ({
				nvim_lsp = "[LSP]",
				buffer = "[Buffer]",
				path = "[Path]",
				luasnip = "[Snippet]",
			})[entry.source.name]
			return vim_item
		end
	},
})

-- Configuration des actions de code
local wk = require("which-key")
wk.add({
	-- Code actions
	{ "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action" },
	{ "<leader>rn", vim.lsp.buf.rename, desc = "Rename" },
	{ "<leader>cf", vim.lsp.buf.format, desc = "Format Code" },
	{ "<leader>cd", vim.diagnostic.open_float, desc = "Line Diagnostics" },
	{ "<leader>ci", "<cmd>Telescope lsp_implementations<cr>", desc = "Implementations" },
	{ "<leader>ct", "<cmd>Telescope lsp_type_definitions<cr>", desc = "Type Definition" },
})

-- Les keymaps LSP sont maintenant configurés dans la fonction on_attach plus haut

-- local colors = require("tokyonight.colors").setup() -- pass in any of the config options as explained above

-- Notification Configuration
require("notify").setup({
	background_colour = "#1a1b26", -- Couleur de fond assortie au thème moonfly
	-- background_colour = colors.bg_dark,
	render = "default",
	timeout = 3000,
	max_width = 80,
	max_height = 20,
	stages = "fade",
})

-- Noice
local is_noice_compatible = vim.fn.has('nvim-0.10') == 1
if is_noice_compatible then
	require("noice").setup({
		lsp = {
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
			},
		},
		presets = {
			bottom_search = true,
			command_palette = true,
			long_message_to_split = true,
			inc_rename = false,
			lsp_doc_border = false,
		},
	})
else
	print("Noice désactivé : nécessite Neovim 0.10+")
end

-- Neogit
local is_neogit_compatible = vim.fn.has('nvim-0.10') == 1
if is_neogit_compatible then
	require('neogit').setup({
		-- Neogit configuration
		integrations = {
			diffview = true,
		},
		-- Configuration des commandes git courantes
		mappings = {
			status = {
				["q"] = "Close",
				["1"] = "Stage",
				["2"] = "Unstage",
				["3"] = "Discard",
				["c"] = "CommitPopup",
				["p"] = "PushPopup",
				["l"] = "LogPopup",
			},
		},
	})
else
	print("Neogit désactivé : nécessite Neovim 0.10+")
end

-- Comment 
require('Comment').setup()

-- Fern
vim.g['fern#renderer'] = 'nerdfont'

-- Fern -- Preview -- disable 'modifiable'
vim.g.preview_nvim_disable_sync = 1

-- Theme
-- vim.cmd [[colorscheme moonfly]]
-- vim.cmd [[colorscheme tokyonight-storm]]

-- Barbar configuration
require('barbar').setup()

-- Airline configuration
vim.g.airline_powerline_fonts = 1
vim.g.airline_theme = 'moonfly'
vim.g.airline_section_z = '%3p%% %3l/%L:%3v'

-- Telescope Configuration
require('telescope').setup {
	defaults = {
		prompt_prefix = " ",
		selection_caret = " ",
		path_display = { "smart" },
		file_ignore_patterns = { ".git/", "node_modules", "vendor" },
		mappings = {
			i = {
				["<C-n>"] = "move_selection_next",
				["<C-p>"] = "move_selection_previous",
				["<C-c>"] = "close",
				["<C-j>"] = "cycle_history_next",
				["<C-k>"] = "cycle_history_prev",
				["<C-q>"] = "send_to_qflist",
			}
		}
	},
	pickers = {
		find_files = {
			hidden = true
		}
	},
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		}
	}
}

-- MAPPING
-- Fern
km.set("n", "<leader>ee", ":Fern . -drawer -width=60 -toggle<CR>", { silent = true, noremap = true })
km.set("n", "<leader>es", ":Fern . -reveal=% -drawer -width=60 -toggle<CR>", { silent = true, noremap = true })

-- Comment.nvim mappings
km.set("n", "<leader>cc", "gcc", { noremap = false })
km.set("v", "<leader>c", "gc", { noremap = false })

-- Barbar mappings
-- Move to previous/next
km.set('n', '<A-,>', '<Cmd>BufferPrevious<CR>', { silent = true })
km.set('n', '<A-.>', '<Cmd>BufferNext<CR>', { silent = true })
-- Re-order to previous/next
km.set('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', { silent = true })
km.set('n', '<A->>', '<Cmd>BufferMoveNext<CR>', { silent = true })
-- Close buffer
km.set('n', '<A-c>', '<Cmd>BufferClose<CR>', { silent = true })

-- Telescope mappings
km.set('n', '<leader>ff', ':Telescope find_files<CR>', { silent = true, noremap = true })
km.set('n', '<leader>fg', ':Telescope live_grep<CR>', { silent = true, noremap = true })
km.set('n', '<leader>fb', ':Telescope buffers<CR>', { silent = true, noremap = true })
km.set('n', '<leader>fh', ':Telescope help_tags<CR>', { silent = true, noremap = true })
km.set('n', '<leader>fs', ':Telescope current_buffer_fuzzy_find<CR>', { silent = true, noremap = true })
km.set('n', '<leader>fp', ':Telescope projects<CR>', { silent = true, noremap = true })
km.set('n', '<leader>fc', ':Telescope colorscheme<CR>', { silent = true, noremap = true })
km.set('n', '<leader>fd', ':Telescope diagnostics<CR>', { silent = true, noremap = true })
km.set('n', '<leader>fo', ':Telescope oldfiles<CR>', { silent = true, noremap = true })

-- Markdown preview
km.set('n', '<leader>mp', ':MarkdownPreview<CR>', { silent = true, noremap = true })
km.set('n', '<leader>ms', ':MarkdownPreviewStop<CR>', { silent = true, noremap = true })

-- Auto Indentation settings
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.cindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smarttab = true

-- Fern -- Preview -- enable 'modifiable' temporarily
vim.cmd [[
augroup FernPreview
autocmd!
autocmd FileType fern-preview setlocal modifiable
augroup END
]]

-- Ensure Fern Preview works
vim.cmd [[
autocmd FileType fern setlocal nobuflisted
]]

-- Configuration de WhichKey selon les dernières recommandations
require("which-key").setup()

-- Utilisation de la méthode add() recommandée dans la V3
local wk = require("which-key")
wk.add({
	-- Groupes
	{ "<leader>f", group = "Telescope" },
	{ "<leader>e", group = "Explorer" },
	{ "<leader>m", group = "Markdown" },
	{ "<leader>c", group = "Comment" },
	{ "<leader>g", group = "Git" },

	-- Raccourcis Telescope
	{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
	{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
	{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
	{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
	{ "<leader>fs", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search in Buffer" },
	{ "<leader>fp", "<cmd>Telescope projects<cr>", desc = "Projects" },
	{ "<leader>fc", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme" },
	{ "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
	{ "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },

	-- Raccourcis Explorer
	{ "<leader>ee", "<cmd>Fern . -drawer -width=60 -toggle<cr>", desc = "Toggle Explorer" },
	{ "<leader>es", "<cmd>Fern . -reveal=% -drawer -width=60 -toggle<cr>", desc = "Show Current File" },

	-- Raccourcis Markdown
	{ "<leader>mp", "<cmd>MarkdownPreview<cr>", desc = "Preview Markdown" },
	{ "<leader>ms", "<cmd>MarkdownPreviewStop<cr>", desc = "Stop Preview" },

	-- Raccourcis Comment
	{ "<leader>cc", "gcc", desc = "Comment Line" },

	-- Raccourcis Git
	{ "<leader>gs", "<cmd>Neogit<cr>", desc = "Status" },
	{ "<leader>gr", "<cmd>GrugFar<cr>", desc = "Find and Replace" },

	-- Autres raccourcis
	{ "<leader>?", "<cmd>Cheatsheet<cr>", desc = "Cheatsheet" },
})

-- Cheatsheet.nvim configuration
require('cheatsheet').setup({
	bundled_cheatsheets = true,
	bundled_plugin_cheatsheets = true,
	include_only_installed_plugins = true,
	telescope_mappings = {
		['<CR>'] = require('cheatsheet.telescope.actions').select_or_fill_commandline,
		['<A-CR>'] = require('cheatsheet.telescope.actions').select_or_execute,
		['<C-Y>'] = require('cheatsheet.telescope.actions').copy_cheat_value,
		['<C-E>'] = require('cheatsheet.telescope.actions').edit_user_cheatsheet,
	}
})

-- Grug-far.nvim configuration
local is_grugfar_compatible = vim.fn.has('nvim-0.10') == 1
if is_grugfar_compatible then
	require('grug-far').setup()
else
	print("Grug-far désactivé : nécessite Neovim 0.10+")
end

-- Mappings
km.set('n', '<leader>?', ':Cheatsheet<CR>', { silent = true, noremap = true })
km.set('n', '<leader>gs', ':Neogit<CR>', { silent = true, noremap = true })
km.set('n', '<leader>gr', ':GrugFar<CR>', { silent = true, noremap = true })


