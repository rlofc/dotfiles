local M = {
  "folke/which-key.nvim",
  event = "VeryLazy",
}

function M.config()
  require("which-key").setup {
    icons = {
      separator = " 🡒  "
    },
  }

  require("which-key").register({
    ["<leader>g"] = {
      name = "+git"
    }
  })
  require("which-key").register({
    ["<leader>l"] = {
      name = "+LSP"
    }
  })
  require("which-key").register({
    ["<leader>c"] = {
      name = "+config"
    }
  })
  require("which-key").register({
    ["<leader>f"] = {
      name = "+find"
    }
  })
  require("which-key").register({
    ["<leader>d"] = {
      name = "+DAP"
    }
  })
  require("which-key").register({
    ["<leader>o"] = {
      name = "+overseer"
    }
  })

end

return M
