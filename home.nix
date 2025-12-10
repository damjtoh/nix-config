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
    # FIX: Renamed 'extraConfig' to 'settings'
    settings = {
      user = {
        name = "Damian Crespi";
        email = "damian.crespi@gmail.com"; 
      };
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };

  programs.vscode = {
    enable = true;
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