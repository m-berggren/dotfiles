#!/usr/bin/env fish
# Background daemon that listens for monitor hotplug events and re-applies
# monitor config. Fixes overlapping monitor errors when the Lenovo dock
# reconnects after sleep (DP port names change, EDID arrives late, and the
# catch-all rule places monitors at overlapping positions before desc: rules
# can match).
#
# Launched by hyprland.conf: exec-once = fish ~/.config/hypr/scripts/monitor-reset.fish

set socket "$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"

# Wait for Hyprland to fully initialize before attaching to the socket
sleep 2

ncat -U "$socket" | while read -l line
    if string match -q 'monitoradded>>*' $line
        # Wait for dock EDID enumeration to finish so desc: rules can match
        sleep 3

        # Re-read monitors.conf and re-apply desc: position rules
        hyprctl reload

        # Move workspaces to their assigned monitors
        set left "desc:Samsung Electric Company LS24D40xG HNAY300283"
        set right "desc:Samsung Electric Company LS24D40xG HNAY200986"
        set laptop eDP-1

        for ws in 1 2 3
            hyprctl dispatch moveworkspacetomonitor $ws $laptop
        end
        for ws in 4 5 6
            hyprctl dispatch moveworkspacetomonitor $ws $left
        end
        for ws in 7 8 9
            hyprctl dispatch moveworkspacetomonitor $ws $right
        end
    end
end
