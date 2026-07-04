{ config, lib, pkgs, ... }:

{
  programs.aerospace = {
    enable = true;

    launchd.enable = true; 

    settings = {
      start-at-login = false;
      automatically-unhide-macos-hidden-apps = true;
      on-focused-monitor-changed = ["move-mouse monitor-lazy-center"];

      enable-normalization-flatten-containers = true;
      enable-normalization-opposite-orientation-for-nested-containers = true;
      accordion-padding = 30;
      default-root-container-layout = "tiles";
      default-root-container-orientation = "auto";

      key-mapping.preset = "qwerty";

      gaps = {
        inner.horizontal = 10;
        inner.vertical = 10;
        outer.left = 12;
        outer.bottom = 10;
        outer.top = 2;
        outer.right = 12;
      };

      mode.main.binding = {
        "alt-enter" = "exec-and-forget osascript -e 'tell application \"Ghostty\" to new window'";

        "alt-slash" = "layout tiles horizontal vertical";
        "alt-comma" = "layout accordion horizontal vertical";

        "alt-h" = "focus left";
        "alt-j" = "focus down";
        "alt-k" = "focus up";
        "alt-l" = "focus right";

        "alt-shift-h" = "move left";
        "alt-shift-j" = "move down";
        "alt-shift-k" = "move up";
        "alt-shift-l" = "move right";

        "alt-minus" = "resize smart -50";
        "alt-equal" = "resize smart +50";

        "alt-0" = "workspace 0";
        "alt-1" = "workspace 1";
        "alt-2" = "workspace 2";
        "alt-3" = "workspace 3";
        "alt-c" = "workspace code";
        "alt-m" = "workspace media";
        "alt-p" = "workspace privt";
        "alt-s" = "workspace social";
        "alt-t" = "workspace todo";
        "alt-w" = "workspace web";

        "alt-shift-0" = "move-node-to-workspace 0";
        "alt-shift-1" = "move-node-to-workspace 1";
        "alt-shift-2" = "move-node-to-workspace 2";
        "alt-shift-3" = "move-node-to-workspace 3";
        "alt-shift-c" = "move-node-to-workspace code";
        "alt-shift-m" = "move-node-to-workspace media";
        "alt-shift-p" = "move-node-to-workspace privt";
        "alt-shift-s" = "move-node-to-workspace social";
        "alt-shift-t" = "move-node-to-workspace todo";
        "alt-shift-w" = "move-node-to-workspace web";

        "alt-tab" = "workspace-back-and-forth";
        "alt-shift-tab" = "move-workspace-to-monitor --wrap-around next";
        "alt-shift-backspace" = "mode service";
      };

      mode.service.binding = {
        esc = ["reload-config" "mode main"];
        r = ["flatten-workspace-tree" "mode main"];
        f = ["layout floating tiling" "mode main"];
        backspace = ["close-all-windows-but-current" "mode main"];
        "alt-f" = "fullscreen";

        "alt-shift-h" = ["join-with left" "mode main"];
        "alt-shift-j" = ["join-with down" "mode main"];
        "alt-shift-k" = ["join-with up" "mode main"];
        "alt-shift-l" = ["join-with right" "mode main"];
      };

      on-window-detected = [
        # Floating
        { "if".app-id = "com.apple.systempreferences"; run = "layout floating"; }
        { "if".app-id = "ch.protonvpn.mac"; run = "layout floating"; }
        { "if".app-id = "net.freemacsoft.AppCleaner"; run = "layout floating"; }
        { "if".app-id = "org.freedownloadmanager.fdm6"; run = "layout floating"; }
        { "if".app-id = "com.apple.AppStore"; run = "layout floating"; }
        { "if".app-id = "com.apple.passwords"; run = "layout floating"; }

        # Workspaces
        { "if".app-id = "com.mitchellh.ghostty"; run = ["layout tiling" "move-node-to-workspace 1"]; }
        { "if".app-id = "com.apple.finder"; run = "move-node-to-workspace 2"; }
        { "if".app-id = "dev.zed.Zed"; run = "move-node-to-workspace code"; }
        { "if".app-id = "com.apple.QuickTimePlayerX"; run = "move-node-to-workspace media"; }
        { "if".app-id = "com.colliderli.iina"; run = ["layout floating" "move-node-to-workspace media"]; }

        { "if".app-id = "com.apple.MobileSMS"; run = "move-node-to-workspace social"; }
        { "if".app-id = "com.apple.mail"; run = "move-node-to-workspace social"; }
        { "if".app-id = "WhatsApp"; run = "move-node-to-workspace social"; }
        { "if".app-id = "Telegram"; run = "move-node-to-workspace social"; }

        { "if".app-id = "com.apple.iCal"; run = "move-node-to-workspace todo"; }
        { "if".app-id = "com.apple.Notes"; run = "move-node-to-workspace todo"; }

        { "if".app-id = "Helium"; run = "move-node-to-workspace web"; }
      ];
    };
  };
}
