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
        indent = true;

        nixGrammars = true;
        ensureInstalled = "all";
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
            "h" = "show_help";
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

      # Code action highlighting
      # https://github.com/kosayoda/nvim-lightbulb
      nvim-lightbulb = {
        enable = true;
        settings = {
          autocmd = {
            enabled = true;
            updatetime = 200;
          };
          line = {
            enabled = true;
          };
          number = {
            enabled = true;
            hl = "LightBulbNumber";
          };
          float = {
            enabled = true;
            text = "💡";
          };
          sign = {
            enabled = true;
            text = "💡";
          };
          status_text = {
            enabled = true;
            text = "💡";
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
        lightbulb.enable = false;
        codeAction.keys = {
          quit = "<Esc>";
        };
      };

      # Status line
      lualine = {
        enable = true;
        theme = "onedark";
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
    ]

    opts = {
      startofline = true;
      showmatch = true;
    };
  };
}
