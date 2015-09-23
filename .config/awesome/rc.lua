-- Standard awesome library
awful = require("awful")
require("awful.autofocus")
awful.rules = require("awful.rules")
-- Theme handling library
beautiful = require("beautiful")
-- Notification library
naughty = require("naughty")
vicious = require("vicious")

scratch = require("scratch")

wibox = require("wibox")


-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
beautiful.init("/usr/share/awesome/themes/zenburn/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "xterm"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier
}
-- }}}

-- {{{Functions

--- Spawns cmd if no client can be found matching properties
-- If such a client can be found, pop to first tag where it is visible, and give it focus
-- @param cmd the command to execute
-- @param properties a table of properties to match against clients.  Possible entries: any properties of the client object
function run_or_raise(cmd, properties)
   local clients = client.get()
   local focused = awful.client.next(0)
   local findex = 0
   local matched_clients = {}
   local n = 0
   for i, c in pairs(clients) do
      --make an array of matched clients
      if match(properties, c) then
         n = n + 1
         matched_clients[n] = c
         if c == focused then
            findex = n
         end
      end
   end
   if n > 0 then
      local c = matched_clients[1]
      -- if the focused window matched switch focus to next in list
      if 0 < findex and findex < n then
         c = matched_clients[findex+1]
      end
      local ctags = c:tags()
      if table.getn(ctags) == 0 then
         -- ctags is empty, show client on current tag
         local curtag = awful.tag.selected()
         awful.client.movetotag(curtag, c)
      else
         -- Otherwise, pop to first tag client is visible on
         awful.tag.viewonly(ctags[1])
      end
      -- And then focus the client
      client.focus = c
      c:raise()
      return
   end
   awful.util.spawn(cmd)
end

-- Returns true if all pairs in table1 are present in table2
function match (table1, table2)
   for k, v in pairs(table1) do
      if table2[k] ~= v and not table2[k]:find(v) then
         return false
      end
   end
   return true
end

-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag({ 1, 2, 3, 4, 5, 6, 7, 8, 9 }, s, layouts[2])
end
-- }}}

-- Initialize widget
memwidget = wibox.widget.textbox()
-- Register widget
vicious.register(memwidget, vicious.widgets.mem, "[mem: $1%]", 13)

-- Initialize widget
cpuwidget = wibox.widget.textbox()
-- Register widget
vicious.register(cpuwidget, vicious.widgets.cpu, "[cpu: $1%]")

-- Create a textclock widget
mytextclock = awful.widget.textclock()

volumewidget = wibox.widget.textbox()
vicious.register(volumewidget, vicious.widgets.volume, "[volume: $1% $2]", 2, "Master")

gmailwidget = wibox.widget.textbox()
vicious.register(gmailwidget, vicious.widgets.gmail, "[Gmail: ${count}]", 60)

-- Create a systray
mysystray = wibox.widget.systray()

-- Battery Widget
mybat = wibox.widget.textbox()
vicious.register (mybat, vicious.widgets.bat, "[$1$2%]", 61, "BAT1")

