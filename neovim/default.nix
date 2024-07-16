{ pkgs, ... }: {
  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    colorscheme = "ayu";

    globals.mapleader = " ";
    globals.maplocalleader = " ";

    # Highlight and remove extra white spaces
    highlight.ExtraWhitespace.bg = "red";
    match.ExtraWhitespace = "\\s\\+$";

    keymaps = [
      {
        key = "<f2>";
        action = "<cmd>Lspsaga rename<cr>";
      }
      {
        key = "<leader>o";
        action = "<cmd>Lspsaga outline<cr>";
      }
      {
        key = "ga";
        action = "<cmd>Lspsaga code_action<cr>";
      }
    ];

    plugins = {
      # Treesitter is just treesitter awesomeness
      treesitter = {
        enable = true;

        nixGrammars = true;
        settings = {
          indent.enable = true;
          ensure_installed = "all";
        };
      };

      # Select and edit delimiters
      # https://github.com/kylechui/nvim-surround
      surround.enable = true;

      # LSP support for CMP
      cmp-nvim-lsp.enable = true;

      # Wrapper around Neovims native LSP formatting.
      # https://github.com/lukas-reineke/lsp-format.nvim
      lsp-format.enable = true;

      # Git wrapper
      # https://github.com/tpope/vim-fugitive
      fugitive.enable = true;

      # Pictrograms for LSP completion
      # https://github.com/onsails/lspkind.nvim
      lspkind.enable = true;

      # Helps managing crates.io dependencies
      # https://github.com/Saecki/crates.nvim
      crates-nvim.enable = true;

      # Better UI for LSP progress and notifications
      # https://github.com/j-hui/fidget.nvim
      fidget.enable = true;

      # Completion
      cmp.enable = true;

      # Just autopair goodness
      # https://github.com/windwp/nvim-autopairs
      nvim-autopairs.enable = true;

      # Seamless session management
      # https://github.com/rmagatti/auto-session
      auto-session = {
        enable = true;
        extraOptions = {
          auto_save_enabled = true;
          auto_restore_enabled = true;
          pre_save_cmds = [ "Neotree close" ];
          post_restore_cmds = [ "Neotree filesystem show" ];
        };
      };

      # Commenting based on treesitter
      # https://github.com/numToStr/Comment.nvim
      comment = {
        enable = true;

        settings = {
          sticky = true;
          opleader = {
            line = "gc";
            block = "gb";
          };
        };
      };

      # File explorer
      # https://github.com/nvim-neo-tree/neo-tree.nvim
      neo-tree = {
        enable = true;
        closeIfLastWindow = true;
        window = {
          position = "left";
          width = 30;
          mappings = {
            "<bs>" = "navigate_up";
            "." = "set_root";
            "f" = "fuzzy_finder";
            "/" = "filter_on_submit";
            "?" = "show_help";
            "l" = "open";
            "h" = "close_node";
          };
        };
        filesystem = {
          followCurrentFile.enabled = true;
          filteredItems = {
            hideHidden = false;
            hideDotfiles = false;
            forceVisibleInEmptyFolder = true;
            hideGitignored = false;
          };
        };
      };

      gitsigns = {
        enable = true;

        settings = {
          current_line_blame = true;
          current_line_blame_opts = {
            virt_text = true;
            virt_text_pos = "eol";
          };
        };
      };

      # Better LSP support
      # https://nvimdev.github.io/lspsaga/
      lspsaga = {
        enable = true;
        lightbulb = {
          enable = true;
          virtualText = false;
        };
        codeAction.keys = {
          quit = "<Esc>";
        };
      };

      rustaceanvim = {
        enable = true;
        rustAnalyzerPackage = pkgs.rust-analyzer;

        settings = {
          auto_attach = true;
          server = {
            standalone = false;
            cmd = [ "rustup" "run" "nightly" "rust-analyzer" ];
            default_settings = {
              rust-analyzer = {
                inlayHints = {
                  parameterHints.enable = false;
                  typeHints.enable = false;
                  lifetimeElisionHints.enable = "never";
                };
                check = { command = "clippy"; };
              };
              cargo = {
                buildScripts.enable = true;
                features = "all";
                runBuildScripts = true;
                loadOutDirsFromCheck = true;
              };
              checkOnSave = true;
              check = {
                allFeatures = true;
                command = "clippy";
                extraArgs = [ "--no-deps" ];
              };
              procMacro = { enable = true; };
              imports = {
                granularity = { group = "module"; };
                prefix = "self";
              };
              files = {
                excludeDirs =
                  [ ".cargo" ".direnv" ".git" "node_modules" "target" ];
              };

              inlayHints = {
                bindingModeHints.enable = true;
                closureStyle = "rust_analyzer";
                closureReturnTypeHints.enable = "always";
                discriminantHints.enable = "always";
                expressionAdjustmentHints.enable = "always";
                implicitDrops.enable = true;
                lifetimeElisionHints.enable = "always";
                rangeExclusiveHints.enable = true;
              };

              rustc.source = "discover";
            };
            diagnostics = {
              enable = true;
              styleLints.enable = true;
            };
          };
        };
      };

      # Status line
      lualine = {
        enable = true;
      };

      lsp = {
        enable = true;

        servers = {
          clangd.enable = true;
          eslint.enable = true;
          html.enable = true;
          jsonls.enable = true;
          pyright.enable = true;
          taplo.enable = true;
          bashls.enable = true;
          tsserver.enable = true;
          marksman.enable = true;
          yamlls.enable = true;
        };

        inlayHints = true;

        keymaps = {
          lspBuf = {
            "<leader>fmt" = "format";
            "<leader>h" = "hover";
          };
        };
      };

      floaterm = {
        enable = true;
        opener = "edit";
        width = 0.8;
        height = 0.8;
      };

      telescope = {
        enable = true;

        extensions.ui-select.enable = true;
        extensions.fzf-native.enable = true;

        settings = {
          defaults = {
            path_display = [ "smart" ];
            layout_strategy = "horizontal";
            layout_config = {
              width = 0.99;
              height = 0.99;
            };
          };
        };
      };

      bufferline = {
        enable = true;
        diagnostics = "nvim_lsp";
      };
    };

    extraPlugins = with pkgs.vimPlugins; [
      neovim-ayu
      vim-vsnip
      cmp-vsnip
      cmp-path
      cmp-spell
      nvim-web-devicons
    ];

    extraConfigLua = builtins.readFile ./config.lua;

    opts = {
      startofline = true;
      showmatch = true;
    };
  };
}
