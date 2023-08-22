-- vim options
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = true
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_tab_fallback = ""

-- vim.g.python3_host_prog = '~/.pyenv/versions/neovim3/bin/python'
vim.fn.setenv("FIG_TERM", nil)

vim.api.nvim_create_user_command(
  "DiffCommitLine",
  "lua require('telescope').extensions.advanced_git_search.diff_commit_line()",
  { range = true }
)

-- vim.api.nvim_set_keymap(
--   "v",
--   "<leader>dcl",
--   ":DiffCommitLine<CR>",
--   { noremap = true }
-- )

-- general
lvim.log.level = "info"
lvim.format_on_save = {
  enabled = true,
  -- pattern = "*.lua",
  timeout = 1000,
}

lvim.autocommands = {
  {
    "BufEnter",                       -- see `:h autocmd-events`
    {
      command = "silent! %foldopen!", -- see `:h :foldopen`
    }
  },
}

-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false
-- keymappings <https://www.lunarvim.org/docs/configuration/keybindings>
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w!<cr>"
lvim.keys.insert_mode["<C-s>"] = "<Esc>:w!<cr>"
lvim.keys.normal_mode["<M-cr>"] = ":TypescriptAddMissingImports<cr>"
-- Press jk fast to enter
lvim.keys.insert_mode['jk'] = '<Esc>'
lvim.keys.normal_mode['<C-n>'] = ':NvimTreeFocus<CR>'
lvim.keys.normal_mode['<C-a>'] = ':w<CR>:%w !pbcopy<CR><CR>'
-- lvim.keys.normal_mode["<C-e>j"] = "<Plug>(easymotion-j)"
-- lvim.keys.normal_mode["<C-e>k"] = "<Plug>(easymotion-k)"
lvim.keys.normal_mode["<C-e>"] = "<Plug>(easymotion-bd-f)"
lvim.keys.insert_mode["<C-a>"] = { "copilot#Accept('<CR>')",
  { script = true, silent = true, expr = true, replace_keycodes = false } }
lvim.keys.normal_mode["<leader>rn"] = ":lua vim.lsp.buf.rename()<CR>"
-- nmap <silent> gd <Plug>(coc-definition)
-- nmap <silent> gy <Plug>(coc-type-definition)
-- nmap <silent> gi <Plug>(coc-implementation)
-- nmap <silent> gr <Plug>(coc-references)
lvim.keys.normal_mode["<leader>cgd"] = "<Plug>(coc-definition)"

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["t"] = {
  name = "Diagnostics",
  t = { "<cmd>TroubleToggle<cr>", "trouble" },
  w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "workspace" },
  d = { "<cmd>TroubleToggle document_diagnostics<cr>", "document" },
  q = { "<cmd>TroubleToggle quickfix<cr>", "quickfix" },
  l = { "<cmd>TroubleToggle loclist<cr>", "loclist" },
  r = { "<cmd>TroubleToggle lsp_references<cr>", "references" },
}
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["l"]["R"] = { "<cmd>LspRestart<CR>", "Lsp Restart" }

-- Telescope
lvim.builtin.telescope.defaults.layout_config.width = 0.95
lvim.builtin.telescope.defaults.layout_config.height = 0.95
lvim.builtin.telescope.defaults.layout_strategy = "horizontal"
lvim.builtin.telescope.on_config_done = function(telescope)
  telescope.load_extension("advanced_git_search")
end

lvim.lsp.buffer_mappings.normal_mode["gd"] = { "<cmd>Telescope lsp_definitions<cr>", "Go to Definiton" }
lvim.lsp.buffer_mappings.normal_mode["gr"] = { "<cmd>Telescope lsp_references<cr>", "Go to References" }

lvim.builtin.which_key.mappings["g"]["d"] = { "<cmd>Telescope advanced_git_search diff_commit_file<CR>",
  "Diff Commit File" }
lvim.builtin.which_key.vmappings["gd"] = {
  "<cmd>DiffCommitLine<CR>",
  "Diff Commit Line",
  noremap = true
}
lvim.builtin.which_key.vmappings["st"] = {
  "y<ESC>:Telescope live_grep default_text=<c-r>0<CR>",
  "Diff Commit Line",
  {
    silent = true,
    noremap = true
  }
}

