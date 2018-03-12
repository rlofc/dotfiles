-- load standard vis module, providing parts of the Lua API
require('vis')

module = {}

cc_path = "clang++"
cc_args = " "


-- C++ Helpers

vis:command_register("make", function(argv, force, win, selection, range)
    local command = cc_path .. " ".. vis.win.file.path .. " 2>&1" -- .. table.concat(argv, "")

    local file = io.popen(command)
    local output = file:read('*all')
    local success, msg, status = file:close()

    if status == 0 then 
        vis:info("Build succeeded!")
    else
        vis:feedkeys(string.format(":new<Enter>"))
        vis:feedkeys("i")
        vis:insert(output)
        vis.win:map(vis.modes.NORMAL, "<Escape>",function()
            vis:feedkeys(":q!<Enter>")
        end)
    end

    vis:feedkeys("<vis-redraw>")

    return true;
end)


plugin_vis_open =require('plugins/vis-fzf-open/fzf-open')

-- Path to the fzf executable (default: "fzf")
plugin_vis_open.fzf_path = "fzf"

-- Arguments passed to fzf (defaul: "")
plugin_vis_open.fzf_args = "-q '!.class '"


vis.events.subscribe(vis.events.INIT, function()
	vis:command('set theme base16-mine')
end)

vis.events.subscribe(vis.events.WIN_OPEN, function(win)
	vis:command('set number')
	vis:command('set autoindent')
	vis:command('set cursorline')
    vis:command('set tabwidth 4')
	vis:command('set expandtab yes')
	vis:command('set autoindent yes')
end)

function get_line_text()
    return vis.win.file.lines[vis.win.selection.line]
end

function get_indent_level()
        local tabs = 0
        local p = vis.win.selection.pos
        local file = vis.win.file
        vis.win.selection:to(vis.win.selection.line,1)
        text1 = file:content(vis.win.selection.pos,4)
        text2 = file:content(vis.win.selection.pos,8)
        text3 = file:content(vis.win.selection.pos,12)
        text4 = file:content(vis.win.selection.pos,16)
        text5 = file:content(vis.win.selection.pos,20)
        text6 = file:content(vis.win.selection.pos,24)
        text7 = file:content(vis.win.selection.pos,28)
        if text1 == "    " then
            tabs = 1
        end
        if text2 == "        " then
            tabs = 2
        end
        if text3 == "            " then
            tabs = 3
        end
        if text4 == "                " then
            tabs = 4
        end
        if text5 == "                    " then
            tabs = 5
        end
        if text6 == "                        " then
            tabs = 6
        end
        if text7 == "                            " then
            tabs = 7
        end
        vis.win.selection.pos = p
    return tabs
end

vis:map(vis.modes.INSERT, "<Enter>",function()
        local tabs = get_indent_level()        
        local line = get_line_text()
        if string.match(line, "function") then
            vis:insert('\n')
            for t = 1,tabs+1 do
                vis:feedkeys('<Tab>')
            end
        elseif vis.win.selection.pos>0 and vis.win.file:content(vis.win.selection.pos-1,1) == ":" then
            vis:insert('\n')
            for t = 1,tabs+1 do
                vis:feedkeys('<Tab>')
            end
        else
            vis:insert('\n')
            for t = 1,tabs do
                vis:feedkeys('<Tab>')
            end
        end
end, "test")

vis:map(vis.modes.NORMAL, "<C-p>",function()
    vis:feedkeys(':fzf<Enter>')
end)
vis:map(vis.modes.NORMAL, "``",function()
    vis:feedkeys(':fzf<Enter>')
end)
vis:map(vis.modes.NORMAL, "]]",function()
    vis:feedkeys('}')
end)
vis:map(vis.modes.NORMAL, "[[",function()
    vis:feedkeys('{')
end)

vis:map(vis.modes.INSERT, "<Backspace>",function()
    local text1 = ""
    local text2 = ""
    local text0 = ""
    if vis.win.selection.pos == 0 then
        return 0
    end
    if vis.win.selection.pos >= 1 then
        text0 = vis.win.file:content(vis.win.selection.pos-1,2)
    end
    if vis.win.selection.pos >= 4 then
        text1 = vis.win.file:content(vis.win.selection.pos-4,4)
    end
    if vis.win.selection.pos >= 6 then
        text2 = vis.win.file:content(vis.win.selection.pos-6,1)
    end
    if text0 == "()" then
        local s = vis.win.selection.pos
        vis.win.file:delete(vis.win.selection.pos-1,1)
        vis.win.selection.pos = s
        vis:insert('')
    end
    if text1 == "    " then
        if text2 == '{' then
            local s = vis.win.selection.pos - 5
            vis.win.file:delete(vis.win.selection.pos-5,6)
            vis.win.selection.pos = s
            vis:insert('')
        else
        local s = vis.win.selection.pos - 4
        vis.win.file:delete(vis.win.selection.pos-4,4)
        vis.win.selection.pos = s
        vis:insert('')
        end
    else
        local s = vis.win.selection.pos - 1
        vis.win.file:delete(vis.win.selection.pos-1,1)
        vis.win.selection.pos = s
        vis:insert('')
    end
end, "test")

vis.events.subscribe(vis.events.INPUT, function(key)
    if key == '(' then
        local p = vis.win.selection.pos
        vis:insert("()")
        vis.win.selection.pos = p + 1
        return true
    elseif key == ')' then
        local p = vis.win.selection.pos
        if vis.win.file:content(p,1) == ')' then
            vis.win.selection.pos = p + 1
            return true
        end
    elseif key == '{' then
        local tabs = get_indent_level()        
        vis:insert("{\n\n")
        for t = 1,tabs do
            vis:feedkeys('<Tab>')
        end
        vis:insert("}")
        local p = vis.win.selection.pos
        vis.win.selection.pos = p - 2 - (tabs *4)
        for t = 1,tabs+1 do
            vis:feedkeys('<Tab>')
        end
        return true
    else
    end
    return false
end)

