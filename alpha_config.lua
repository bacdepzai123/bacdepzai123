local alpha = require'alpha'
local dashboard = require'alpha.themes.dashboard'

dashboard.section.header.val = {
  [[   ██████╗ ██████╗ ███████╗███████╗ █████╗ ██████╗ ████████╗]],
  [[  ██╔════╝ ██╔══██╗██╔════╝██╔════╝██╔══██╗██╔══██╗╚══██╔══╝]],
  [[  ██║  ███╗██████╔╝█████╗  █████╗  ███████║██████╔╝   ██║   ]],
  [[  ██║   ██║██╔═══╝ ██╔══╝  ██╔══╝  ██╔══██║██╔═══╝    ██║   ]],
  [[  ╚██████╔╝██║     ███████╗███████╗██║  ██║██║        ██║   ]],
  [[   ╚═════╝ ╚═╝     ╚══════╝╚══════╝╚═╝  ╚═╝╚═╝        ╚═╝   ]],
}

dashboard.section.buttons.val = {
  dashboard.button("f", "🔍  Find file", ":Telescope find_files<CR>"),
  dashboard.button("d", "📁  Find directory", ":Telescope file_browser<CR>"),
  dashboard.button("o", "🕒  Recents", ":Telescope oldfiles<CR>"),
  dashboard.button("w", "🔎  Find word", ":Telescope live_grep<CR>"),
  dashboard.button("n", "📝  New file", ":ene <BAR> startinsert <CR>"),
  dashboard.button("m", "🔖  Bookmarks", ":Telescope marks<CR>"),
  dashboard.button("s", "⟳  Load Last Session", ":lua require('persistence').load({ last = true })<CR>"),
}

dashboard.section.footer.val = "CodeArt v0.5 - Loaded 11 plugins ✨"

alpha.setup(dashboard.config)