-- Change theme settings
lvim.colorscheme = "lunar"
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true
lvim.builtin.gitsigns.opts.current_line_blame = true
lvim.builtin.gitsigns.opts.current_line_blame_opts = {
  vitr_text = true,
  vitr_text_pos = "eol",
  delay = 100,
  ignore_whitespace = true
}
lvim.builtin.gitsigns.opts.watch_gitdir = { interval = 100 }
-- -- always installed on startup, useful for parsers without a strict filetype
-- lvim.builtin.treesitter.ensure_installed = { "python", "comment", "markdown_inline", "regex" }
-- -- generic LSP settings <https://www.lunarvim.org/docs/languages#lsp-support>
--- disable automatic installation of servers
lvim.lsp.installer.setup.automatic_servers_installation = true
-- lvim.lsp.installer.setup.automatic_installation = true
-- local graphql_lsp_opts = {
--   filetypes = { "graphql" },
-- }

-- require("lvim.lsp.manager").setup("graphql", graphql_lsp_opts)
require("lvim.lsp.manager").setup("tailwindcss", {
  on_attach = function(client, bufnr)
    require("tailwindcss-colors").buf_attach(bufnr)
  end
})

lvim.lsp.on_attach_callback = function(client, _)
  client.server_capabilities.semanticTokensProvider = nil
end

lvim.lsp.null_ls.setup.debug = true
-- linters and formatters <https://www.lunarvim.org/docs/languages#lintingformatting>
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    command = "prettier",
    -- extra_args = { "--print-width", "100" },
    filetypes = { "typescript", "typescriptreact" },
  },
  {
    command = "ktlint",
    args = {
      "--format",
      "--stdin",
      "**/*.kt",
      "**/*.kts",
    },
    filetypes = { "kotlin" }
  }
}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {}

-- lvim.builtin.lualine.on_config_done = function(lualine)
--   local config = lualine.get_config()
--   table.insert(config.sections.lualine_c, require('pomodoro').statusline)
--   lualine.setup(config)
-- end
-- lvim.builtin.lualine.options.component_separators = { left = "", right = "" }
-- table.insert(lvim.builtin.lualine.sections.lualine_c, { "pomo#status_bar()" })
-- lvim.builtin.lualine.sections.lualine_c = { left = "", right = "" }
-- lvim.builtin.lualine.inactive_sections.lualine_c = { left = "", right = "" }

