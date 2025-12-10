{ pkgs, ... }: {
    # ==========================================================
  # USER DEFINITION (Fixes "absolute path" error)
  # ==========================================================
  users.users.damiancrespi = {
    name = "damiancrespi";
    home = "/Users/damiancrespi";
  };
  # ==========================================================
  # SYSTEM CONFIGURATION (Your "Configuraciones" List)
  # ==========================================================
  
  system.defaults = {
    # 1. Dock: Right, small icons, autohide
    dock = {
      orientation = "right";
      autohide = true;
      tilesize = 36;
      show-recents = false;
      # Faster animation
      autohide-time-modifier = 0.5; 
      autohide-delay = 0.0;
    };

    # 2. Dark Mode
    NSGlobalDomain.AppleInterfaceStyle = "Dark";

    # 4. Date time with seconds
    menuExtraClock.ShowSeconds = true;

    # 5. Custom folder for screenshots
    screencapture.location = "~/Screenshots";

    # Finder Settings
    finder = {
      AppleShowAllExtensions = true;
      ShowPathbar = true;
      FXEnableExtensionChangeWarning = false;
    };
    
    # 11. Keyboard (Key repeat rates)
    NSGlobalDomain = {
      KeyRepeat = 2;
      InitialKeyRepeat = 15;
    };
  };

  # ==========================================================
  # FONTS (System-Level Registration)
  # ==========================================================
  fonts.packages = [
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.nerd-fonts.fira-code
  ];

  # ==========================================================
  # HOMEBREW (GUI Apps & Casks)
  # ==========================================================
  homebrew = {
    enable = true;
    
    # "Zap": Uninstalls all Casks not listed here. 
    # Warning: If you have manual apps, they will be deleted.
    onActivation.cleanup = "zap"; 

    taps = [
      "homebrew/cask-versions"
      "jordanbaird/tap" # Required for 'ICE'
    ];

    casks = [
      # Productivity & Communication
      "slack"
      "discord"
      "telegram"
      "whatsapp"
      "notion"
      
      # Browsers
      "google-chrome" # Item 13
      
      # Development Tools
      "visual-studio-code"
      "cursor"        # Item 7 (AI Code Editor)
      "postman"
      "tableplus"
      "smartgit"
      "docker"        # Docker Desktop
      
      # Terminal & Utilities
      "warp"          # Item 1
      "rectangle"     # Item 5 (Window Manager)
      "karabiner-elements" # Item 4
      "jordanbaird-ice"    # Item 12 (Menu bar manager)
      "google-drive"
      "logi-tune"     # Item 21
      
      # --- NEW ADDITIONS ---
      "stats"             # System Monitor (CPU/RAM)
      "syntax-highlight"  # QuickLook: Colorize code
      "qlmarkdown"        # QuickLook: Render Markdown
      "quicklook-json"    # QuickLook: Format JSON
    ];
  };
  
  # ==========================================================
  # ACTIVATION SCRIPTS
  # ==========================================================
  system.activationScripts.postActivation.text = ''
    # Create the custom Screenshots folder
    mkdir -p /Users/${builtins.getEnv "USER"}/Screenshots
    
    # Create the Sites folder
    mkdir -p /Users/${builtins.getEnv "USER"}/Sites
  '';

  # Essential Nix settings
  services.nix-daemon.enable = true;
  nix.settings.experimental-features = "nix-command flakes";
  security.pam.enableSudoTouchIdAuth = true;
  system.stateVersion = 4;
}