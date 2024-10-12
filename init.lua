--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Detect the operating system
local is_mac = vim.fn.has("macunix") == 1
local is_linux = vim.fn.has("unix") == 1 and not is_mac
local is_win = vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1

-- Set the clipboard provider based on the operating system
if is_mac then
	vim.g.clipboard = {
		name = "pbcopy",
		copy = { ["+"] = "pbcopy", ["*"] = "pbcopy" },
		paste = { ["+"] = "pbpaste", ["*"] = "pbpaste" },
		cache_enabled = 1,
	}
elseif is_linux then
	vim.g.clipboard = {
		name = "xclip",
		copy = { ["+"] = "xclip -selection clipboard", ["*"] = "xclip -selection clipboard" },
		paste = { ["+"] = "xclip -selection clipboard -o", ["*"] = "xclip -selection clipboard -o" },
		cache_enabled = 1,
	}
elseif is_win then
	vim.g.clipboard = {
		name = "win32yank",
		copy = { ["+"] = "clip.exe", ["*"] = "clip.exe" },
		paste = { ["+"] = "powershell -command Get-Clipboard", ["*"] = "powershell -command Get-Clipboard" },
		cache_enabled = 1,
	}
end

--  LSP sign stuff
local signs = {
	Error = "",
 	Warn = "",
 	Hint = "",
 	Info = "",
}

for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Customize diagnostic appearance
vim.diagnostic.config({
	virtual_text = {
		prefix = "●", -- Could be '■', '▎', 'x'
	},
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})

-- [[ Setting options ]]
-- NOTE: You can change these options as you wish!

vim.opt.number = true

vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false -- Disable folding at startup
vim.opt.foldlevel = 99 -- Set a high fold level to keep folds open by default

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
vim.opt.clipboard = "unnamedplus"

-- default indentation 4
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250
-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Enable spell checking
vim.opt.spell = true
vim.opt.spelllang = { "en_us" }

-- Spell-check key mappings
vim.keymap.set("n", "<leader>sc", ":set spell!<CR>", { desc = "Toggle [S]pell [C]hecking" })
vim.keymap.set("n", "[s", "[s", { desc = "Go to previous misspelled word" })
vim.keymap.set("n", "]s", "]s", { desc = "Go to next misspelled word" })
vim.keymap.set("n", "z=", "z=", { desc = "Show spelling suggestions" })

-- Don't show depracated warnings
vim.deprecate = function() end

-- custom
vim.keymap.set("n", "<leader>po", "<cmd>Vex<CR>", { desc = "[P]roject [O]pen vertically" })
vim.keymap.set("n", "<leader><CR>", "<cmd>Lazy sync<CR>")
vim.keymap.set("n", "<leader>Y", 'gg"+yG', { silent = true })
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>Y", 'gg"+yG', { silent = true })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<CR>", { desc = "[U]ndo tree toggle" })
vim.keymap.set("v", "<leader>p", '"_dP', { noremap = true }) -- replace what is selected with the yanked text from default register
vim.keymap.set("n", "<leader>j", ":cnext<CR>", { noremap = true, silent = true, desc = "Next quickfix item" })
vim.keymap.set("n", "<leader>k", ":cprev<CR>", { noremap = true, silent = true, desc = "Previous quickfix item" })
vim.keymap.set("n", "<leader>st", ":NvimTreeToggle<CR>", { desc = "[S]idebar [T]oggle" })
vim.keymap.set(
	"n",
	"<leader>D",
	":%d _<CR>",
	{ noremap = true, silent = true, desc = "[D]elete whole content to blackhole" }
)
vim.keymap.set("n", "<leader>W", ":w<CR>", { noremap = true, silent = true, desc = "[W]rite" })
vim.keymap.set("n", "<leader>X", ":x<CR>", { noremap = true, silent = true, desc = "E[x]it" })
vim.keymap.set("n", "<leader>Q", ":q<CR>", { noremap = true, silent = true, desc = "[Q]uit" })
vim.keymap.set("n", "x", '"_x', { noremap = true, silent = true })

