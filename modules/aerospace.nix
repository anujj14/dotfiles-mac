{ pkgs, ... }:

{
  services.aerospace = {
    enable = true;
    
    settings = {
      "config-version" = 2;
      
      exec-on-workspace-change = [ "/bin/bash" "-c" "/run/current-system/sw/bin/sketchybar --trigger aerospace_workspace_change" ];

      enable-normalization-flatten-containers = true;
      enable-normalization-opposite-orientation-for-nested-containers = true;
      accordion-padding = 200;
      default-root-container-layout = "tiles";
      default-root-container-orientation = "auto";
      
      on-focused-monitor-changed = ["move-mouse monitor-lazy-center"];
      
      automatically-unhide-macos-hidden-apps = false;
      focus-follows-mouse.enabled = false;

      persistent-workspaces = [ "1" "2" "3" "4" ];

      key-mapping.preset = "qwerty";

      gaps = {
        inner.horizontal = 9;
        inner.vertical   = 9;
        outer.left       = 9;
        outer.bottom     = 9;
        outer.top        = 50;
        outer.right      = 9;
      };

      mode.main.binding = {
        shift-alt-p = "layout tiles horizontal vertical";
        shift-alt-y = "layout tiles vertical";
        shift-alt-r = "layout tiles horizontal";
        shift-alt-q = "layout floating";
        shift-alt-n = "layout tiles";
        shift-alt-a = "layout accordion";
        shift-alt-t = "layout floating tiling";

        alt-enter = "exec-and-forget osascript -e 'tell application \"Ghostty\" to new window'";

        alt-h = "focus left";
        alt-j = "focus down";
        alt-k = "focus up";
        alt-l = "focus right";
        
        alt-minus = "resize smart -50";
        alt-equal = "resize smart +50";

        ctrl-alt-h = "swap left";
        ctrl-alt-j = "swap down";
        ctrl-alt-k = "swap up";
        ctrl-alt-l = "swap right";

        alt-shift-h = "move left";
        alt-shift-j = "move down";
        alt-shift-k = "move up";
        alt-shift-l = "move right";

        alt-1 = ["workspace 1" ];
        alt-2 = ["workspace 2" ];
        alt-3 = ["workspace 3" ];
        alt-4 = ["workspace 4" ];

        alt-shift-1 = ["move-node-to-workspace 1"];
        alt-shift-2 = ["move-node-to-workspace 2"];
        alt-shift-3 = ["move-node-to-workspace 3"];
        alt-shift-4 = ["move-node-to-workspace 4"];

        shift-alt-enter = "flatten-workspace-tree";
        alt-tab = "workspace-back-and-forth";
        alt-shift-tab = "move-workspace-to-monitor --wrap-around next";
        alt-shift-semicolon = "mode service";

        ctrl-alt-enter = "fullscreen";
        shift-alt-f = "macos-native-fullscreen";
      };

      mode.service.binding = {
        esc = ["reload-config" "mode main"];
        r = ["flatten-workspace-tree" "mode main"];
        f = ["layout floating tiling" "mode main"];
        backspace = ["close-all-windows-but-current" "mode main"];
        alt-shift-h = ["join-with left" "mode main"];
        alt-shift-j = ["join-with down" "mode main"];
        alt-shift-k = ["join-with up" "mode main"];
        alt-shift-l = ["join-with right" "mode main"];
      };

      on-window-detected = [
        { "if".app-id = "com.apple.systempreferences"; run = "layout floating"; }
        { "if".app-id = "com.shottr.Shottr"; run = "layout floating"; }
        { "if".app-id = "com.raycast.macos"; run = "layout floating"; }
        { "if".app-id = "com.colliderli.iina"; run = "layout floating"; }
        { "if".app-name-regex-substring = "WhatsApp"; run = "layout floating"; }
        { "if".app-id = "com.apple.passwords"; run = "layout floating"; }
        { "if".app-id = "com.apple.AppStore"; run = "layout floating"; }
        { "if".app-id = "net.freemacsoft.AppCleaner"; run = "layout floating"; }
      ];
    };
  };
}
