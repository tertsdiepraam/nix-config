{ config, pkgs, ... }:

{
  imports = [ ./neovim.nix ];

  nixpkgs.config.allowUnfree = true;

  home.username = "terts";
  home.homeDirectory = "/home/terts";
  home.packages = with pkgs; [
    atuin
    bat
    comma
    discord
    element-desktop
    eza
    git
    helix
    plasma5Packages.yakuake
    plasma5Packages.kdeconnect-kde
    nixfmt
    ripgrep
    rustup
    slack
    spotify
    vscode
    zoxide
  ];

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
    userSettings = { workbench.colorTheme = "Ayu Dark"; };
  };

  programs.firefox = {
    enable = true;
    nativeMessagingHosts = [ pkgs.plasma5Packages.plasma-browser-integration ];
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
    };
    aliases = {
      co = "checkout";
      main = "checkout main";
    };
    userName = "Terts Diepraam";
    userEmail = "terts.diepraam@gmail.com";
  };
}
