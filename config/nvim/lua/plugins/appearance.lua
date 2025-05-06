-- --- Configuring the dashboard-nvim
-- local M = {}

-- -- Define custom highlight group for the dashboard header
-- local function set_dashboard_colors()
--     -- Convert RGB values to hex: R(116) G(37) B(45) -> #742D2D
--     vim.api.nvim_command('highlight DashboardHeader guifg=#742D2D ctermfg=131')
-- end

-- function M.setup_dashboard()
--     -- Set up color highlights
--     set_dashboard_colors()
    
--     local db = require("dashboard")
--     db.setup({
--         theme = 'doom',
--         config = {
--             header = {
--                 "",
--                 "",
--                 "                                .:.                                                                 ",
--                 "                                5@G                   ^JJJJJJJJJJJJJJ.                              ",
--                 "                                5@B          .:.      ~5YYYYYYYYYYYYY:                              ",
--                 "                                5@B.:^!7J5PBB#@B:                                                   ",
--                 "                          .^~!?Y#@&###BG5J?!!&@P    :!!!!!!!!!!!!!!!!!~                             ",
--                 "                          7#BGPYB@B^:.     .G@P     ~GGGGGGGGGGGGGGG@@P                             ",
--                 "                           .    5@G       ^#@5                     .&@?                             ",
--                 "                                5@G     .J@@7                      ?@&.                             ",
--                 "                                5@G    .P@G^                      ^&@7                              ",
--                 "                                5@G     .^                       !&@J                               ",
--                 "                                5@B                            ~P@#!                                ",
--                 "                                ?@@?::.....:::^.           :!Y#@B?.                                 ",
--                 "                                 7G############~       ^YPB##P?^                                    ",
--                 "                                    .:::::::::.        .?7~:                                        ",
--                 "                                                                                                    ",
--                 "",
--             },
--             header_hl = 'DashboardHeader', -- Apply our custom highlight to the header
--             center = {
--                 { 
--                     icon = '🔎  ', 
--                     desc = '(F)ind File          ', 
--                     key = 'f',
--                     key_hl = 'Number',
--                     action = 'Telescope find_files' 
--                 },
--                 { 
--                     icon = '📂  ', 
--                     desc = '(B)rowse Projects    ', 
--                     key = 'b',
--                     key_hl = 'Number',
--                     action = 'Telescope file_browser' 
--                 },
--                 { 
--                     icon = '↺   ', 
--                     desc = '(R)ecent Files       ', 
--                     key = 'r',
--                     key_hl = 'Number',
--                     action = 'Telescope oldfiles' 
--                 },
--                 { 
--                     icon = '🔧  ', 
--                     desc = '(O)pen Config        ', 
--                     key = 'o',
--                     key_hl = 'Number',
--                     action = 'edit $MYVIMRC' 
--                 },
--                 { 
--                     icon = '🚪  ', 
--                     desc = '(Q)uit               ', 
--                     key = 'q',
--                     key_hl = 'Number',
--                     action = 'qa' 
--                 },
--             },
--             footer = { '?' } -- empty for now
--         }
--     })
-- end

-- return M

--- Configuring the dashboard-nvim with bookmarks
local M = {}

-- Define custom highlight group for the dashboard header
local function set_dashboard_colors()
    -- Convert RGB values to hex: R(116) G(37) B(45) -> #742D2D
    vim.api.nvim_command('highlight DashboardHeader guifg=#742D2D ctermfg=131')
    vim.api.nvim_command('highlight DashboardBookmark guifg=#2D7474 ctermfg=73') -- Teal color for bookmarks
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
                    icon = '🚪  ', 
                    desc = 'Quit               ', 
                    key = 'q',
                    key_hl = 'Number',
                    action = 'qa' 
                },
                -- Separator
                -- {
                --     icon = '', 
                --     desc = '', 
                --     key = '',
                --     key_hl = '',
                --     action = '' 
                -- },
                ---end of seperator
                -- { 
                --   type = "text", 
                --   val = "🔖 Bookmarks", 
                --   desc = "", -- Add empty desc
                --   opts = { hl = "DashboardBookmark", position = "center" } 
                -- }, 
                -- Bookmarks section
                { 
                    icon = '📁  ', 
                    desc = '(1) Projects         ', 
                    key = '1',
                    key_hl = 'Number',
                    action = 'cd ~/Projects | Telescope find_files' 
                },
                { 
                    icon = '📝  ', 
                    desc = '(2) Notes            ', 
                    key = '2',
                    key_hl = 'Number',
                    action = 'cd C:/Users/ahmet/Documents/ | e .' 
                },
                { 
                    icon = '⚙️   ', 
                    desc = '(3) Neovim Config    ', 
                    key = '3',
                    key_hl = 'Number',
                    action = 'cd ~/.config/nvim | e .' 
                },
                { 
                    icon = '📊  ', 
                    desc = '(4) Work             ', 
                    key = '4',
                    key_hl = 'Number',
                    action = 'cd ~/Work | Telescope find_files' 
                },
            },
            footer = { '? for help' } -- Simple footer with help hint
        }
    })
    
    -- Add a key mapping for help when in dashboard
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "dashboard",
        callback = function()
            vim.api.nvim_buf_set_keymap(0, 'n', '?', 
                ":lua print('Dashboard Keys: f=Find, b=Browse, r=Recent, o=Config, q=Quit, 1-4=Bookmarks')<CR>", 
                { noremap = true, silent = true })
        end
    })
