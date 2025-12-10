{ pkgs, ... }: {
  home.stateVersion = "23.11";

  home.username = "damiancrespi";
  home.homeDirectory = "/Users/damiancrespi";

  # ==========================================================
  # PACKAGES
  # ==========================================================
  home.packages = with pkgs; [
    pnpm
    fnm
    git
    ripgrep 
    jq
    tree
    wget
    watchman
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
  ];

  # ==========================================================
  # CONFIGURATIONS
  # ==========================================================

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    
    initExtra = ''
      eval "$(fnm env --use-on-cd)"
      export PATH=$PATH:~/Sites
    '';

    shellAliases = {
      ll = "ls -l";
      gs = "git status";
    };
  };

  programs.git = {
    enable = true;
    # FIX: New syntax for Git settings
    extraConfig = {
      user = {
        name = "Damian Crespi";
        email = "your.email@example.com"; # TODO: Check this!
      };
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };

  programs.vscode = {
    enable = true;
    # FIX: Extensions moved to profiles.default.extensions
    profiles.default.extensions = with pkgs.vscode-extensions; [
      esbenp.prettier-vscode
      dbaeumer.vscode-eslint
      bradlc.vscode-tailwindcss
      eamodio.gitlens
      github.copilot
      github.copilot-chat
      ms-vsliveshare.vsliveshare
      ms-python.python
      rust-lang.rust-analyzer
      mechatroner.rainbow-csv
    ];
  };
}