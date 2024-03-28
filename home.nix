{ config, pkgs, ... }:

{
  imports = [ ./neovim.nix ];

  nixpkgs.config.allowUnfree = true;

  home.username = "terts";
  home.homeDirectory = "/home/terts";

  home.packages = with pkgs; [
    atuin
    bat
    bitwarden
    cargo-nextest
    comma
    difftastic
    discord
    element-desktop
    eza
    gcc
    gh
    git
    gitui
    helix
    libselinux
    nixfmt
    nodejs
    yarn
    thunderbird
    kdePackages.kdeconnect-kde
    kdePackages.yakuake
    kdePackages.kmail
    kdePackages.kontact
    kdePackages.kmail-account-wizard
    kdePackages.akonadi
    kdePackages.kdepim-runtime
    kdePackages.akonadiconsole
    pkg-config
    python3
    ripgrep
    rustup
    slack
    spotify
    vlc
    zola
    zoxide
  ];

  home.sessionVariables = {
    LIBCLANG_PATH = "${pkgs.llvmPackages.libclang.lib}/lib";
    NIXOS_OZONE_WL = "1";
  };

  programs.home-manager.enable = true;

  programs.fish.enable = true;

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions;
      [ rust-lang.rust-analyzer jnoortheen.nix-ide ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "ayu";
          publisher = "teabyii";
          version = "1.0.5";
          sha256 = "+IFqgWliKr+qjBLmQlzF44XNbN7Br5a119v9WAnZOu4=";
        }
        {
          name = "errorlens";
          publisher = "usernamehw";
          version = "3.16.0";
          sha256 = "Y3M/A5rYLkxQPRIZ0BUjhlkvixDae+wIRUsBn4tREFw=";
        }
      ];
    userSettings = {
      workbench.colorTheme = "Ayu Dark";
      editor.inlayHints.enabled = "offUnlessPressed";
      git.confirmSync = false;
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
        darkreader
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
    languages = {
      language = [{
        name = "rust";
      }];
    };
  };

  programs.zoxide.enable = true;
  programs.atuin.enable = true;

  programs.git = {
    enable = true;
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
    };
    aliases = {
      co = "checkout";
      main = "checkout main";
    };
    userName = "Terts Diepraam";
    userEmail = "terts.diepraam@gmail.com";
  };
}
