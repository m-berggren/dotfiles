function hypr-demo-scale --description "Set scale on external demo monitor (excludes laptop and dock screens)"
    if test (count $argv) -ne 1
        echo "Usage: hypr-demo-scale <scale>"
        echo "Example: hypr-demo-scale 1.5"
        return 1
    end

    # Find monitors that aren't the laptop or the two dock Samsungs
    set monitor (hyprctl monitors -j | jq -r '
        .[] | select(
            .name != "eDP-1" and
            .serial != "HNAY300283" and
            .serial != "HNAY200986"
        ) | .name
    ')

    if test -z "$monitor"
        echo "No external demo monitor found"
        return 1
    end

    hyprctl keyword monitor "$monitor,preferred,auto,$argv[1]"
    echo "Set $monitor to scale $argv[1]"
end
