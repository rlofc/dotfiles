local M = {
  "levouh/tint.nvim",
  -- "TaDaa/vimade",
  -- event = "VimEnter",
  --
  -- event = "BufEnter",
  -- priority = 1002, -- make sure to load this before all the other start plugins
}

function M.config()
  require("tint").setup({
    tint = -25,       -- Darken colors, use a positive value to brighten
    saturation = 0.4, -- Saturation to preserve
    -- transforms = require("tint").transforms.SATURATE_TINT,      -- Showing default behavior, but value here can be predefined set of transforms
    transforms = {
      require("tint.transforms").saturate(0.5),
      require("tint.transforms").tint_with_threshold(-100, "#000000", 200),
      function(r, g, b, hl_group_info)
        -- print("Higlight group name: " .. hl_group_info.hl_group_name)
        -- local hl_def = vim.api.nvim_get_hl_by_name(hl_group_info.hl_group_name)
        -- print("Highlight group definition: " .. vim.inspect(hl_def))
        if hl_group_info.hl_group_name == 'LineNr' then
          return 14 + 2, 14 + 2, 22 + 3
        end
        return r, g, b
      end
    },
    tint_background_colors = false,                             -- Tint background portions of highlight groups
    highlight_ignore_patterns = { "WinSeparator", "Status.*" }, -- Highlight group patterns to ignore, see `string.find`
    window_ignore_function = function(winid)
      local bufid = vim.api.nvim_win_get_buf(winid)
      local buftype = vim.api.nvim_buf_get_option(bufid, "buftype")
      local floating = vim.api.nvim_win_get_config(winid).relative ~= ""

      -- Do not tint `terminal` or floating windows, tint everything else
      return buftype == "terminal" or floating
    end
  })
  vim.cmd [[
    " let g:vimade.fadelevel = 0.3
    " let g:vimade.enablesigns = 1
    " let g:vimade.enabletreesitter = 1
  ]]
end

return M