-- Set highlight on earch, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<leader>no", "<cmd>nohlsearch<CR>", { desc = "[NO] highlight" })

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Highlight when yanking text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	"tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically

	"mbbill/undotree", -- Undo tree

	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = "nvim-treesitter/nvim-treesitter",
		opts = {
			enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
			max_lines = 10, -- How many lines the window should span. Values <= 0 mean no limit.
			trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
			patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
				-- For all filetypes
				-- Note that setting an entry here replaces all other patterns for this entry.
				-- By setting the 'default' entry below, you can control which nodes you want to
				-- appear in the context window.
				default = {
					"class",
					"function",
					"method",
					"for",
					"while",
					"if",
					"switch",
					"case",
				},
			},
			zindex = 20, -- The Z-index of the context window
		},
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			indent = {
				char = "┊", -- This is a thinner character
				highlight = "IblIndent",
			},
			scope = {
				char = "┊",
				highlight = "IblScope",
				show_start = true,
				show_end = true,
			},
			whitespace = {
				remove_blankline_trail = false, -- Keep indentation on blank lines
			},
		},
	},

	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("nvim-tree").setup({
				renderer = {
					icons = {
						webdev_colors = true,
						git_placement = "before",
						padding = " ",
						symlink_arrow = " ➛ ",
						show = {
							file = true,
							folder = true,
							folder_arrow = true,
							git = true,
						},
						glyphs = {
							default = "",
							symlink = "",
							folder = {
								arrow_closed = "📁",
								arrow_open = "📂",
								default = "",
								open = "",
								empty = "",
								empty_open = "",
								symlink = "",
								symlink_open = "",
							},
							git = {
								unstaged = "✗",
								staged = "✓",
								unmerged = "",
								renamed = "➜",
								untracked = "★",
								deleted = "",
								ignored = "◌",
							},
						},
					},
					special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
					symlink_destination = true,
				},
				hijack_directories = {
					enable = true,
					auto_open = false,
				},
				git = {
					enable = true,
					ignore = false,
					show_on_dirs = true,
					show_on_open_dirs = true,
					timeout = 400,
				},
				open_on_tab = false,
				actions = {
					open_file = {
						quit_on_open = true,
					},
				},
			})

			vim.api.nvim_create_autocmd("VimEnter", {
				callback = function(data)
					local directory = vim.fn.isdirectory(data.file) == 1
					if directory then
						require("nvim-tree.api").tree.open()
					end
				end,
			})
		end,
	},

	"tpope/vim-fugitive",

	{
		"github/copilot.vim",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			-- Disable copilot by default
			vim.g.copilot_enabled = false

			-- Create commands and keymaps to enable/disable Copilot
			vim.api.nvim_create_user_command("EnableCopilot", function()
				vim.cmd("Copilot enable")
				print("Copilot enabled")
			end, {})

			vim.api.nvim_create_user_command("DisableCopilot", function()
				vim.cmd("Copilot disable")
				print("Copilot disabled")
			end, {})

			-- Add keymaps
			vim.keymap.set(
				"n",
				"<leader>ce",
				":EnableCopilot<CR>",
				{ noremap = true, silent = true, desc = "Enable Copilot" }
			)
			vim.keymap.set(
				"n",
				"<leader>cd",
				":DisableCopilot<CR>",
				{ noremap = true, silent = true, desc = "Disable Copilot" }
			)
		end,
	},

	-- "gc" to comment visual regions/lines
	{ "numToStr/Comment.nvim", opts = {} },

	{ -- Adds git related signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},

	{ -- Fuzzy Finder (files, lsp, etc)
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ -- If encountering errors, see telescope-fzf-native README for installation instructions
				"nvim-telescope/telescope-fzf-native.nvim",

				-- `build` is used to run some command when the plugin is installed/updated.
				-- This is only run then, not every time Neovim starts up.
				build = "make",

				-- `cond` is a condition used to determine whether this plugin should be
				-- installed and loaded.
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},

			{
				"nvim-telescope/telescope-ui-select.nvim",
			},

			{
				"nvim-tree/nvim-web-devicons",
				enabled = vim.g.have_nerd_font,
			},
		},
		config = function()
			-- [[ Configure Telescope ]]
			require("telescope").setup({
				--  All the info you're looking for is in `:help telescope.setup()`
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})

			-- Enable Telescope extensions if they are installed
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")

			-- See `:help telescope.builtin`
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
			vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
			vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
			vim.keymap.set("n", "<leader>gf", builtin.git_files, { desc = "search [G]it [F]iles" })
			vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
			vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
			vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
			vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
			vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
			vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
			vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
			-- [[ start of additional custom keymaps for telescope ]]
			vim.keymap.set("n", "<leader>cs", builtin.colorscheme, { desc = "[C]olor [S]cheme" })

			-- Slightly advanced example of overriding default behavior and theme
			vim.keymap.set("n", "<leader>/", function()
				-- You can pass additional configuration to Telescope to change the theme, layout, etc.
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end, { desc = "[/] Fuzzily search in current buffer" })

			-- It's also possible to pass additional configuration options.
			--  See `:help telescope.builtin.live_grep()` for information about particular keys
			vim.keymap.set("n", "<leader>s/", function()
				builtin.live_grep({
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				})
			end, { desc = "[S]earch [/] in Open Files" })

			-- Shortcut for searching your Neovim configuration files
			vim.keymap.set("n", "<leader>sn", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "[S]earch [N]eovim files" })
		end,
	},

	{ -- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        signs = true,
      },
    },
		dependencies = {
			-- Automatically install LSPs and related tools to stdpath for Neovim
			{ "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			{ "j-hui/fidget.nvim", opts = {} },

			{ "folke/neodev.nvim", opts = {} },
		},
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					--  To jump back, press <C-t>.
					map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

					-- Find references for the word under your cursor.
					map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

					-- Jump to the implementation of the word under your cursor.
					--  Useful when your language has ways of declaring types without an actual implementation.
					map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

					-- Fuzzy find all the symbols in your current document.
					--  Symbols are things like variables, functions, types, etc.
					map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

					-- Fuzzy find all the symbols in your current workspace.
					--  Similar to document symbols, except searches over your entire project.
					map(
						"<leader>ws",
						require("telescope.builtin").lsp_dynamic_workspace_symbols,
						"[W]orkspace [S]ymbols"
					)

					-- Rename the variable under your cursor.
					--  Most Language Servers support renaming across files, etc.
					map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

					-- Execute a code action, usually your cursor needs to be on top of an error
					-- or a suggestion from your LSP for this to activate.
					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

					-- Opens a popup that displays documentation about the word under your cursor
					--  See `:help K` for why this keymap.
					map("K", vim.lsp.buf.hover, "Hover Documentation")

					-- WARN: This is not Goto Definition, this is Goto Declaration.
					--  For example, in C this would take you to the header.
					map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

					-- When you move your cursor, the highlights will be cleared (the second autocommand).
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.server_capabilities.documentHighlightProvider then
						local highlight_augroup =
							vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
							end,
						})
					end

					if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
						end, "[T]oggle Inlay [H]ints")
					end
				end,
			})

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
			--  - settings (table): Override the default settings passed when initializing the server.
			--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
			local servers = {
				clangd = {},
				gopls = {},
				csharp_ls = {},
				jdtls = {},
				pyright = {},
				rust_analyzer = {},
				solargraph = {},
				tsserver = {},

				lua_ls = {
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
							-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
							diagnostics = { disable = { "missing-fields" } },
						},
					},
				},
			}

			--  You can press `g?` for help in this menu.
			require("mason").setup()

			-- You can add other tools here that you want Mason to install
			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua", -- Used to format Lua code
				"prettierd", -- Used to format JavaScript, TypeScript, etc.
				"prettier", -- Used to format JavaScript, TypeScript, etc.
			})
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			-- require("mason-tool-installer").setup({
			-- 	ensure_installed = {
			-- 		"debugpy", -- Python debugger
			-- 		"node-debug2-adapter", -- Node.js debugger
			-- 		"java-debug-adapter", -- Java debugger
			-- 		"java-test", -- Java test runner
			-- 		"netcoredbg", -- .NET Core debugger
			-- 	},
			-- })

			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},

	-- Debugging
	-- {
	-- 	"mfussenegger/nvim-dap",
	-- 	dependencies = {
	-- 		"rcarriga/nvim-dap-ui",
	-- 		"nvim-telescope/telescope-dap.nvim",
	-- 		"mfussenegger/nvim-dap-python", -- Python
	-- 		"microsoft/vscode-node-debug2", -- Node.js
	-- 		"mfussenegger/nvim-jdtls", -- Java
	-- 	},
	-- 	config = function()
	-- 		local dap = require("dap")
	-- 		local dapui = require("dapui")
	--
	-- 		dapui.setup()
	--
	-- 		dap.listeners.after.event_initialized["dapui_config"] = function()
	-- 			dapui.open()
	-- 		end
	-- 		dap.listeners.before.event_terminated["dapui_config"] = function()
	-- 			dapui.close()
	-- 		end
	-- 		dap.listeners.before.event_exited["dapui_config"] = function()
	-- 			dapui.close()
	-- 		end
	--
	-- 		-- Keymaps
	-- 		vim.keymap.set("n", "<F5>", function()
	-- 			dap.continue()
	-- 		end)
	-- 		vim.keymap.set("n", "<F10>", function()
	-- 			dap.step_over()
	-- 		end)
	-- 		vim.keymap.set("n", "<F11>", function()
	-- 			dap.step_into()
	-- 		end)
	-- 		vim.keymap.set("n", "<F12>", function()
	-- 			dap.step_out()
	-- 		end)
	-- 		vim.keymap.set("n", "<Leader>b", function()
	-- 			dap.toggle_breakpoint()
	-- 		end)
	-- 		vim.keymap.set("n", "<Leader>B", function()
	-- 			dap.set_breakpoint()
	-- 		end)
	-- 		vim.keymap.set("n", "<Leader>lp", function()
	-- 			dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
	-- 		end)
	-- 		vim.keymap.set("n", "<Leader>dr", function()
	-- 			dap.repl.open()
	-- 		end)
	-- 		vim.keymap.set("n", "<Leader>dl", function()
	-- 			dap.run_last()
	-- 		end)
	--
	-- 		-- C
	-- 		dap.adapters.cppdbg = {
	-- 			id = "cppdbg",
	-- 			type = "executable",
	-- 			command = "/path/to/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
	-- 		}
	-- 		dap.configurations.c = {
	-- 			{
	-- 				name = "Launch file",
	-- 				type = "cppdbg",
	-- 				request = "launch",
	-- 				program = function()
	-- 					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
	-- 				end,
	-- 				cwd = "${workspaceFolder}",
	-- 				stopOnEntry = true,
	-- 			},
	-- 		}
	--
	-- 		-- Python
	-- 		require("dap-python").setup("python")
	--
	-- 		-- TypeScript/JavaScript (including TSX/JSX)
	-- 		dap.adapters.node2 = {
	-- 			type = "executable",
	-- 			command = "node",
	-- 			args = { os.getenv("HOME") .. "/path/to/vscode-node-debug2/out/src/nodeDebug.js" },
	-- 		}
	-- 		dap.configurations.typescript = {
	-- 			{
	-- 				name = "Launch",
	-- 				type = "node2",
	-- 				request = "launch",
	-- 				program = "${file}",
	-- 				cwd = vim.fn.getcwd(),
	-- 				sourceMaps = true,
	-- 				protocol = "inspector",
	-- 				console = "integratedTerminal",
	-- 			},
	-- 		}
	-- 		dap.configurations.javascript = dap.configurations.typescript
	-- 		dap.configurations.typescriptreact = dap.configurations.typescript
	-- 		dap.configurations.javascriptreact = dap.configurations.typescript
	--
	-- 		-- Node.js
	-- 		dap.configurations.javascript = {
	-- 			{
	-- 				name = "Launch",
	-- 				type = "node2",
	-- 				request = "launch",
	-- 				program = "${file}",
	-- 				cwd = vim.fn.getcwd(),
	-- 				sourceMaps = true,
	-- 				protocol = "inspector",
	-- 				console = "integratedTerminal",
	-- 			},
	-- 			{
	-- 				name = "Attach to process",
	-- 				type = "node2",
	-- 				request = "attach",
	-- 				processId = require("dap.utils").pick_process,
	-- 			},
	-- 		}
	--
	-- 		-- Java
	-- 		-- This requires nvim-jdtls to be properly set up
	-- 		-- The configuration for Java debugging will be handled by nvim-jdtls
	--
	-- 		-- C#
	-- 		dap.adapters.coreclr = {
	-- 			type = "executable",
	-- 			command = "/path/to/netcoredbg",
	-- 			args = { "--interpreter=vscode" },
	-- 		}
	-- 		dap.configurations.cs = {
	-- 			{
	-- 				type = "coreclr",
	-- 				name = "launch - netcoredbg",
	-- 				request = "launch",
	-- 				program = function()
	-- 					return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
	-- 				end,
	-- 			},
	-- 		}
	-- 	end,
	-- },
	--
	-- { -- Autoformat
	-- 	"stevearc/conform.nvim",
	-- 	lazy = false,
	-- 	keys = {
	-- 		{
	-- 			"<leader>f",
	-- 			function()
	-- 				require("conform").format({ async = true, lsp_fallback = true })
	-- 			end,
	-- 			mode = "",
	-- 			desc = "[F]ormat buffer",
	-- 		},
	-- 	},
	-- 	opts = {
	-- 		notify_on_error = true,
	-- 		format_on_save = true,
	-- 		formatters_by_ft = {
	-- 			lua = { "stylua" },
	-- 			python = { "isort", "black" },
	-- 			javascript = { { "prettierd", "prettier" } },
	-- 			typescript = { { "prettierd", "prettier" } },
	-- 			javascriptreact = { { "prettierd", "prettier" } },
	-- 			typescriptreact = { { "prettierd", "prettier" } },
	-- 			json = { { "prettierd", "prettier" } },
	-- 			jsonc = { { "prettierd", "prettier" } },
	-- 			yaml = { { "prettierd", "prettier" } },
	-- 			markdown = { { "prettierd", "prettier" } },
	-- 			html = { { "prettierd", "prettier" } },
	-- 			css = { { "prettierd", "prettier" } },
	-- 			scss = { { "prettierd", "prettier" } },
	-- 			graphql = { { "prettierd", "prettier" } },
	-- 		},
	-- 	},
	-- },

	{
		"mfussenegger/nvim-jdtls",
		ft = "java", -- java development
	},

	{ -- Autocompletion
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				build = (function()
					if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
						return
					end
					return "make install_jsregexp"
				end)(),
				dependencies = {},
			},
			"saadparwaiz1/cmp_luasnip",

			-- Adds other completion capabilities.
			--  nvim-cmp does not ship with all sources by default. They are split
			--  into multiple repos for maintenance purposes.
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
		},
		config = function()
			-- See `:help cmp`
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			luasnip.config.setup({})

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				completion = { completeopt = "menu,menuone,noinsert" },

				mapping = cmp.mapping.preset.insert({

					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),

					-- Scroll the documentation window [b]ack / [f]orward
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),

					-- Accept ([y]es) the completion.
					["<C-y>"] = cmp.mapping.confirm({ select = true }),

					-- Tradition enter/tab completion
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping.select_next_item(),
					["<S-Tab>"] = cmp.mapping.select_prev_item(),

					["<C-Space>"] = cmp.mapping.complete({}),

					["<C-l>"] = cmp.mapping(function()
						if luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						end
					end, { "i", "s" }),
					["<C-h>"] = cmp.mapping(function()
						if luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						end
					end, { "i", "s" }),

					-- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
					--    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
				}),
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
				},
			})
		end,
	},

	-- [[ COLORSCHEMES ]]

	{
		-- github dark theme configuration
		{
			"vv9k/vim-github-dark",
			priority = 1,
			init = function()
				-- vim.cmd.colorscheme("ghdark")
				vim.cmd.hi("Comment gui=none")
			end,
		},

		{
			"folke/tokyonight.nvim",
			priority = 2,
			init = function()
				-- vim.cmd.colorscheme("tokyonight")
				vim.cmd.hi("Comment gui=none")
			end,
		},

		-- Rose Pine configuration (default)
		{
			"rose-pine/neovim",
			name = "rose-pine",
			priority = 4,
			config = function()
				require("rose-pine").setup({
					variant = "main",
					dark_variant = "auto",
					dim_inactive_windows = false,
					extend_background_behind_borders = true,

					enable = {
						terminal = true,
						legacy_highlights = true,
						migrations = true,
					},

					styles = {
						bold = true,
						italic = false,
						transparency = true,
					},

					highlight_groups = {
						-- Comment = { fg = "foam" },
						-- VertSplit = { fg = "muted", bg = "muted" },
					},

					before_highlight = function(group, highlight, palette)
						-- Your before_highlight function here
					end,
				})
				vim.cmd("colorscheme rose-pine-main")
			end,
		},

		{
			"catppuccin/nvim",
			name = "catppuccin",
			priority = 3,
			config = function()
				require("catppuccin").setup({
					-- if anything
				})
				-- vim.cmd("colorscheme catppuccin")
				-- vim.cmd("highlight Normal guibg=#000000")
			end,
		},
	},

	{ -- Collection of various small independent plugins/modules
		"echasnovski/mini.nvim",
		config = function()
			-- Better Around/Inside textobjects
			--
			-- Examples:
			--  - va)  - [V]isually select [A]round [)]paren
			--  - yinq - [Y]ank [I]nside [N]ext [']quote
			--  - ci'  - [C]hange [I]nside [']quote
			require("mini.ai").setup({ n_lines = 500 })

			-- Add/delete/replace surroundings (brackets, quotes, etc.)
			--
			-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
			-- - sd'   - [S]urround [D]elete [']quotes
			-- - sr)'  - [S]urround [R]eplace [)] [']
			require("mini.surround").setup()

			-- Simple and easy statusline.
			--  You could remove this setup call if you don't like it,
			--  and try some other statusline plugin
			local statusline = require("mini.statusline")
			-- set use_icons to true if you have a Nerd Font
			statusline.setup({
				use_icons = vim.g.have_nerd_font,
				content = {
					active = function()
						local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })
						local git = statusline.section_git({ trunc_width = 75 })
						local diagnostics = statusline.section_diagnostics({ trunc_width = 75 })
						local filename = statusline.section_filename({ trunc_width = 140 })
						local fileinfo = statusline.section_fileinfo({ trunc_width = 120 })
						local location = statusline.section_location({ trunc_width = 75 })

						return statusline.combine_groups({
							{ hl = mode_hl, strings = { mode } },
							{ hl = "MiniStatuslineDevinfo", strings = { git, diagnostics } },
							"%<", -- Mark general truncate point
							{ hl = "MiniStatuslineFilename", strings = { filename } },
							"%=", -- End left alignment
							{ hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
							{ hl = mode_hl, strings = { location } },
						})
					end,
				},
			})

			local function get_git_branch()
				local branch = vim.fn.system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
				if vim.v.shell_error ~= 0 then
					return ""
				end
				return branch
			end

			statusline.section_git = function()
				local branch = get_git_branch()
				return branch ~= "" and "  " .. branch or ""
			end

			-- You can configure sections in the statusline by overriding their
			-- default behavior. For example, here we set the section for
			-- cursor location to LINE:COLUMN
			---@diagnostic disable-next-line: duplicate-set-field
			statusline.section_location = function()
				return "%2l:%-2v"
			end

			-- ... and there is more!
			--  Check out: https://github.com/echasnovski/mini.nvim
		end,
	},
	{ -- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			ignore_install = { "ejs" },
			ensure_installed = {
				"bash",
				"c",
				"c_sharp",
				"cpp",
				"diff",
				"html",
				"css",
				"sql",
				"lua",
				"markdown",
				"vim",
				"ejs",
				"json",
				"yaml",
				"typescript",
				"javascript",
				"java",
				"ruby",
				"python",
				"rust",
				"go",
				"java",
				"php",
				"graphql",
				"toml",
				"svelte",
			},
			-- Autoinstall languages that are not installed
			auto_install = true,
			highlight = {
				enable = true,
				-- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
				--  If you are experiencing weird indenting issues, add the language to
				--  the list of additional_vim_regex_highlighting and disabled languages for indent.
				additional_vim_regex_highlighting = { "ruby" },
			},
			indent = { enable = true, disable = { "ruby" } },
		},
		config = function(_, opts)
			-- [[ Configure Treesitter ]] See `:help nvim-treesitter`

			-- Prefer git instead of curl in order to improve connectivity in some environments
			require("nvim-treesitter.install").prefer_git = true
			---@diagnostic disable-next-line: missing-fields
			require("nvim-treesitter.configs").setup(opts)

			-- There are additional nvim-treesitter modules that you can use to interact
			-- with nvim-treesitter. You should go explore a few and see what interests you:
			--
			--    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
			--    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
			--    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
		end,
	},
}, {
	ui = {
		-- If you are using a Nerd Font: set icons to an empty table which will use the
		-- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
