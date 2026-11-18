return {
  "ngtuonghy/live-server-nvim",
  event = "VeryLazy",
  build = ":LiveServerInstall",
  config = function()
    require("live-server-nvim").setup({
      -- Optional custom settings:
      -- custom = { "--port=8080", "--no-browser" },
      -- serverPath = vim.fn.stdpath("data") .. "/live-server/",
    })
  end,
}
