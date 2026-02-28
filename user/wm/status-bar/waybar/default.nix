{
  lib,
  config,
  pkgs,
  ...
}: {
  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        spacing = 0;
        reload_style_on_change = true;

        modules-left = [
          "custom/actions"
          "systemd-failed-units"
          "custom/dwl"
        ];

        modules-center = [
          "privacy"
          "clock"
          "mpris"
        ];

        modules-right = [
          "backlight"
          "wireplumber"
          "network"
          "bluetooth"
          "group/power"
          "group/hardware"
          "tray"
          "custom/swaync"
        ];

        "custom/actions" = {
          format = " ";
          tooltip-format = "System Actions";
          # on-click = lib.getExe' self.packages.${pkgs.system}.fuzzel-goodies "fuzzel-actions";
        };

        "custom/dwl" = {
          exec = "waybar-dwl";
          format = "{}";
          return-type = "json";
        };

        systemd-failed-units = let
          zsh = lib.getExe pkgs.zsh;
          bat = lib.getExe pkgs.bat;
          terminal = lib.getExe pkgs.foot; # or pkgs.kitty or pkgs.xterm
        in {
          format = "✗ {nr_failed}";
          on-click = "${terminal} ${zsh} -c \"${bat} --paging always -f <(systemctl list-units --user --failed) <(systemctl list-units --failed)\"";
          hide-on-ok = true;
        };

        clock = {
          format = " {:%A %H:%M}";

          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "month";
            weeks-pos = "left";
            mode-mon-col = 3;
            format = let
              colors = config.lib.stylix.colors.withHashtag;
            in {
              months = "<span color='${colors.base06}'><b>{}</b></span>";
              days = "<span color='${colors.base05}'><b>{}</b></span>";
              weeks = "<span color='${colors.base0E}'><b>W{}</b></span>";
              weekdays = "<span color='${colors.base0A}'><b>{}</b></span>";
              today = "<span color='${colors.base0B}'><b><u>{}</u></b></span>";
            };
          };

          actions = {
            on-click-right = "mode";
            on-click-middle = "shift_reset";
            on-scroll-up = "shift_up";
            on-scroll-down = "shift_down";
          };
        };

        mpris = let
          playerctl = lib.getExe config.services.playerctld.package;
        in {
          player = "spotify";
          format = "{player_icon} {status_icon} <b>{title}</b> by <i>{artist}</i>";
          tooltip-format = "Album: {album}";
          artist-len = 12;
          title-len = 22;
          ellipsis = "...";
          player-icons = {
            default = "";
            spotify = "󰓇";
            kdeconnect = "";
          };
          status-icons = {
            paused = "󰏤";
          };
          on-scroll-up = "${playerctl} volume 0.1+";
          on-scroll-down = "${playerctl} volume 0.1-";
        };

        backlight = {
          format = "{icon} {percent}%";
          format-icons = [
            "󱩎"
            "󱩏"
            "󱩐"
            "󱩑"
            "󱩒"
            "󱩓"
            "󱩔"
            "󱩕"
            "󱩖"
            "󰛨"
          ];
          tooltip-format = "{percent}%";
        };

        wireplumber = {
          format = "{icon} {volume}%";
          format-muted = "󰝟";
          format-icons = [
            "󰕿"
            "󰖀"
            "󰕾"
          ];
          tooltip-format = "{volume}% on {node_name}";
          on-click = lib.getExe pkgs.pwvucontrol;
          on-click-right = "${lib.getExe' pkgs.wireplumber "wpctl"} set-mute @DEFAULT_AUDIO_SINK@ toggle";
        };

        "group/power" = {
          orientation = "inherit";

          drawer = {
            transition-duration = 300;
            transition-left-to-right = false;
            click-to-reveal = false;
          };

          modules = [
            "battery"
            "idle_inhibitor"
            "power-profiles-daemon"
          ];
        };

        battery = {
          format = "{icon} {capacity}%";
          format-discharging = "{icon} {capacity}%";
          format-charging = "{icon} {capacity}%";
          format-plugged = "";
          format-icons = {
            charging = [
              "󰢜"
              "󰂆"
              "󰂇"
              "󰂈"
              "󰢝"
              "󰂉"
              "󰢞"
              "󰂊"
              "󰂋"
              "󰂅"
            ];
            default = [
              "󰁺"
              "󰁻"
              "󰁼"
              "󰁽"
              "󰁾"
              "󰁿"
              "󰂀"
              "󰂁"
              "󰂂"
              "󰁹"
            ];
          };
          format-full = "󰂅";
          tooltip-format-discharging = "{power:>1.2f}W↓ {capacity}%\n{timeTo}";
          tooltip-format-charging = "{power:>1.2f}W↑ {capacity}%\n{timeTo}";

          interval = 5;
          states = {
            warning = 20;
            critical = 10;
          };
        };

        idle_inhibitor = {
          format = "{icon}";

          format-icons = {
            activated = " ";
            deactivated = " ";
          };
        };

        power-profiles-daemon = {
          format = "{icon}";
          tooltip-format = "Power profile: {profile}\nDriver: {driver}";
          tooltip = true;
          format-icons = {
            default = "";
            performance = " ";
            balanced = " ";
            power-saver = " ";
          };
        };

        network = {
          format-wifi = "󰖩 {essid}";
          format-ethernet = "󰈀 {ipaddr}";
          format-disconnected = "󰖪";
          tooltip-format-wifi = "Signal: {signalStrength}%\nIP: {ipaddr}\nFrequency: {frequency}MHz";
          tooltip-format-ethernet = "Interface: {ifname}\nIP: {ipaddr}";
          tooltip-format-disconnected = "Disconnected";
          on-click = lib.getExe pkgs.networkmanagerapplet;
        };

        bluetooth = {
          format = "󰂯";
          format-disabled = "󰂲";
          format-connected = "󰂱 {num_connections}";
          tooltip-format = "{controller_alias}\t{controller_address}";
          tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
          # on-click = lib.getExe pkgs.blueberry;
          on-click = "${lib.getExe' pkgs.blueman "blueman-manager"}";
        };
        "group/hardware" = {
          orientation = "inherit";

          drawer = {
            transition-duration = 300;
            transition-left-to-right = false;
            click-to-reveal = true;
          };

          modules = [
            # "custom/monitor"
            "cpu"
            "disk"
            "temperature"
            "memory"
          ];
        };

        # "custom/monitor" = {
        # format = "";
        # tooltip = false;
        # on-click = "hyprctl dispatch togglespecialworkspace monitor";
        # };

        disk = {
          format = "󰋊 {percentage_free}%";
        };

        cpu = {
          format = " {usage}%";
          # interval = 5;
        };

        temperature = {
          format = " {temperatureC}°C";
          # interval = 5;
          critical-format = "󰸁 {temperatureC}°C";
          critical-threshold = 90;
        };

        memory = {
          format = " {used}/{total}GiB";
          # interval = 5;
        };

        tray = {
          spacing = 5;
        };

        # "custom/fnott" =
        # let
        # fnott-dnd = lib.getExe self.packages.${pkgs.system}.fnott-dnd;
        # in
        # {
        # return-type = "json";
        # exec = "${fnott-dnd} -w";
        # interval = "once";
        # signal = 2;
        #
        # on-click = "${lib.getExe' pkgs.fnott "fnottctl"} dismiss";
        # on-click-right = fnott-dnd;
        # };

        "custom/swaync" = {
          tooltip = false;
          format = "{} {icon}";

          format-icons = {
            notification = "󱅫";
            none = "󰂚";
            dnd-notification = "󰂛";
            dnd-none = "󰂛";
            inhibited-notification = "󰂛";
            inhibited-none = "󰂛";
            dnd-inhibited-notification = "󰂛";
            dnd-inhibited-none = "󰂛";
          };
          return-type = "json";
          exec-if = "which swaync-client";
          exec = "swaync-client -swb";
          on-click = "swaync-client -t -sw";
          on-click-middle = "swaync-client -C";
          on-click-right = "swaync-client -d -sw";
          escape = true;
        };
      };
    };
  };

  xdg.configFile."waybar/config" = {
    onChange = ''
      ${lib.getExe' pkgs.procps "pkill"} -u $USER waybar || true
    '';
  };
}
