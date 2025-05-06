local M = {}

function M.setup_dashboard()
    local db = require("dashboard")
    db.setup({
        theme = 'doom',
        config = {
            header = {
                '  ███╗   ██╗██╗   ██╗██╗███╗   ███╗ ',
                '  ████╗  ██║██║   ██║██║████╗ ████║ ',
                '  ██╔██╗ ██║██║   ██║██║██╔████╔██║ ',
                '  ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║ ',
                '  ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║ ',
                '  ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝ ',
            },
            center = {
                { icon = '  ', desc = 'Find File          ', action = 'Telescope find_files' },
                { icon = '  ', desc = 'Browse Projects    ', action = 'Telescope file_browser' },
                { icon = '  ', desc = 'Recent Files       ', action = 'Telescope oldfiles' },
                { icon = '  ', desc = 'Open Config        ', action = 'edit $MYVIMRC' },
                { icon = '  ', desc = 'Quit               ', action = 'qa' },
            },
            footer = { 'Happy Coding!' },
        }
    })
end

return M
