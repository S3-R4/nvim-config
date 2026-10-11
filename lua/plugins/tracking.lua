return {
  {
    "vyfor/cord.nvim",
    event = "VeryLazy",
    init = function()
      vim.g.cord_defer_startup = true
    end,
    opts = {
      editor = { client = "neovim", tooltip = "Neovim" },
      display = {
        theme = "atom",
        flavor = "dark",
        view = "full",
        swap_fields = false,
        swap_icons = false,
      },
      timestamp = {
        enabled = true,
        reset_on_idle = false,
        reset_on_change = false,
        shared = false,
      },
      idle = {
        enabled = true,
        timeout = 600000,
        show_status = true,
        ignore_focus = true,
        unidle_on_focus = true,
        smart_idle = true,
        details = "Idling",
        tooltip = "Idle",
      },
      text = {
        viewing = function(opts) return "Viewing " .. opts.filename end,
        editing = function(opts) return "Editing " .. opts.filename end,
        workspace = function(opts) return opts.workspace and ("In " .. opts.workspace) or nil end,
        file_browser = "Browsing files",
        plugin_manager = "Managing plugins",
        lsp = "Configuring language servers",
        docs = "Reading documentation",
        vcs = "Reviewing Git history",
        notes = "Taking notes",
        debug = "Debugging",
        test = "Running tests",
        diagnostics = "Reviewing diagnostics",
        terminal = "Using terminal",
        dashboard = "Home",
        games = "Playing",
      },
      buttons = {
        { label = "View repository", url = function(opts) return opts.repo_url end },
      },
      advanced = {
        discord = { reconnect = { enabled = true, interval = 5000, initial = true } },
      },
    },
  },
  {
    "wakatime/vim-wakatime",
    main = "wakatime",
    lazy = false,
    opts = { status_bar_enabled = false },
  },
}