end

-- Function to add a new bookmark to the dashboard
-- Example usage: require("your_module_name").add_bookmark("5", "Home", "~/", "cd ~/ | Telescope find_files")
function M.add_bookmark(key, name, path, action)
    -- This is a placeholder function that would need to be implemented
    -- It would modify the config file to add a new bookmark entry
    -- Requires file I/O operations, which can be complex in Lua
    
    print("Feature not fully implemented yet. To add a bookmark, edit the dashboard config file directly.")
    
    -- TODO: Implement file reading, modification and writing
    -- This would involve:
    -- 1. Reading the current config file
    -- 2. Parsing the lua code to find the center table
    -- 3. Adding a new entry with the provided parameters
    -- 4. Writing the modified content back to the file
end

-- Function to create a bookmark command that can be called from the command line
function M.setup_bookmark_command()
    vim.api.nvim_create_user_command("DashboardAddBookmark", function(opts)
        -- Format: DashboardAddBookmark [key] [name] [path] [action]
        local args = opts.args
        if args == "" then
            print("Usage: DashboardAddBookmark [key] [name] [path] [action]")
            return
        end
        
        -- Parse arguments
        local parts = {}
        for part in string.gmatch(args, "%S+") do
            table.insert(parts, part)
        end
        
        if #parts < 4 then
            print("Not enough arguments. Usage: DashboardAddBookmark [key] [name] [path] [action]")
            return
        end
        
        local key = parts[1]
        local name = parts[2]:gsub("_", " ") -- Replace underscores with spaces
        local path = parts[3]
        
        -- Combine remaining parts for action
        local action = ""
        for i = 4, #parts do
            action = action .. parts[i] .. " "
        end
        action = action:sub(1, -2) -- Remove trailing space
        
        M.add_bookmark(key, name, path, action)
    end, {
        nargs = "*",
        desc = "Add a bookmark to dashboard"
    })
end

-- Create bookmark file if it doesn't exist and load bookmarks
function M.initialize_bookmarks()
    local bookmarks_file = vim.fn.stdpath("config") .. "/lua/bookmarks.lua"
    
    -- Check if bookmarks file exists
    if vim.fn.filereadable(bookmarks_file) == 0 then
        -- Create default bookmarks file
        local file = io.open(bookmarks_file, "w")
        if file then
            file:write("return {\n")
            file:write("    -- Format: { key, icon, name, path, action }\n")
            file:write("    { '1', '📁  ', 'Projects', '~/Projects', 'cd ~/Projects | Telescope find_files' },\n")
            file:write("    { '2', '📝  ', 'Notes', '~/Documents/Notes', 'cd ~/Documents/Notes | e .' },\n")
            file:write("    { '3', '⚙️   ', 'Neovim Config', '~/.config/nvim', 'cd ~/.config/nvim | e .' },\n")
            file:write("    { '4', '📊  ', 'Work', '~/Work', 'cd ~/Work | Telescope find_files' },\n")
            file:write("}\n")
            file:close()
            print("Created default bookmarks file at " .. bookmarks_file)
        else
            print("Failed to create bookmarks file")
        end
    end
    
    -- Load bookmarks (would be used to dynamically build the dashboard)
    local ok, bookmarks = pcall(dofile, bookmarks_file)
    if not ok then
        print("Failed to load bookmarks file: " .. (bookmarks or "unknown error"))
        return {}
    end
    
    return bookmarks
end

return M