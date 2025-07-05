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
      undodir = "${config.xdg.dataHome}/nvim/undodir";
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

    # Thème
    colorschemes.tokyonight = {
      enable = true;
      settings = {
        style = "storm";
        transparent = false;
        terminal_colors = true;
        styles = {
          comments = { italic = true; };
          keywords = { italic = true; };
          functions = {};
          variables = {};
        };
      };
    };

    # Plugins essentiels
    plugins = {
      # Dashboard/Page d'accueil
      alpha = {
        enable = true;
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
                type = "text";
                val = "Quick links";
                opts = {
                  hl = "SpecialComment";
                  position = "center";
                };
              }
              {
                type = "padding";
                val = 1;
              }
              {
                type = "group";
                val = [
                  {
                    type = "button";
                    val = "  Find file";
                    on_press.__raw = "function() require('telescope.builtin').find_files() end";
                    opts = {
                      shortcut = "<leader>ff";
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
                      shortcut = "<leader>fn";
                      position = "center";
                      cursor = 3;
                      width = 50;
                      align_shortcut = "right";
                      hl_shortcut = "Keyword";
                    };
                  }
                  {
                    type = "button";
                    val = "  Recently used files";
                    on_press.__raw = "function() require('telescope.builtin').oldfiles() end";
                    opts = {
                      shortcut = "<leader>fo";
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
                      shortcut = "<leader>fg";
                      position = "center";
                      cursor = 3;
                      width = 50;
                      align_shortcut = "right";
                      hl_shortcut = "Keyword";
                    };
                  }
                  {
                    type = "button";
                    val = "  Configuration";
                    on_press.__raw = "function() vim.cmd[[e ~/.config/nixpkgs/nixvim.nix]] end";
                    opts = {
                      shortcut = "<leader>fc";
                      position = "center";
                      cursor = 3;
                      width = 50;
                      align_shortcut = "right";
                      hl_shortcut = "Keyword";
                    };
                  }
                  {
                    type = "button";
                    val = "  Quit Neovim";
                    on_press.__raw = "function() vim.cmd[[qa]] end";
                    opts = {
                      shortcut = "<leader>q";
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
          }
          {
            type = "padding";
            val = 2;
          }
          {
            type = "text";
            val = "🚀 Happy coding!";
            opts = {
              position = "center";
              hl = "String";
            };
          }
        ];
      };

      # Explorateur de fichiers
      neo-tree = {
        enable = true;
        closeIfLastWindow = true;
        window = {
          width = 30;
          autoExpandWidth = false;
        };
        filesystem = {
          followCurrentFile = {
            enabled = true;
            leaveDirsOpen = true;
          };
          useLibuvFileWatcher = true;
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
              vertical = {
                mirror = false;
              };
              width = 0.87;
              height = 0.80;
              preview_cutoff = 120;
            };
            find_command = ["rg" "--no-heading" "--with-filename" "--line-number" "--column" "--smart-case"];
            prompt_prefix = "   ";
            selection_caret = "  ";
            entry_prefix = "  ";
            initial_mode = "insert";
            selection_strategy = "reset";
            sorting_strategy = "ascending";
            layout_strategy = "horizontal";
            file_sorter.__raw = "require('telescope.sorters').get_fuzzy_file";
            file_ignore_patterns = [ "^.git/" "^node_modules/" "^target/" "^build/" ];
            generic_sorter.__raw = "require('telescope.sorters').get_generic_fuzzy_sorter";
            path_display = [ "truncate" ];
            winblend = 0;
            border = {};
            borderchars = [ "─" "│" "─" "│" "╭" "╮" "╯" "╰" ];
            color_devicons = true;
            use_less = true;
            set_env = { COLORTERM = "truecolor"; };
            file_previewer.__raw = "require('telescope.previewers').vim_buffer_cat.new";
            grep_previewer.__raw = "require('telescope.previewers').vim_buffer_vimgrep.new";
            qflist_previewer.__raw = "require('telescope.previewers').vim_buffer_qflist.new";
          };
        };
      };

      # Barre de statut
      lualine = {
        enable = true;
        globalstatus = true;
        theme = "tokyonight";
        sections = {
          lualine_a = ["mode"];
          lualine_b = ["branch" "diff" "diagnostics"];
          lualine_c = ["filename"];
          lualine_x = ["encoding" "fileformat" "filetype"];
          lualine_y = ["progress"];
          lualine_z = ["location"];
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
            right_mouse_command = "bdelete! %d";
            left_mouse_command = "buffer %d";
            middle_mouse_command = null;
            indicator = {
              icon = "▎";
              style = "icon";
            };
            buffer_close_icon = "󰅖";
            modified_icon = "●";
            close_icon = "";
            left_trunc_marker = "";
            right_trunc_marker = "";
            max_name_length = 18;
            max_prefix_length = 15;
            tab_size = 18;
            diagnostics = "nvim_lsp";
            diagnostics_update_in_insert = false;
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
            show_close_icon = true;
            show_tab_indicators = true;
            persist_buffer_sort = true;
            separator_style = "thin";
            enforce_regular_tabs = false;
            always_show_bufferline = true;
            sort_by = "id";
          };
        };
      };

      # Coloration syntaxique
      treesitter = {
        enable = true;
        nixvimInjections = true;
        settings = {
          highlight = {
            enable = true;
            additional_vim_regex_highlighting = false;
          };
          indent = {
            enable = true;
          };
          auto_install = true;
          ensure_installed = [
            "bash"
            "c"
            "cpp"
            "css"
            "dockerfile"
            "gitignore"
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

      # LSP
      lsp = {
        enable = true;
        servers = {
          nil-ls.enable = true;  # Nix
          lua-ls.enable = true;  # Lua
          pyright.enable = true; # Python
          rust-analyzer.enable = true; # Rust
          tsserver.enable = true; # TypeScript/JavaScript
          gopls.enable = true;   # Go
          clangd.enable = true;  # C/C++
          html.enable = true;    # HTML
          cssls.enable = true;   # CSS
          jsonls.enable = true;  # JSON
          yamlls.enable = true;  # YAML
          dockerls.enable = true; # Docker
          bashls.enable = true;  # Bash
        };
        keymaps = {
          diagnostic = {
            "<leader>cd" = "open_float";
            "<leader>ck" = "goto_prev";
            "<leader>cj" = "goto_next";
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
            expand.__raw = "function(args) require('luasnip').lsp_expand(args.body) end";
          };
          mapping = {
            "<C-b>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-e>" = "cmp.mapping.abort()";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<Tab>".__raw = "cmp.mapping(function(fallback) if cmp.visible() then cmp.select_next_item() elseif require('luasnip').expand_or_jumpable() then require('luasnip').expand_or_jump() else fallback() end end, { 'i', 's' })";
            "<S-Tab>".__raw = "cmp.mapping(function(fallback) if cmp.visible() then cmp.select_prev_item() elseif require('luasnip').jumpable(-1) then require('luasnip').jump(-1) else fallback() end end, { 'i', 's' })";
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
            nix = [ "alejandra" ];
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
          signcolumn = true;
          numhl = false;
          linehl = false;
          word_diff = false;
          watch_gitdir = {
            follow_files = true;
          };
          attach_to_untracked = true;
          current_line_blame = false;
          current_line_blame_opts = {
            virt_text = true;
            virt_text_pos = "eol";
            delay = 1000;
            ignore_whitespace = false;
          };
          sign_priority = 6;
          update_debounce = 100;
          status_formatter = null;
          max_file_length = 40000;
          preview_config = {
            border = "single";
            style = "minimal";
            relative = "cursor";
            row = 0;
            col = 1;
          };
        };
      };

      # Paires automatiques
      nvim-autopairs = {
        enable = true;
        settings = {
          check_ts = true;
          ts_config = {
            lua = [ "string" "source" ];
            javascript = [ "string" "template_string" ];
          };
          disable_filetype = [ "TelescopePrompt" ];
          fast_wrap = {
            map = "<M-e>";
            chars = [ "{" "[" "(" "\"" "'" ];
            pattern.__raw = "string.gsub([[ [%'%\"%)%>%]%)%}%,] ]], ' ', '')";
            offset = 0;
            end_key = "$";
            keys = "qwertyuiopzxcvbnmasdfghjkl";
            check_comma = true;
            highlight = "PmenuSel";
            highlight_grey = "LineNr";
          };
        };
      };

      # Commentaires
      comment = {
        enable = true;
        settings = {
          padding = true;
          sticky = true;
          ignore = null;
          toggler = {
            line = "gcc";
            block = "gbc";
          };
          opleader = {
            line = "gc";
            block = "gb";
          };
          extra = {
            above = "gcO";
            below = "gco";
            eol = "gcA";
          };
          mappings = {
            basic = true;
            extra = true;
          };
          pre_hook = null;
          post_hook = null;
        };
      };

      # Indentation
      indent-blankline = {
        enable = true;
        settings = {
          indent = {
            char = "│";
            tab_char = "│";
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
              "trouble"
              "lazy"
              "mason"
              "notify"
              "toggleterm"
              "lazyterm"
            ];
          };
        };
      };

      # Notifications
      notify = {
        enable = true;
        backgroundColour = "#000000";
        fps = 30;
        render = "default";
        timeout = 5000;
        topDown = true;
      };

      # Interface améliorée
      dressing = {
        enable = true;
        settings = {
          input = {
            enabled = true;
            default_prompt = "Input:";
            prompt_align = "left";
            insert_only = true;
            start_in_insert = true;
            border = "rounded";
            relative = "cursor";
            prefer_width = 40;
            width = null;
            max_width = [ 140 0.9 ];
            min_width = [ 20 0.2 ];
          };
          select = {
            enabled = true;
            backend = [ "telescope" "fzf_lua" "fzf" "builtin" "nui" ];
            trim_prompt = true;
            telescope = null;
            fzf = {
              window = {
                width = 0.5;
                height = 0.4;
              };
            };
            fzf_lua = {
              winopts = {
                height = 0.5;
                width = 0.5;
              };
            };
            nui = {
              position = "50%";
              size = null;
              relative = "editor";
              border = {
                style = "rounded";
              };
              buf_options = {
                swapfile = false;
                filetype = "DressingSelect";
              };
              win_options = {
                winblend = 0;
              };
              max_width = 80;
              max_height = 40;
              min_width = 40;
              min_height = 10;
            };
            builtin = {
              show_numbers = true;
              border = "rounded";
              relative = "editor";
              buf_options = {};
              win_options = {
                winblend = 0;
              };
              width = null;
              max_width = 80;
              max_height = 40;
              min_width = 40;
              min_height = 10;
            };
          };
        };
      };

      # Terminal intégré
      toggleterm = {
        enable = true;
        settings = {
          size = 20;
          open_mapping = "[[<c-\\>]]";
          hide_numbers = true;
          shade_filetypes = [];
          shade_terminals = true;
          shading_factor = 2;
          start_in_insert = true;
          insert_mappings = true;
          persist_size = true;
          direction = "float";
          close_on_exit = true;
          shell = "bash";
          float_opts = {
            border = "curved";
            winblend = 0;
            highlights = {
              border = "Normal";
              background = "Normal";
            };
          };
        };
      };

      # Aide pour les raccourcis
      which-key = {
        enable = true;
        settings = {
          delay = 200;
          expand = 1;
          notify = false;
          preset = false;
          replace = {
            desc = [
              [ "<space>" "SPACE" ]
              [ "<leader>" "SPACE" ]
              [ "<[cC][rR]>" "RETURN" ]
              [ "<[tT][aA][bB]>" "TAB" ]
              [ "<[bB][sS]>" "BACKSPACE" ]
            ];
          };
          spec = [
            {
              __unkeyed-1 = "<leader>f";
              group = "file/find";
            }
            {
              __unkeyed-1 = "<leader>c";
              group = "code";
            }
            {
              __unkeyed-1 = "<leader>g";
              group = "git";
            }
            {
              __unkeyed-1 = "<leader>x";
              group = "diagnostics/quickfix";
            }
            {
              __unkeyed-1 = "<leader>q";
              desc = "quit";
            }
            {
              __unkeyed-1 = "<leader>w";
              desc = "write";
            }
          ];
        };
      };
    };

    # Raccourcis clavier
    keymaps = [
      # Général
      { mode = "n"; key = "<leader>w"; action = ":w<CR>"; options = { desc = "Save file"; }; }
      { mode = "n"; key = "<leader>q"; action = ":q<CR>"; options = { desc = "Quit"; }; }
      { mode = "n"; key = "<leader>Q"; action = ":qa<CR>"; options = { desc = "Quit all"; }; }
      { mode = "n"; key = "<leader>fn"; action = ":enew<CR>"; options = { desc = "New file"; }; }

      # Explorateur de fichiers
      { mode = "n"; key = "<leader>e"; action = ":Neotree toggle<CR>"; options = { desc = "Toggle file explorer"; }; }

      # Navigation entre buffers
      { mode = "n"; key = "<S-h>"; action = ":bprevious<CR>"; options = { desc = "Previous buffer"; }; }
      { mode = "n"; key = "<S-l>"; action = ":bnext<CR>"; options = { desc = "Next buffer"; }; }
      { mode = "n"; key = "<leader>bd"; action = ":bdelete<CR>"; options = { desc = "Delete buffer"; }; }

      # Déplacement dans les fenêtres
      { mode = "n"; key = "<C-h>"; action = "<C-w>h"; options = { desc = "Move to left window"; }; }
      { mode = "n"; key = "<C-j>"; action = "<C-w>j"; options = { desc = "Move to bottom window"; }; }
      { mode = "n"; key = "<C-k>"; action = "<C-w>k"; options = { desc = "Move to top window"; }; }
      { mode = "n"; key = "<C-l>"; action = "<C-w>l"; options = { desc = "Move to right window"; }; }

      # Redimensionnement des fenêtres
      { mode = "n"; key = "<C-Up>"; action = ":resize +2<CR>"; options = { desc = "Increase window height"; }; }
      { mode = "n"; key = "<C-Down>"; action = ":resize -2<CR>"; options = { desc = "Decrease window height"; }; }
      { mode = "n"; key = "<C-Left>"; action = ":vertical resize -2<CR>"; options = { desc = "Decrease window width"; }; }
      { mode = "n"; key = "<C-Right>"; action = ":vertical resize +2<CR>"; options = { desc = "Increase window width"; }; }

      # Gestion des onglets
      { mode = "n"; key = "<leader>tn"; action = ":tabnew<CR>"; options = { desc = "New tab"; }; }
      { mode = "n"; key = "<leader>tc"; action = ":tabclose<CR>"; options = { desc = "Close tab"; }; }
      { mode = "n"; key = "<leader>to"; action = ":tabonly<CR>"; options = { desc = "Close other tabs"; }; }

      # Déplacement de lignes
      { mode = "v"; key = "J"; action = ":m '>+1<CR>gv=gv"; options = { desc = "Move line down"; }; }
      { mode = "v"; key = "K"; action = ":m '<-2<CR>gv=gv"; options = { desc = "Move line up"; }; }

      # Recherche
      { mode = "n"; key = "<leader>/"; action = ":nohlsearch<CR>"; options = { desc = "Clear search highlight"; }; }

      # Git
      { mode = "n"; key = "<leader>gg"; action = ":LazyGit<CR>"; options = { desc = "Open LazyGit"; }; }
      { mode = "n"; key = "<leader>gb"; action = ":Gitsigns blame_line<CR>"; options = { desc = "Git blame line"; }; }
      { mode = "n"; key = "<leader>gp"; action = ":Gitsigns preview_hunk<CR>"; options = { desc = "Preview hunk"; }; }
      { mode = "n"; key = "<leader>gr"; action = ":Gitsigns reset_hunk<CR>"; options = { desc = "Reset hunk"; }; }
      { mode = "n"; key = "<leader>gs"; action = ":Gitsigns stage_hunk<CR>"; options = { desc = "Stage hunk"; }; }
      { mode = "n"; key = "<leader>gu"; action = ":Gitsigns undo_stage_hunk<CR>"; options = { desc = "Undo stage hunk"; }; }

      # Terminal
      { mode = "n"; key = "<leader>tf"; action = ":ToggleTerm direction=float<CR>"; options = { desc = "Toggle floating terminal"; }; }
      { mode = "n"; key = "<leader>th"; action = ":ToggleTerm direction=horizontal<CR>"; options = { desc = "Toggle horizontal terminal"; }; }
      { mode = "n"; key = "<leader>tv"; action = ":ToggleTerm direction=vertical<CR>"; options = { desc = "Toggle vertical terminal"; }; }

      # Échapper du mode terminal
      { mode = "t"; key = "<C-x>"; action = "<C-\\><C-n>"; options = { desc = "Exit terminal mode"; }; }

      # Déplacement de demi-page
      { mode = "n"; key = "<C-d>"; action = "<C-d>zz"; options = { desc = "Scroll down half page"; }; }
      { mode = "n"; key = "<C-u>"; action = "<C-u>zz"; options = { desc = "Scroll up half page"; }; }

      # Recherche et centrage
      { mode = "n"; key = "n"; action = "nzzzv"; options = { desc = "Next search result"; }; }
      { mode = "n"; key = "N"; action = "Nzzzv"; options = { desc = "Previous search result"; }; }
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

    # Plugins supplémentaires via Nix
    extraPlugins = with pkgs.vimPlugins; [
      vim-sleuth  # Détection automatique de l'indentation
      vim-surround # Manipulation des délimiteurs
      vim-repeat   # Répétition des commandes de plugins
    ];

    # Configuration Lua supplémentaire
    extraConfigLua = ''
      -- Configuration personnalisée
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "qf", "help", "man", "lspinfo", "spectre_panel" },
        callback = function()
          vim.cmd([[
            nnoremap <silent> <buffer> q :close<CR>
            set nobuflisted
          ]])
        end,
      })

      -- Restaurer la position du curseur
      vim.api.nvim_create_autocmd("BufReadPost", {
        callback = function()
          local line = vim.fn.line("'\"")
          if line > 1 and line <= vim.fn.line("$") then
            vim.api.nvim_win_set_cursor(0, {line, 0})
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
