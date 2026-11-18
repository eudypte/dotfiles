-- lazy.nvim spec: ~/.config/nvim/lua/plugins/colorscheme.lua
-- modus_operandi = same palette as the Alacritty theme, plus Contrast-style
-- black borders and the Finder-gray (#6e6e6e) selection.
return {
  {
    "miikanissi/modus-themes.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("modus-themes").setup({
        style = "modus_operandi",
        variant = "default",
        transparent = false,
        on_highlights = function(hl, c)
          local ink, gray, white = "#000000", "#6e6e6e", "#ffffff"

          -- Pane and float borders: solid black, like the Spotify panes
          hl.WinSeparator = { fg = ink, bg = c.bg_main }
          hl.FloatBorder = { fg = ink, bg = c.bg_main }
          hl.NormalFloat = { fg = ink, bg = c.bg_main }

          -- Completion menu: white with gray selection + white text
          hl.Pmenu = { fg = ink, bg = c.bg_main }
          hl.PmenuSel = { fg = white, bg = gray, bold = true }
          hl.PmenuSbar = { bg = c.bg_main }
          hl.PmenuThumb = { bg = gray }

          -- Statusline: black rule look
          hl.StatusLine = { fg = white, bg = ink }
          hl.StatusLineNC = { fg = gray, bg = c.bg_main }

          -- Cursor line number in ink, others gray
          hl.LineNr = { fg = gray }
          hl.CursorLineNr = { fg = ink, bold = true }
        end,
      })
      vim.o.background = "light"
      vim.cmd.colorscheme("modus_operandi")

      -- Rounded black borders on floats (hover, diagnostics, etc.)
      vim.o.winborder = "rounded"
    end,
  },
}

--[[
return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
}
--]]
