return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				-- Ensure mason installs the server
				clangd = {
					keys = {
						{ "<leader>ch", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
					},
					root_markers = {
						".clangd",
						".clang-tidy",
						".clang-format",
						"compile_commands.json",
						"compile_flags.txt",
						"configure.ac", -- AutoTools
						"Makefile",
						"configure.ac",
						"configure.in",
						"config.h.in",
						"meson.build",
						"meson_options.txt",
						"build.ninja",
						".git",
					},
					capabilities = {
						offsetEncoding = { "utf-16" },
					},
					cmd = {
						"clangd",
						"--background-index",
						"--clang-tidy",
						"--header-insertion=iwyu",
						"--completion-style=detailed",
						"--function-arg-placeholders",
						"--fallback-style=llvm",

						"--pch-storage=memory",
						"--all-scopes-completion",
						"--limit-results=0",
						"--limit-references=0",
					},
					init_options = {
						usePlaceholders = true,
						completeUnimported = true,
						clangdFileStatus = true,
					},
				},
			},
			setup = {
				clangd = function(_, opts)
					local clangd_ext_opts = LazyVim.opts("clangd_extensions.nvim")
					require("clangd_extensions").setup(
						vim.tbl_deep_extend("force", clangd_ext_opts or {}, { server = opts })
					)
					return false
				end,
			},
		},
	},
	{
		"hrsh7th/nvim-cmp",
		optional = true,
		opts = function(_, opts)
			opts.sorting = opts.sorting or {}
			opts.sorting.comparators = opts.sorting.comparators or {}
			table.insert(opts.sorting.comparators, 1, require("clangd_extensions.cmp_scores"))
		end,
	},
}

-- return {
-- 	{
-- 		"neovim/nvim-lspconfig",
-- 		opts = {
-- 			servers = {
-- 				-- Ensure mason installs the server
-- 				clangd = {
-- 					keys = {
-- 						{ "<leader>ch", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
-- 					},
-- 					root_dir = function(fname)
-- 						return require("lspconfig.util").root_pattern(
-- 							"Makefile",
-- 							"configure.ac",
-- 							"configure.in",
-- 							"config.h.in",
-- 							"meson.build",
-- 							"meson_options.txt",
-- 							"build.ninja"
-- 						)(fname) or require("lspconfig.util").root_pattern(
-- 							"compile_commands.json",
-- 							"compile_flags.txt"
-- 						)(fname) or require("lspconfig.util").find_git_ancestor(fname)
-- 					end,
-- 					capabilities = {
-- 						offsetEncoding = { "utf-16" },
-- 					},
-- 					cmd = {
-- 						"clangd",
-- 						"--background-index",
-- 						"--clang-tidy",
-- 						"--header-insertion=iwyu",
-- 						"--completion-style=detailed",
-- 						"--function-arg-placeholders",
-- 						"--fallback-style=webkit",
-- 					},
-- 					init_options = {
-- 						usePlaceholders = true,
-- 						completeUnimported = true,
-- 						clangdFileStatus = true,
-- 					},
-- 				},
-- 			},
-- 			setup = {
-- 				clangd = function(_, opts)
-- 					local clangd_ext_opts = LazyVim.opts("clangd_extensions.nvim")
-- 					require("clangd_extensions").setup(
-- 						vim.tbl_deep_extend("force", clangd_ext_opts or {}, { server = opts })
-- 					)
-- 					return false
-- 				end,
-- 			},
-- 		},
-- 	},
--
-- 	{
-- 		"hrsh7th/nvim-cmp",
-- 		opts = function(_, opts)
-- 			opts.sorting = opts.sorting or {}
-- 			opts.sorting.comparators = opts.sorting.comparators or {}
-- 			table.insert(opts.sorting.comparators, 1, require("clangd_extensions.cmp_scores"))
-- 		end,
-- 	},
-- }
