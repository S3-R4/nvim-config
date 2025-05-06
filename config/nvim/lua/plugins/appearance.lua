-- ---setting up the andromeda colorscheme
-- vim.g.andromeda_transparent = true
-- vim.g.andromeda_bold = true
-- vim.g.andromeda_italic = true
-- vim.g.andromeda_set_terminal_colors = true
-- vim.cmd("colorscheme andromeda")
-- ---;;;END OF colorscheme

--- Configuring the dashboard-nvim
local M = {}

-- Define custom highlight group for the dashboard header
local function set_dashboard_colors()
    -- Convert RGB values to hex: R(116) G(37) B(45) -> #742D2D
    vim.api.nvim_command('highlight DashboardHeader guifg=#742D2D ctermfg=131')
end

function M.setup_dashboard()
    -- Set up color highlights
    set_dashboard_colors()
    
    local db = require("dashboard")
    db.setup({
        theme = 'doom',
        config = {
            header = {
                "",
                "",
                "                                .:.                                                                 ",
                "                                5@G                   ^JJJJJJJJJJJJJJ.                              ",
                "                                5@B          .:.      ~5YYYYYYYYYYYYY:                              ",
                "                                5@B.:^!7J5PBB#@B:                                                   ",
                "                          .^~!?Y#@&###BG5J?!!&@P    :!!!!!!!!!!!!!!!!!~                             ",
                "                          7#BGPYB@B^:.     .G@P     ~GGGGGGGGGGGGGGG@@P                             ",
                "                           .    5@G       ^#@5                     .&@?                             ",
                "                                5@G     .J@@7                      ?@&.                             ",
                "                                5@G    .P@G^                      ^&@7                              ",
                "                                5@G     .^                       !&@J                               ",
                "                                5@B                            ~P@#!                                ",
                "                                ?@@?::.....:::^.           :!Y#@B?.                                 ",
                "                                 7G############~       ^YPB##P?^                                    ",
                "                                    .:::::::::.        .?7~:                                        ",
                "                                                                                                    ",
                "",
            },
            header_hl = 'DashboardHeader', -- Apply our custom highlight to the header
            center = {
                { 
                    icon = '🔎  ', 
                    desc = 'Find File          ', 
                    key = 'f',
                    key_hl = 'Number',
                    action = 'Telescope find_files' 
                },
                { 
                    icon = '📂  ', 
                    desc = 'Browse Projects    ', 
                    key = 'b',
                    key_hl = 'Number',
                    action = 'Telescope file_browser' 
                },
                { 
                    icon = '↺   ', 
                    desc = 'Recent Files       ', 
                    key = 'r',
                    key_hl = 'Number',
                    action = 'Telescope oldfiles' 
                },
                { 
                    icon = '🔧  ', 
                    desc = 'Open Config        ', 
                    key = 'o',
                    key_hl = 'Number',
                    action = 'edit $MYVIMRC' 
                },
                {
                    icon = '🔖  ',
                    desc = 'Bookmarks     ',
                    key = 'm',
                    key_hl = 'Number',
                    action = 'lua require("harpoon.ui").toggle_quick_menu()'
                },
                { 
                    icon = '🚪  ', 
                    desc = 'Quit               ', 
                    key = 'q',
                    key_hl = 'Number',
                    action = 'qa' 
                },
            },
            footer = { '~ made by S3R4' } -- later here will be an ascii art
        }
    })
end

return M