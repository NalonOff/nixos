{ config, pkgs, ... }:

{
  programs.nixvim = {
    enable = true;

    # Configuration de base
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    # Options générales
    opts = {
      number = true;
      relativenumber = true;
      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      smartindent = true;
      wrap = false;
      swapfile = false;
      backup = false;
      undodir = "${config.home.homeDirectory}/.local/share/nvim/undodir";
      undofile = true;
      hlsearch = false;
      incsearch = true;
      termguicolors = true;
      scrolloff = 8;
      signcolumn = "yes";
      isfname = "@-@";
      updatetime = 50;
      colorcolumn = "80";
      cursorline = true;
      splitbelow = true;
      splitright = true;
      clipboard = "unnamedplus";
      mouse = "a";
      ignorecase = true;
      smartcase = true;
      timeoutlen = 300;
    };

    # Plugins essentiels
    plugins = {
      # Dashboard/Page d'accueil
      alpha = {
        enable = true;
        settings = {
          layout = [
            {
              type = "padding";
              val = 12;
            }
            {
              type = "text";
              val = [
                "                                                     "
                "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗"
                "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║"
                "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║"
                "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║"
                "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║"
                "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝"
                "                                                     "
              ];
              opts = {
                position = "center";
                hl = "Type";
              };
            }
            {
              type = "padding";
              val = 2;
            }
            {
              type = "group";
              val = [
                {
                  type = "button";
                  val = "  Find file";
                  on_press.__raw = "function() require('telescope.builtin').find_files() end";
                  opts = {
                    shortcut = "SPC f f";
                    position = "center";
                    cursor = 3;
                    width = 50;
                    align_shortcut = "right";
                    hl_shortcut = "Keyword";
                  };
                }
                {
                  type = "button";
                  val = "  New file";
                  on_press.__raw = "function() vim.cmd[[ene]] end";
                  opts = {
                    shortcut = "SPC f n";
                    position = "center";
                    cursor = 3;
                    width = 50;
                    align_shortcut = "right";
                    hl_shortcut = "Keyword";
                  };
                }
                {
                  type = "button";
                  val = "  Recent files";
                  on_press.__raw = "function() require('telescope.builtin').oldfiles() end";
                  opts = {
                    shortcut = "SPC f o";
                    position = "center";
                    cursor = 3;
                    width = 50;
                    align_shortcut = "right";
                    hl_shortcut = "Keyword";
                  };
                }
                {
                  type = "button";
                  val = "  Find text";
                  on_press.__raw = "function() require('telescope.builtin').live_grep() end";
                  opts = {
                    shortcut = "SPC f g";
                    position = "center";
                    cursor = 3;
                    width = 50;
                    align_shortcut = "right";
                    hl_shortcut = "Keyword";
                  };
                }
                {
                  type = "button";
                  val = "  Quit";
                  on_press.__raw = "function() vim.cmd[[qa]] end";
                  opts = {
                    shortcut = "SPC q";
                    position = "center";
                    cursor = 3;
                    width = 50;
                    align_shortcut = "right";
                    hl_shortcut = "Keyword";
                  };
                }
              ];
            }
          ];
        };
      };

      # Explorateur de fichiers
      neo-tree = {
        enable = true;
        settings = {
          close_if_last_window = true;
          window = {
            width = 30;
            auto_expand_width = false;
          };
          filesystem = {
            follow_current_file = {
              enabled = true;
            };
            use_libuv_file_watcher = true;
          };
        };
      };

      # Fuzzy finder
      telescope = {
        enable = true;
        keymaps = {
          "<leader>ff" = "find_files";
          "<leader>fg" = "live_grep";
          "<leader>fb" = "buffers";
          "<leader>fh" = "help_tags";
          "<leader>fc" = "grep_string";
          "<leader>fo" = "oldfiles";
        };
        settings = {
          defaults = {
            layout_config = {
              horizontal = {
                prompt_position = "top";
                preview_width = 0.6;
              };
              width = 0.87;
              height = 0.80;
            };
            prompt_prefix = "   ";
            selection_caret = "  ";
            entry_prefix = "  ";
            sorting_strategy = "ascending";
            layout_strategy = "horizontal";
            file_ignore_patterns = [ "^.git/" "^node_modules/" "^target/" "^build/" ];
          };
        };
        extensions = {
          fzf-native = {
            enable = true;
          };
        };
      };

      # Barre de statut
      lualine = {
        enable = true;
        settings = {
          options = {
            globalstatus = true;
	  };
          sections = {
            lualine_a = [ "mode" ];
            lualine_b = [ "branch" "diff" "diagnostics" ];
            lualine_c = [ "filename" ];
            lualine_x = [ "encoding" "fileformat" "filetype" ];
            lualine_y = [ "progress" ];
            lualine_z = [ "location" ];
          };
        };
      };

      # Onglets
      bufferline = {
        enable = true;
        settings = {
          options = {
            mode = "buffers";
            themable = true;
            numbers = "none";
            close_command = "bdelete! %d";
            indicator = {
              style = "icon";
              icon = "▎";
            };
            modified_icon = "●";
            close_icon = "";
            max_name_length = 18;
            tab_size = 18;
            diagnostics = "nvim_lsp";
            offsets = [
              {
                filetype = "neo-tree";
                text = "File Explorer";
                text_align = "center";
                separator = true;
              }
            ];
            show_buffer_icons = true;
            show_buffer_close_icons = true;
            separator_style = "thin";
            always_show_bufferline = true;
          };
        };
      };

      # Coloration syntaxique
      treesitter = {
        enable = true;
        settings = {
          highlight = {
            enable = true;
          };
          indent = {
            enable = true;
          };
          ensure_installed = [
            "bash"
            "c"
            "cpp"
            "css"
            "dockerfile"
            "go"
            "html"
            "javascript"
            "json"
            "lua"
            "markdown"
            "nix"
            "python"
            "rust"
            "typescript"
            "yaml"
            "vim"
            "vimdoc"
          ];
        };
      };

      # File icons
      web-devicons = {
        enable = true;
      };

      # LSP
      lsp = {
        enable = true;
        servers = {
          nixd.enable = true;           # Nix
          lua_ls.enable = true;          # Lua
          pyright.enable = true;         # Python
          rust_analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
          };
          ts_ls.enable = true;           # TypeScript/JavaScript
          gopls.enable = true;           # Go
          clangd.enable = true;          # C/C++
          html.enable = true;            # HTML
          cssls.enable = true;           # CSS
          jsonls.enable = true;          # JSON
          yamlls.enable = true;          # YAML
          dockerls.enable = true;        # Docker
          bashls.enable = true;          # Bash
        };
        keymaps = {
          diagnostic = {
            "<leader>cd" = "open_float";
            "[d" = "goto_prev";
            "]d" = "goto_next";
          };
          lspBuf = {
            "gd" = "definition";
            "gD" = "declaration";
            "gr" = "references";
            "gi" = "implementation";
            "gt" = "type_definition";
            "K" = "hover";
            "<leader>ca" = "code_action";
            "<leader>cr" = "rename";
            "<leader>cf" = "format";
          };
        };
      };

      # Autocomplétion
      cmp = {
        enable = true;
        settings = {
          snippet = {
            expand = "function(args) require('luasnip').lsp_expand(args.body) end";
          };
          mapping = {
            "<C-b>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-e>" = "cmp.mapping.abort()";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<Tab>" = "cmp.mapping(function(fallback) if cmp.visible() then cmp.select_next_item() elseif require('luasnip').expand_or_jumpable() then require('luasnip').expand_or_jump() else fallback() end end, { 'i', 's' })";
            "<S-Tab>" = "cmp.mapping(function(fallback) if cmp.visible() then cmp.select_prev_item() elseif require('luasnip').jumpable(-1) then require('luasnip').jump(-1) else fallback() end end, { 'i', 's' })";
          };
          sources = [
            { name = "nvim_lsp"; }
            { name = "luasnip"; }
            { name = "path"; }
            { name = "buffer"; }
          ];
        };
      };

      # Snippets
      luasnip.enable = true;
      cmp_luasnip.enable = true;
      cmp-nvim-lsp.enable = true;
      cmp-path.enable = true;
      cmp-buffer.enable = true;

      # Formatage automatique
      conform-nvim = {
        enable = true;
        settings = {
          formatters_by_ft = {
            lua = [ "stylua" ];
            python = [ "black" ];
            rust = [ "rustfmt" ];
            javascript = [ "prettier" ];
            typescript = [ "prettier" ];
            json = [ "prettier" ];
            yaml = [ "prettier" ];
            markdown = [ "prettier" ];
            html = [ "prettier" ];
            css = [ "prettier" ];
            nix = [ "nixfmt" ];
          };
          format_on_save = {
            timeout_ms = 500;
            lsp_fallback = true;
          };
        };
      };

      # Git
      gitsigns = {
        enable = true;
        settings = {
          signs = {
            add = { text = "│"; };
            change = { text = "│"; };
            delete = { text = "_"; };
            topdelete = { text = "‾"; };
            changedelete = { text = "~"; };
            untracked = { text = "┆"; };
          };
          current_line_blame = false;
        };
      };

      # Paires automatiques
      nvim-autopairs = {
        enable = true;
        settings = {
          check_ts = true;
          disable_filetype = [ "TelescopePrompt" ];
        };
      };

      # Commentaires
      comment = {
        enable = true;
      };

      # Indentation
      indent-blankline = {
        enable = true;
        settings = {
          indent = {
            char = "│";
          };
          scope = {
            enabled = false;
          };
          exclude = {
            filetypes = [
              "help"
              "alpha"
              "dashboard"
              "neo-tree"
              "Trouble"
              "lazy"
              "mason"
              "notify"
              "toggleterm"
            ];
          };
        };
      };

      # Notifications
      notify = {
        enable = true;
        settings = {
          background_colour = "#000000";
          fps = 30;
          render = "default";
          timeout = 5000;
          top_down = true;
        };
      };

      # Interface améliorée
      dressing = {
        enable = true;
      };

      # Terminal intégré
      toggleterm = {
        enable = true;
        settings = {
          size = 20;
          open_mapping = "[[<c-\\>]]";
          hide_numbers = true;
          shade_terminals = true;
          start_in_insert = true;
          direction = "float";
          close_on_exit = true;
          shell = "${pkgs.bash}/bin/bash";
          float_opts = {
            border = "curved";
          };
        };
      };

      # Which-key pour les raccourcis
      which-key = {
        enable = true;
        settings = {
          delay = 300;
          spec = [
            { __unkeyed = "<leader>f"; group = "file/find"; }
            { __unkeyed = "<leader>c"; group = "code"; }
            { __unkeyed = "<leader>g"; group = "git"; }
            { __unkeyed = "<leader>b"; group = "buffer"; }
            { __unkeyed = "<leader>t"; group = "terminal/tab"; }
          ];
        };
      };
    };

    # Raccourcis clavier
    keymaps = [
      # Général
      { mode = "n"; key = "<leader>w"; action = "<cmd>w<CR>"; options.desc = "Save file"; }
      { mode = "n"; key = "<leader>q"; action = "<cmd>q<CR>"; options.desc = "Quit"; }
      { mode = "n"; key = "<leader>Q"; action = "<cmd>qa<CR>"; options.desc = "Quit all"; }
      { mode = "n"; key = "<leader>fn"; action = "<cmd>enew<CR>"; options.desc = "New file"; }

      # Explorateur de fichiers
      { mode = "n"; key = "<leader>e"; action = "<cmd>Neotree toggle<CR>"; options.desc = "Toggle file explorer"; }

      # Navigation entre buffers
      { mode = "n"; key = "<S-h>"; action = "<cmd>bprevious<CR>"; options.desc = "Previous buffer"; }
      { mode = "n"; key = "<S-l>"; action = "<cmd>bnext<CR>"; options.desc = "Next buffer"; }
      { mode = "n"; key = "<leader>bd"; action = "<cmd>bdelete<CR>"; options.desc = "Delete buffer"; }

      # Déplacement dans les fenêtres
      { mode = "n"; key = "<C-h>"; action = "<C-w>h"; options.desc = "Move to left window"; }
      { mode = "n"; key = "<C-j>"; action = "<C-w>j"; options.desc = "Move to bottom window"; }
      { mode = "n"; key = "<C-k>"; action = "<C-w>k"; options.desc = "Move to top window"; }
      { mode = "n"; key = "<C-l>"; action = "<C-w>l"; options.desc = "Move to right window"; }

      # Redimensionnement des fenêtres
      { mode = "n"; key = "<C-Up>"; action = "<cmd>resize +2<CR>"; options.desc = "Increase window height"; }
      { mode = "n"; key = "<C-Down>"; action = "<cmd>resize -2<CR>"; options.desc = "Decrease window height"; }
      { mode = "n"; key = "<C-Left>"; action = "<cmd>vertical resize -2<CR>"; options.desc = "Decrease window width"; }
      { mode = "n"; key = "<C-Right>"; action = "<cmd>vertical resize +2<CR>"; options.desc = "Increase window width"; }

      # Gestion des onglets
      { mode = "n"; key = "<leader>tn"; action = "<cmd>tabnew<CR>"; options.desc = "New tab"; }
      { mode = "n"; key = "<leader>tc"; action = "<cmd>tabclose<CR>"; options.desc = "Close tab"; }
      { mode = "n"; key = "<leader>to"; action = "<cmd>tabonly<CR>"; options.desc = "Close other tabs"; }

      # Déplacement de lignes
      { mode = "v"; key = "J"; action = ":m '>+1<CR>gv=gv"; options.desc = "Move line down"; }
      { mode = "v"; key = "K"; action = ":m '<-2<CR>gv=gv"; options.desc = "Move line up"; }

      # Recherche
      { mode = "n"; key = "<leader>/"; action = "<cmd>nohlsearch<CR>"; options.desc = "Clear search highlight"; }

      # Git
      { mode = "n"; key = "<leader>gb"; action = "<cmd>Gitsigns blame_line<CR>"; options.desc = "Git blame line"; }
      { mode = "n"; key = "<leader>gp"; action = "<cmd>Gitsigns preview_hunk<CR>"; options.desc = "Preview hunk"; }
      { mode = "n"; key = "<leader>gr"; action = "<cmd>Gitsigns reset_hunk<CR>"; options.desc = "Reset hunk"; }
      { mode = "n"; key = "<leader>gs"; action = "<cmd>Gitsigns stage_hunk<CR>"; options.desc = "Stage hunk"; }
      { mode = "n"; key = "<leader>gu"; action = "<cmd>Gitsigns undo_stage_hunk<CR>"; options.desc = "Undo stage hunk"; }

      # Terminal
      { mode = "n"; key = "<leader>tf"; action = "<cmd>ToggleTerm direction=float<CR>"; options.desc = "Toggle floating terminal"; }
      { mode = "n"; key = "<leader>th"; action = "<cmd>ToggleTerm direction=horizontal<CR>"; options.desc = "Toggle horizontal terminal"; }
      { mode = "n"; key = "<leader>tv"; action = "<cmd>ToggleTerm direction=vertical<CR>"; options.desc = "Toggle vertical terminal"; }
      { mode = "t"; key = "<C-x>"; action = "<C-\\><C-n>"; options.desc = "Exit terminal mode"; }

      # Déplacement de demi-page
      { mode = "n"; key = "<C-d>"; action = "<C-d>zz"; options.desc = "Scroll down half page"; }
      { mode = "n"; key = "<C-u>"; action = "<C-u>zz"; options.desc = "Scroll up half page"; }

      # Recherche et centrage
      { mode = "n"; key = "n"; action = "nzzzv"; options.desc = "Next search result"; }
      { mode = "n"; key = "N"; action = "Nzzzv"; options.desc = "Previous search result"; }
    ];

    # Autocommandes
    autoCmd = [
      {
        event = [ "BufWritePre" ];
        pattern = [ "*" ];
        command = ":%s/\\s\\+$//e";
        desc = "Remove trailing whitespace on save";
      }
      {
        event = [ "TextYankPost" ];
        pattern = [ "*" ];
        callback.__raw = "function() vim.highlight.on_yank() end";
        desc = "Highlight yanked text";
      }
    ];

    # Plugins supplémentaires
    extraPlugins = with pkgs.vimPlugins; [
      vim-sleuth
      vim-surround
      vim-repeat
    ];

    # Configuration Lua supplémentaire
    extraConfigLua = ''
      -- Fermeture rapide pour certains types de fichiers
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "qf", "help", "man", "lspinfo" },
        callback = function()
          vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = true })
          vim.opt_local.buflisted = false
        end,
      })

      -- Restaurer la position du curseur
      vim.api.nvim_create_autocmd("BufReadPost", {
        callback = function()
          local mark = vim.api.nvim_buf_get_mark(0, '"')
          local lcount = vim.api.nvim_buf_line_count(0)
          if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
          end
        end,
      })

      -- Configuration pour les terminaux
      vim.api.nvim_create_autocmd("TermOpen", {
        callback = function()
          vim.opt_local.number = false
          vim.opt_local.relativenumber = false
          vim.opt_local.scrolloff = 0
          vim.cmd("startinsert")
        end,
      })
    '';
  };
}
