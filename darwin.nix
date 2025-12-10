{ pkgs, ... }: {
  # ==========================================================
  # SYSTEM CONFIGURATION
  # ==========================================================
  
  system.defaults = {
    dock = {
      orientation = "right";
      autohide = true;
      tilesize = 36;
      show-recents = false;
      autohide-time-modifier = 0.5; 
      autohide-delay = 0.0;
    };

    NSGlobalDomain.AppleInterfaceStyle = "Dark";
    menuExtraClock.ShowSeconds = true;
    screencapture.location = "~/Screenshots";

    finder = {
      AppleShowAllExtensions = true;
      ShowPathbar = true;
      FXEnableExtensionChangeWarning = false;
    };
    
    NSGlobalDomain = {
      KeyRepeat = 2;
      InitialKeyRepeat = 15;
    };
  };

  # ==========================================================
  # USER DEFINITION
  # ==========================================================
  users.users.damiancrespi = {
    name = "damiancrespi";
    home = "/Users/damiancrespi";
  };

  # CORRECTED: No prefix here. This is the new option.
  system.primaryUser = "damiancrespi";

  # ==========================================================
  # FONTS
  # ==========================================================
  fonts.packages = [
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.nerd-fonts.fira-code
  ];

  # ==========================================================
  # HOMEBREW
  # ==========================================================
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap"; 

    taps = [
      "homebrew/cask-versions"
      "jordanbaird/tap"
    ];

    casks = [
      "slack"
      "discord"
      "telegram"
      "whatsapp"
      "notion"
      "google-chrome"
      "visual-studio-code"
      "cursor"
      "postman"
      "tableplus"
      "smartgit"
      "docker"
      "warp"
      "rectangle"
      "karabiner-elements"
      "jordanbaird-ice"
      "google-drive"
      "logi-tune"
      "stats"
      "syntax-highlight"
      "qlmarkdown"
      "quicklook-json"
    ];
  };
  
  # ==========================================================
  # ACTIVATION SCRIPTS
  # ==========================================================
  system.activationScripts.postActivation.text = ''
    mkdir -p /Users/damiancrespi/Screenshots
    mkdir -p /Users/damiancrespi/Sites
  '';

  # Essential Nix settings
  nix.settings.experimental-features = "nix-command flakes";
  
  # TouchID setting
  security.pam.services.sudo_local.touchIdAuth = true; 
  
  system.stateVersion = 4;
}