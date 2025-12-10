{ pkgs, ... }: {
  home.stateVersion = "23.11";

  home.username = "damiancrespi";
  home.homeDirectory = "/Users/damiancrespi";

  # ==========================================================
  # PACKAGES (CLI Tools & Fonts)
  # ==========================================================
  home.packages = with pkgs; [
    # 15. pnpm
    pnpm
    
    # 14. fnm (Fast Node Manager)
    fnm
    
    # Core Utilities
    git
    ripgrep 
    jq
    tree
    wget
    watchman
    
    # Fonts (User-level installation)
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
  ];

  # ==========================================================
  # CONFIGURATIONS
  # ==========================================================

  # 2. Zsh Configuration
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    
    # Initialize fnm automatically
    initExtra = ''
      eval "$(fnm env --use-on-cd)"
      export PATH=$PATH:~/Sites
    '';

    shellAliases = {
      ll = "ls -l";
      gs = "git status";
    };
  };

  # 3. Git Configuration
  programs.git = {
    enable = true;
    userName = "Damian Crespi";
    userEmail = "damian.crespi@gmail.com";
    
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };

  # 3. VS Code Extensions (Managed via Nix)
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      # Styling / Formatters
      esbenp.prettier-vscode
      dbaeumer.vscode-eslint
      bradlc.vscode-tailwindcss
      
      # Tools
      eamodio.gitlens
      github.copilot
      github.copilot-chat
      ms-vsliveshare.vsliveshare
      
      # Language Support
      ms-python.python
      rust-lang.rust-analyzer
      
      # Data
      mechatroner.rainbow-csv
    ];
  };
}