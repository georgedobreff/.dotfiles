local function get_proportional_width()
  local total_cols = vim.go.columns
  return math.max(20, math.floor(total_cols * 0.15))
end

return {
  "nvim-neo-tree/neo-tree.nvim",

  opts = {
    window = {
      position = "right",

      width = get_proportional_width(),
    },
  },

  config = function(plugin, opts)
    require("neo-tree").setup(opts)

    vim.api.nvim_create_autocmd("VimResized", {
      group = vim.api.nvim_create_augroup("NeoTreeResize", { clear = true }),
      callback = function()
        -- Only recalculate if Neo-tree is actually open
        if vim.api.nvim_buf_get_name(vim.fn.bufnr("neo-tree")) ~= "" then
          local new_width = get_proportional_width()

          -- Find the Neo-tree window ID
          for _, winid in ipairs(vim.api.nvim_list_wins()) do
            if vim.api.nvim_win_get_buf(winid) == vim.fn.bufnr("neo-tree") then
              -- Set the new width for the window
              vim.api.nvim_win_set_width(winid, new_width)
              break
            end
          end
        end
      end,
    })
  end,
}
