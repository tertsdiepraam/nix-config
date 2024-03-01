{ config, pkgs, ... }:

{
  imports = [ ./neovim.nix ];

  nixpkgs.config.allowUnfree = true;

  home.username = "terts";
  home.homeDirectory = "/home/terts";

  home.packages = with pkgs; [
    atuin
    bat
    cargo-nextest
    comma
    difftastic
    discord
    element-desktop
    eza
    gcc
    gh
    git
    helix
    libselinux
    nixfmt
    kdePackages.kdeconnect-kde
    kdePackages.yakuake
    python3
    ripgrep
    rustup
    slack
    spotify
    vlc
    vscode
    zoxide
  ];

  home.sessionVariables = {
    LIBCLANG_PATH = "${pkgs.llvmPackages_11.libclang.lib}/lib";
  };

  programs.home-manager.enable = true;

  programs.fish.enable = true;

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions;
      [ rust-lang.rust-analyzer jnoortheen.nix-ide ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [{
        name = "ayu";
        publisher = "teabyii";
        version = "1.0.5";
        sha256 = "+IFqgWliKr+qjBLmQlzF44XNbN7Br5a119v9WAnZOu4=";
      }];
    userSettings = {
      workbench.colorTheme = "Ayu Dark";
      editor.inlayHints.enabled = "offUnlessPressed";

    };
  };

  programs.firefox = {
    enable = true;
    nativeMessagingHosts = [ pkgs.kdePackages.plasma-browser-integration ];
    profiles."terts" = {
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        bitwarden
        plasma-integration
        ublock-origin
        rust-search-extension
      ];
      settings = { "widget.use-xdg-desktop-portal.file-picker" = 1; };
    };
  };

  programs.helix = {
    enable = true;
    settings = {
      theme = "ayu_dark";
      editor.cursor-shape = {
        insert = "bar";
        normal = "block";
        select = "underline";
      };
    };
  };

  programs.zoxide.enable = true;
  programs.atuin.enable = true;

  programs.git = {
    enable = true;
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
    };
    aliases = {
      co = "checkout";
      main = "checkout main";
    };
    userName = "Terts Diepraam";
    userEmail = "terts.diepraam@gmail.com";
  };
}
