{ config, pkgs, inputs, ... }:
{
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];
  home.packages = with pkgs; [
    ripgrep # needed to use telescope live_grep
  ];
  programs.nixvim = {
    enable = true;
    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
    };
    globals.mapleader = " ";
    keymaps = [
      # Telescope
      {
        action = "<cmd>Telescope live_grep<CR>";
        key = "<leader>fw";
        options = { desc = "Live grep"; };
      }
      {
        action = "<cmd>Telescope find_files<CR>";
        key = "<leader>ff";
        options = { desc = "Find files"; };
      }
      {
        action = "<cmd>Telescope buffers<CR>";
        key = "<leader>fb";
        options = { desc = "Find buffers"; };
      }
      {
        action = "<cmd>Telescope help_tags<CR>";
        key = "<leader>fh";
        options = { desc = "Help page"; };
      }
      {
        action = "<cmd>Telescope oldfiles<CR>";
        key = "<leader>fo";
        options = { desc = "Find oldfiles"; };
      }
      {
        action = "<cmd>Telescope colorscheme<CR>";
        key = "<leader>th";
        options = { desc = "Nvchad themes"; };
      }
      {
        action = "<cmd>Telescope marks<CR>";
        key = "<leader>ma";
        options = { desc = "Telescope bookmarks"; };
      }
      {
        action = "<cmd>Telescope git_commits<CR>";
        key = "<leader>cm";
        options = { desc = "Git commits"; };
      }
      {
        action = "<cmd>Telescope git_status<CR>";
        key = "<leader>gt";
        options = { desc = "Git status"; };
      }

      # nvim-tree
      {
        action = "<cmd>NvimTreeToggle<CR>";
        key = "<leader>e";
        options = { desc = "Toggle nvimtree"; };
      }

      # Buffer navigation (similar to NvChad)
      {
        action = "<cmd>bnext<CR>";
        key = "<Tab>";
        options = { desc = "Goto next buffer"; };
      }
      {
        action = "<cmd>bprevious<CR>";
        key = "<S-Tab>";
        options = { desc = "Goto prev buffer"; };
      }
      {
        action = "<cmd>bd<CR>";
        key = "<leader>x";
        options = { desc = "Close buffer"; };
      }
      {
        action = "<cmd>%bd|e#|bd#<CR>";
        key = "<leader>X";
        options = { desc = "Close all buffers but current"; };
      }

      # Window navigation
      {
        action = "<C-w>h";
        key = "<C-h>";
        options = { desc = "Window left"; };
      }
      {
        action = "<C-w>l";
        key = "<C-l>";
        options = { desc = "Window right"; };
      }
      {
        action = "<C-w>j";
        key = "<C-j>";
        options = { desc = "Window down"; };
      }
      {
        action = "<C-w>k";
        key = "<C-k>";
        options = { desc = "Window up"; };
      }

      # Window resizing
      {
        action = "<cmd>resize +2<CR>";
        key = "<C-Up>";
        options = { desc = "Increase window height"; };
      }
      {
        action = "<cmd>resize -2<CR>";
        key = "<C-Down>";
        options = { desc = "Decrease window height"; };
      }
      {
        action = "<cmd>vertical resize -2<CR>";
        key = "<C-Left>";
        options = { desc = "Decrease window width"; };
      }
      {
        action = "<cmd>vertical resize +2<CR>";
        key = "<C-Right>";
        options = { desc = "Increase window width"; };
      }

      # Save and quit
      {
        action = "<cmd>w<CR>";
        key = "<C-s>";
        options = { desc = "Save file"; };
      }

      # Terminal
      {
        action = "<cmd>split | terminal<CR>";
        key = "<leader>h";
        options = { desc = "New horizontal terminal"; };
      }
      {
        action = "<cmd>vsplit | terminal<CR>";
        key = "<leader>v";
        options = { desc = "New vertical terminal"; };
      }
      {
        mode = "t";
        action = "<C-\\><C-n>";
        key = "<Esc>";
        options = { desc = "Terminal normal mode"; };
      }

      # Miscellaneous
      {
        action = "<cmd>set nu!<CR>";
        key = "<leader>n";
        options = { desc = "Toggle line number"; };
      }
      {
        action = "<cmd>set rnu!<CR>";
        key = "<leader>rn";
        options = { desc = "Toggle relative number"; };
      }
      {
        action = "gg=G";
        key = "<leader>=";
        options = { desc = "Format entire file"; };
      }

      # Which-key cheatsheet
      {
        action = "<cmd>WhichKey<CR>";
        key = "<leader>?";
        options = { desc = "Show keybinding cheatsheet"; };
      }
    ];
    
    # Your nixvim configuration here
    #colorschemes.gruvbox.enable = true;
    plugins = {
      lualine.enable = true;
      web-devicons.enable = true;
      # for opening tabs
      bufferline.enable = true;
      # for using stylinx theme, kinda of
      mini.enable = true;
      # All commands available straight way
      telescope.enable = true;
      # $ nvim . will open oil instad of netrw
      oil.enable = true;
      
      # all parsers included, simpl as that
      treesitter.enable = true;
      # traditional tree pluging
      nvim-tree = {
        enable = true;
        openOnSetup = false;
      };
      # Add luasnip for snippet support
      luasnip.enable = true;

      # Which-key for showing keybinding cheatsheet
      which-key = {
        enable = true;
        settings = {
          delay = 200;
          expand = 1;
          notify = false;
          preset = false;
          replace = {
            desc = [
              [ "<space>" "SPC" ]
              [ "<leader>" "SPC" ]
              [ "<[cC][rR]>" "RET" ]
              [ "<[tT][aA][bB]>" "TAB" ]
            ];
          };
          spec = [
            {
              __unkeyed-1 = "<leader>f";
              group = "Find";
            }
            {
              __unkeyed-1 = "<leader>g";
              group = "Git";
            }
            {
              __unkeyed-1 = "<leader>l";
              group = "LSP";
            }
            {
              __unkeyed-1 = "<leader>t";
              group = "Theme";
            }
            {
              __unkeyed-1 = "<leader>m";
              group = "Marks";
            }
          ];
        };
      };
      # LSP configuration
      lsp = {
        enable = true;
        servers = {
          ts_ls.enable = true;
          
          # lua
          lua_ls = {
            enable = true;
            settings.telemetry.enable = false;
          };
          
          # rust
          rust_analyzer = {
            enable = true;
            installCargo = true;
            installRustc = true;
          };
        };
      };
      
      # Completion configuration - FIXED
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          sources = [
            {name = "nvim_lsp";}
            {name = "path";}
            {name = "buffer";}
            {name = "luasnip";}
          ];
          
          mapping = {
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<Tab>" = ''
              cmp.mapping(function(fallback)
                if cmp.visible() then
                  cmp.select_next_item()
                elseif require("luasnip").expand_or_jumpable() then
                  require("luasnip").expand_or_jump()
                else
                  fallback()
                end
              end, { "i", "s" })
            '';
            "<S-Tab>" = ''
              cmp.mapping(function(fallback)
                if cmp.visible() then
                  cmp.select_prev_item()
                elseif require("luasnip").jumpable(-1) then
                  require("luasnip").jump(-1)
                else
                  fallback()
                end
              end, { "i", "s" })
            '';
          };
        };
      };
    };
  };
}
