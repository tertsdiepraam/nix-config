{ config, pkgs, ... }:

{
  imports = [ ./neovim ];

  nixpkgs.config.allowUnfree = true;

  home.username = "terts";
  home.homeDirectory = "/home/terts";

  home.packages = let
    global = with pkgs; [
      alsa-lib
      atuin
      bat
      bind
      bitwarden
      blender
      cargo-nextest
      chromium
      comma
      deno
      difftastic
      discord
      dogdns
      doggo
      element-desktop
      eza
      gcc
      gh
      git
      gitui
      helix
      just
      knot-dns
      ldns
      libreoffice
      libselinux
      mattermost
      mold
      nixfmt
      nodejs
      nodePackages.prettier
      nushell
      obs-studio
      pdns
      pkg-config
      python3
      ripgrep
      rustup
      samply
      slack
      spotify
      thunderbird
      udev
      vlc
      yarn
      zola
      zoom
      zoxide
      zulip
    ];
    kde = with pkgs.kdePackages; [
      akonadi
      akonadi-calendar
      kdeconnect-kde
      kdenlive
      kdepim-runtime
      kmail
      kmail-account-wizard
      kontact
      ktorrent
      yakuake
      merkuro
    ];
  in global ++ kde;

  home.sessionVariables = {
    LIBCLANG_PATH = "${pkgs.llvmPackages.libclang.lib}/lib";
    NIXOS_OZONE_WL = "1";
    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
    EDITOR = "nvim";
  };

  services.ssh-agent.enable = true;

  programs.home-manager.enable = true;

  programs.fish = {
    enable = true;
    shellAbbrs = {
      cr = "cargo run";
      ct = "cargo nextest run";
      cb = "cargo build";
      cbr = "cargo build --release";
    };
  };

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
      window.autoDetectColorScheme = true;
      workbench.preferredDarkColorTheme = "Ayu Dark";
      editor.inlayHints.enabled = "offUnlessPressed";
      git.confirmSync = false;
      editor.rulers = [80 100];
      rust-analyzer.check.command = "clippy";
      git-blame.config.showBlameInline = false;
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
      editor = {
        line-number = "relative";
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        rulers = [78 80 100];
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