mpdwidget = wibox.widget.textbox()
 vicious.register(mpdwidget, vicious.widgets.mpd,
    function (widget, args)
      if   args["{state}"] == "Stop" then return ""
      else return '[<span color="white">MPD:</span> '..
             args["{Artist}"]..' - '.. args["{Title}"] .. ']'
      end
    end)

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if not c:isvisible() then
                                                  awful.tag.viewonly(c:tags()[1])
                                              end
                                              client.focus = c
                                              c:raise()
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)


    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })
    -- Add widgets to the wibox - order matters
    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mytaglist[s])
    left_layout:add(mypromptbox[s])

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    right_layout:add(volumewidget)
    right_layout:add(mybat)
    right_layout:add(mpdwidget)
    right_layout:add(gmailwidget)
    right_layout:add(memwidget)
    right_layout:add(cpuwidget)
    right_layout:add(mytextclock)
    right_layout:add(mylayoutbox[s])
    if s == 1 then right_layout:add(wibox.widget.systray()) end

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)
    mywibox[s]:set_widget(layout)
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
--    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "q",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "e",  awful.tag.viewnext       ),
    awful.key({ modkey, "Shift" }, "q", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Shift" }, "e", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey, "Control" }, "q", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "e", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),
    awful.key({ modkey, }, "f", function () run_or_raise("firefox", { class = "Firefox" }) end),
    awful.key({ modkey, }, "x", function () run_or_raise("mendeleydesktop", { class = "Mendeleydesktop" }) end),
    awful.key({ modkey, }, "j", function () run_or_raise("pidgin", {class = "Pidgin", name = "Buddy List" }) end),
    awful.key({ modkey, }, "i", function () run_or_raise("sonata", {class = "Sonata"}) end),
    awful.key({ modkey, }, "w", function () run_or_raise("", { class = "Evince" }) end),
    awful.key({ modkey, }, "v", function () run_or_raise("", { class = "Eclipse" }) end),

    awful.key({ modkey, }, "t", 
    function ()
      if instance then
        instance:hide()
        instance = nil
      else
        instance = awful.menu.clients({ width=450 })
      end
    end),



    awful.key({ modkey }, "space", function () scratch.drop("xterm", "center", "center", 0.7, 0.6) end),
    awful.key({ modkey }, "i", function () scratch.drop("xterm /usr/bin/ncmpcpp", "center", "center", 0.7, 0.6) end),

    awful.key({ modkey,           }, "d",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "a",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey,           }, "]", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey,           }, "[", function () awful.layout.inc(layouts, -1) end),

    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey }, "F4", function ()
    awful.prompt.run({ prompt = "Manual: " }, mypromptbox[mouse.screen].widget,
    --  Use GNU Emacs for manual page display
    --  function (page) awful.util.spawn("emacsclient --eval '(manual-entry \"'" .. page .. "'\")'", false) end,
    --  Use the KDE Help Center for manual page display
    --  function (page) awful.util.spawn("khelpcenter man:" .. page, false) end,
    --  Use the terminal emulator for manual page display
        function (page) awful.util.spawn("xterm -e man " .. page, false) end,
        function(cmd, cur_pos, ncomp)
            local pages = {}
            local m = 'IFS=: && find $(manpath||echo "$MANPATH") -type f -printf "%f\n"| cut -d. -f1'
            local c, err = io.popen(m)
            if c then while true do
                local manpage = c:read("*line")
                if not manpage then break end
                if manpage:find("^" .. cmd:sub(1, cur_pos)) then
                    table.insert(pages, manpage)
                end
              end
              c:close()
            else io.stderr:write(err) end
            if #cmd == 0 then return cmd, cur_pos end
            if #pages == 0 then return end
            while ncomp > #pages do ncomp = ncomp - #pages end
            return pages[ncomp], cur_pos
        end)
      end),

    awful.key({ modkey,           }, "F2",
              function ()
                  awful.prompt.run({ prompt = "ssh: " },
                  mypromptbox[mouse.screen].widget,
                  function(h) awful.util.spawn(terminal .. " -e ssh " .. h) end,
                  function(cmd, cur_pos, ncomp)
                      -- get hosts and hostnames
                      local hosts = {}
                      f = io.popen("sed 's/#.*//;/[ \\t]*Host\\(Name\\)\\?[ \\t]\\+/!d;s///;/[*?]/d' " .. os.getenv("HOME") .. "/.ssh/config | sort")
                      for host in f:lines() do
                          table.insert(hosts, host)
                      end
                      f:close()
                      -- abort completion under certain circumstances
                      if cur_pos ~= #cmd + 1 and cmd:sub(cur_pos, cur_pos) ~= " " then
                          return cmd, cur_pos
                      end
                      -- match
                      local matches = {}
                      table.foreach(hosts, function(x)
                          if hosts[x]:find("^" .. cmd:sub(1, cur_pos):gsub('[-]', '[-]')) then
                              table.insert(matches, hosts[x])
                          end
                      end)
                      -- if there are no matches
                      if #matches == 0 then
                          return cmd, cur_pos
                      end
                      -- cycle
                      while ncomp > #matches do
                          ncomp = ncomp - #matches
                      end
                      -- return match and position
                      return matches[ncomp], #matches[ncomp] + 1
                  end,
                  awful.util.getdir("cache") .. "/ssh_history")
              end),

    awful.key({ modkey }, "F5", function ()
        awful.prompt.run({ prompt = "Web search: " }, mypromptbox[mouse.screen].widget,
            function (command)
                awful.util.spawn("firefox 'http://google.com/search?q="..command.."'", false)
                -- Switch to the web tag, where Firefox is, in this case tag 3
                if tags[mouse.screen][3] then awful.tag.viewonly(tags[mouse.screen][3]) end
            end)
    end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey, "Shift"   }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey,    }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey }, "m", function (c)
      c.maximized_horizontal = not c.maximized_horizontal
      c.maximized_vertical   = not c.maximized_vertical
    end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = true,
                     keys = clientkeys,
                     buttons = clientbuttons } },
                     { rule = { class = "Mendeleydesktop" },
                     properties = { tag = tags[1][5] } },
                     { rule = { class = "Sonata" },
                     properties = { tag = tags[1][9] } },
                     { rule = { instance = "Mail" },
                     properties = { tag = tags[1][8] } },
                     { rule = { class = "Grooveshark" },
                     properties = { tag = tags[1][9] } },
                     { rule = { class = "Eclipse" },
                     properties = { tag = tags[1][6] } },
                     { rule = { class = "feh" },
                     properties = { floating = true } },
}
-- }}}
--
-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    -- Add a titlebar
    -- awful.titlebar.add(c, { modkey = modkey })

    -- Enable sloppy focus
    c:add_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}