-- -- Additional Plugins <https://www.lunarvim.org/docs/plugins#user-plugins>
lvim.plugins = {
  {
    "github/copilot.vim",
  },
  -- {
  --   "Pocco81/auto-save.nvim",
  --   config = function()
  --     require("auto-save").setup()
  --   end,
  -- },
  --
  {
    "tpope/vim-surround",
  },
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function() require "lsp_signature".on_attach() end,
  -- },

  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle"
  },

  { "arthurxavierx/vim-caser" },

  {
    "jose-elias-alvarez/typescript.nvim",
    config = function()
      require("typescript").setup({
        disable_commands = false, -- prevent the plugin from creating Vim commands
        debug = false,            -- enable debug logging for commands
        go_to_source_definition = {
          fallback = true,        -- fall back to standard LSP definition on failure
        },
      })
    end
  },
  {
    "iamcco/markdown-preview.nvim",
    config = function()
      vim.fn["mkdp#util#install"]()
    end,
  },

  {
    "aaronhallaert/advanced-git-search.nvim",
    config = function()
      -- optional: setup telescope before loading the extension
      require("advanced_git_search.fzf").setup {
        -- fugitive or diffview
        diff_plugin = "fugitive",
        -- customize git in previewer
        -- e.g. flags such as { "--no-pager" }, or { "-c", "delta.side-by-side=false" }
        git_flags = {},
        -- customize git diff in previewer
        -- e.g. flags such as { "--raw" }
        git_diff_flags = {},
        -- Show builtin git pickers when executing "show_custom_functions" or :AdvancedGitSearch
        show_builtin_git_pickers = false,
      }
    end,
    dependencies = {
      "ibhagwan/fzf-lua",
      -- to show diff splits and open commits in browser
      "tpope/vim-fugitive",
      -- to open commits in browser with fugitive
      "tpope/vim-rhubarb",
      -- OPTIONAL: to replace the diff from fugitive with diffview.nvim
      -- (fugitive is still needed to open in browser)
      -- "sindrets/diffview.nvim",
    },
  },

  {
    "tpope/vim-fugitive",
    cmd = {
      "G",
      "Git",
      "Gdiffsplit",
      "Gread",
      "Gwrite",
      "Ggrep",
      "GMove",
      "GDelete",
      "GBrowse",
      "GRemove",
      "GRename",
      "Glgrep",
      "Gedit",
      "Glog",
      "Gvdiffsplit"
    },
    ft = { "fugitive" }
  },

  {
    "rmagatti/goto-preview",
    config = function()
      require('goto-preview').setup {
        width = 120,             -- Width of the floating window
        height = 25,             -- Height of the floating window
        default_mappings = true, -- Bind default mappings
        debug = false,           -- Print debug information
        opacity = nil,           -- 0-100 opacity level of the floating window where 100 is fully transparent.
        post_open_hook = nil     -- A function taking two arguments, a buffer and a window to be ran as a hook.
        -- post_open_hook = function()
        --   -- Close the current preview window with <Esc>
        --   vim.keymap.set(
        --     'n',
        --     '<Esc>',
        --     function()
        --       local current_win_handle = vim.api.nvim_get_current_win()
        --       if vim.api.nvim_win_get_var(current_win_handle, 'is-goto-preview-window') == 1 then
        --         vim.api.nvim_win_close(current_win_handle, true)
        --       end
        --     end,
        --     { buffer = true }
        --   )
        -- end,
        -- You can use "default_mappings = true" setup option
        -- Or explicitly set keybindings
        -- vim.cmd("nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>")
        -- vim.cmd("nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>")
        -- vim.cmd("nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>")
      }
    end
  },

  {
    "folke/tokyonight.nvim",
    priority = 1000,
    opts = {},
  },

  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({ '*' }, { mode = "background" })
    end,
  },

  {
    'themaxmarchuk/tailwindcss-colors.nvim',
    config = function()
      require("tailwindcss-colors").setup()
    end
  },

  {
    'wthollingsworth/pomodoro.nvim',
    dependencies = { 'MunifTanjim/nui.nvim' },
    config = function()
      require('pomodoro').setup({
        time_work = 25,
        time_break_short = 5,
        time_break_long = 20,
        timers_to_long_break = 4
      })

      local components = require "lvim.core.lualine.components"
      -- lunarvim default 에 추가
      lvim.builtin.lualine.sections.lualine_c = { components.diff, components.python_env, require('pomodoro').statusline }
      lvim.builtin.lualine.inactive_sections.lualine_c = { 'filename', require('pomodoro').statusline }
    end
  },

  -- kotlin 개발환경 설정
  -- {
  --   'beeender/Comrade',
  --   config = function()
  --     local cmd =
  --     "gsed -i 's#os.getenv(\"NVIM_LISTEN_ADDRESS\")#os.getenv(\"NVIM\")#' ~/.local/share/lunarvim/site/pack/lazy/opt/Comrade/plugin/init.py"
  --     os.execute(cmd)
  --   end,
  --   dependencies = {
  --     {
  --       'neoclide/coc.nvim',
  --       build = ':call coc#util#install()'
  --     },

  --     {
  --       'Shougo/deoplete.nvim',
  --       build = ":UpdateRemotePlugins",
  --       dependencies = {
  --         "ibhagwan/fzf-lua",
  --         -- to show diff splits and open commits in browser
  --         "roxma/nvim-yarp",
  --         -- to open commits in browser with fugitive
  --         "roxma/vim-hug-neovim-rpc",
  --         -- OPTIONAL: to replace the diff from fugitive with diffview.nvim
  --         -- (fugitive is still needed to open in browser)
  --         -- "sindrets/diffview.nvim",
  --       },
  --     },
  --   }
  -- },

  {
    'dhruvasagar/vim-table-mode'
  }


}
