{ pkgs, config, username, ... }: {
  
  nixpkgs.hostPlatform = "aarch64-darwin";

  nix-homebrew = {
    enable = true;
    enableRosetta = false;
    user = username;
    autoMigrate = true;
  };

  users.users.${username} = {
    name = username;
    home = "/Users/${username}";
  };

  system.primaryUser = username;

  homebrew = {
    enable = true;
    onActivation.cleanup = "none";
    
    taps = [ 
      "ahmetb/iris"
    ];

    casks = [
      "appcleaner"
      "helium-browser"
      "impactor"
      "ahmetb/iris/iris"
      "orbstack"
      "shottr"
      "tailscale-app"
      "whatsapp"
      "telegram"
      "zen"
    ];
  };

  security.pam.services.sudo_local = {
     touchIdAuth = true;
     reattach = true;
   };

  # jankyborders
  services.jankyborders = {
    enable = true;
    active_color = "0xc0ebbcba"; 
    inactive_color = "0xc06e6a86";
    background_color = "0x30191724";   
    width = 5.0; 
    style = "round";
    hidpi = true;
  };

  system.defaults = {
    SoftwareUpdate.AutomaticallyInstallMacOSUpdates = false;
    loginwindow.LoginwindowText = "Stay Away";
    
    finder = {
      ShowStatusBar = true;
      ShowPathbar = true; 
      FXPreferredViewStyle = "Nlsv";
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      CreateDesktop = false;
      FXDefaultSearchScope = "SCcf";
      NewWindowTarget = "Home"; 
    };

    NSGlobalDomain = {
      ApplePressAndHoldEnabled = false;
      InitialKeyRepeat = 15;
      KeyRepeat = 2; 
      "com.apple.trackpad.scaling" = 2.0;
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
      NSAutomaticWindowAnimationsEnabled = false;
      AppleInterfaceStyle = "Dark";
      AppleShowAllExtensions = true;
      AppleIconAppearanceTheme = "RegularDark";
    };
    
    WindowManager = {
      EnableTiledWindowMargins = false;
    };

    controlcenter = {
      BatteryShowPercentage = true;
    };

    magicmouse = {
      MouseButtonMode = "OneButton";
    };

    menuExtraClock = {
      ShowSeconds = true;
    };
    
    trackpad = {
      Clicking = true;
      TrackpadThreeFingerDrag = true;
    };

    screencapture.location = "~/Pictures/Screenshots";
    screencapture.type = "jpg";
    
    dock = {
      autohide = true;
      tilesize = 57; 
      magnification = true;
      largesize = 67; 
      mineffect = "scale";
      minimize-to-application = true;
      launchanim = true;
      show-process-indicators = true;
      show-recents = false;
      expose-group-apps = true;
      wvous-br-corner = 14;
      
      persistent-apps = [
        "/Users/${username}/Applications/Home Manager Apps/Ghostty.app"
        "/Applications/Helium.app"
        "/Applications/Zen.app"
        "/Users/${username}/Applications/Home Manager Apps/Zed.app"
        "/Users/${username}/Applications/Immich.app"
        "/Users/${username}/Applications/Home Manager Apps/Signal.app"
        "/Applications/WhatsApp.app"
        "/Applications/Telegram.app"
        "/System/Applications/Notes.app"
        "/System/Applications/System Settings.app"
      ];
    };

    CustomUserPreferences = {
      ".GlobalPreferences" = {
        #AppleAccentColor = 0;  # 0 = Red 
      };
      "com.apple.Siri" = {
        StatusMenuVisible = false;
        UserHasDeclinedEnable = true;
      };
      "com.apple.desktopservices" = {
        DSDontWriteNetworkStores = true;
        DSDontWriteUSBStores = true;
      };
      "com.apple.TimeMachine" = {
        DoNotOfferNewDisksForBackup = true;
      };
    };
  };

  system.activationScripts.postActivation.text = ''
    /usr/bin/killall Dock || true
  '';

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.gc = {
    automatic = true;
    interval = { Weekday = 0; Hour = 3; Minute = 0; };
    options = "--delete-older-than 14d";
  };
  nix.optimise.automatic = true;
  system.stateVersion = 7;
}
