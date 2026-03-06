function hypr-assign-workspaces
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
