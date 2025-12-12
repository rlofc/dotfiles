local M = {
  "neovim/nvim-lspconfig",
  lazy = true,
  dependencies = {
    {
      "hrsh7th/cmp-nvim-lsp",
    },
  },
}

local opts = { silent = true }
local function make_opts(o)
  return vim.tbl_extend("error", opts, o)
end


local cmp_nvim_lsp = require "cmp_nvim_lsp"




function M.config()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)
  capabilities.offsetEncoding = { "utf-16" }

  local function lsp_keymaps(bufnr)
    local opts = { noremap = true, silent = true }
    local keymap = vim.api.nvim_buf_set_keymap
    keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", make_opts({ desc = "Go to declaration" }))
    keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", make_opts({ desc = "Go to definition" }))
    keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", make_opts({ desc = "Lsp Hover" }))
    keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", make_opts({ desc = "Go to implementation" }))
    keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", make_opts({ desc = "Go to references" }))
    keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", make_opts({ desc = "Show diagnostics" }))
    keymap(bufnr, "n", "<leader>li", "<cmd>LspInfo<cr>", make_opts({ desc = "Lsp Info" }))
    keymap(bufnr, "n", "<leader>lI", "<cmd>Mason<cr>", opts)
    keymap(bufnr, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", make_opts({ desc = "Code action" }))
    keymap(bufnr, "n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>",
      make_opts({ desc = "Next diagnostics" }))
    keymap(bufnr, "n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>",
      make_opts({ desc = "Previous diagnostics" }))
    keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", make_opts({ desc = "Lsp rename" }))
    keymap(bufnr, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", make_opts({ desc = "Signature help" }))
    keymap(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>",
      make_opts({ desc = "Diagnistics quickfix" }))
  end


  local lspconfig = require "lspconfig"
  -- lspconfig.rust_analyzer.setup {
  --   settings = {
  --     ['rust-analyzer'] = {
  --       diagnostics = {
  --         enable = true,
  --       }
  --     }
  --   }
  -- }
  local on_attach = function(client, bufnr)
    --if client.name == "clangd" then
    client.server_capabilities.semanticTokensProvider = nil
    --end

    if client.name == "tsserver" then
      client.server_capabilities.documentFormattingProvider = false
    end

    if client.name == "sumneko_lua" then
      client.server_capabilities.documentFormattingProvider = false
    end

    lsp_keymaps(bufnr)
    require("illuminate").on_attach(client)
  end

  vim.g.rustaceanvim = {
    server = {
      on_attach = function(client, bufnr)
        lsp_keymaps(bufnr)
      end
    }
  }

  for _, server in pairs(require("utils").servers) do
    Opts = {
      on_attach = on_attach,
      capabilities = capabilities,
    }

    server = vim.split(server, "@")[1]

    local require_ok, conf_opts = pcall(require, "settings." .. server)
    if require_ok then
      Opts = vim.tbl_deep_extend("force", conf_opts, Opts)
    end

    lspconfig[server].setup(Opts)
  end

  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    -- disable virtual text
    virtual_text = false,
    -- show signs
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
      suffix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })

  -- Function to check if a floating dialog exists and if not
  -- then check for diagnostics under the cursor
  function OpenDiagnosticIfNoFloat()
    for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
      if vim.api.nvim_win_get_config(winid).zindex then
        return
      end
    end
    -- THIS IS FOR BUILTIN LSP
    vim.diagnostic.open_float(0, {
      scope = "cursor",
      focusable = false,
      close_events = {
        "CursorMoved",
        "CursorMovedI",
        "BufHidden",
        "InsertCharPre",
        "WinLeave",
      },
    })
  end

  -- Show diagnostics under the cursor when holding position
  vim.api.nvim_create_augroup("lsp_diagnostics_hold", { clear = true })
  vim.api.nvim_create_autocmd({ "CursorHold" }, {
    pattern = "*",
    command = "lua OpenDiagnosticIfNoFloat()",
    group = "lsp_diagnostics_hold",
  })
end

return M
