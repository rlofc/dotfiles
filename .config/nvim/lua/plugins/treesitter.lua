local M = {
  "nvim-treesitter/nvim-treesitter",
  -- event = "BufReadPost",
  dependencies = {
    {
      --      "JoosepAlviste/nvim-ts-context-commentstring",
      --      event = "VeryLazy",
    },
    {
      "nvim-tree/nvim-web-devicons",
      event = "VeryLazy",
      -- commit = "0568104bf8d0c3ab16395433fcc5c1638efc25d4"
    },
  },
}
function M.config()
  local treesitter = require "nvim-treesitter"
  local configs = require "nvim-treesitter.configs"

  configs.setup {
    -- jensure_installed = { "lua", "markdown", "markdown_inline", "bash", "python", "cpp", "javascript" }, -- put the language you want in this array
    ensure_installed = "all", -- one of "all" or a list of languages
    ignore_install = { "" },  -- List of parsers to ignore installing
    sync_install = false,     -- install languages synchronously (only applied to `ensure_installed`)

    highlight = {
      enable = true,           -- false will disable the whole extension
      disable = { "hexroll" }, -- list of language that will be disabled
    },
    autopairs = {
      enable = true,
    },
    indent = { enable = true, disable = { "python", "css", "cpp", "javascript" } },


    -- context_commentstring = {
    --   enable = true,
    --   enable_autocmd = false,
    -- },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-Space>", -- set to `false` to disable one of the mappings
        node_incremental = "<C-Space>",
        scope_incremental = "grc",
        node_decremental = "grm",
      },
    },
  }
  require('ts_context_commentstring').setup {}
  vim.g.skip_ts_context_commentstring_module = true
end

return M
