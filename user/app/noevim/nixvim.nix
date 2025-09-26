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
        desc = "Live grep";
      }
      {
        action = "<cmd>Telescope find_files<CR>";
        key = "<leader>ff";
        desc = "Find files";
      }
      {
        action = "<cmd>Telescope buffers<CR>";
        key = "<leader>fb";
        desc = "Find buffers";
      }
      {
        action = "<cmd>Telescope help_tags<CR>";
        key = "<leader>fh";
        desc = "Help page";
      }
      {
        action = "<cmd>Telescope oldfiles<CR>";
        key = "<leader>fo";
        desc = "Find oldfiles";
      }
      {
        action = "<cmd>Telescope colorscheme<CR>";
        key = "<leader>th";
        desc = "Nvchad themes";
      }
      {
        action = "<cmd>Telescope marks<CR>";
        key = "<leader>ma";
        desc = "Telescope bookmarks";
      }
      {
        action = "<cmd>Telescope git_commits<CR>";
        key = "<leader>cm";
        desc = "Git commits";
      }
      {
        action = "<cmd>Telescope git_status<CR>";
        key = "<leader>gt";
        desc = "Git status";
      }

      # nvim-tree
      {
        action = "<cmd>NvimTreeToggle<CR>";
        key = "<leader>e";
        desc = "Toggle nvimtree";
      }

      # Buffer navigation (similar to NvChad)
      {
        action = "<cmd>bnext<CR>";
        key = "<Tab>";
        desc = "Goto next buffer";
      }
      {
        action = "<cmd>bprevious<CR>";
        key = "<S-Tab>";
        desc = "Goto prev buffer";
      }
      {
        action = "<cmd>bd<CR>";
        key = "<leader>x";
        desc = "Close buffer";
      }
      {
        action = "<cmd>%bd|e#|bd#<CR>";
        key = "<leader>X";
        desc = "Close all buffers but current";
      }

      # Window navigation
      {
        action = "<C-w>h";
        key = "<C-h>";
        desc = "Window left";
      }
      {
        action = "<C-w>l";
        key = "<C-l>";
        desc = "Window right";
      }
      {
        action = "<C-w>j";
        key = "<C-j>";
        desc = "Window down";
      }
      {
        action = "<C-w>k";
        key = "<C-k>";
        desc = "Window up";
      }

      # Window resizing
      {
        action = "<cmd>resize +2<CR>";
        key = "<C-Up>";
        desc = "Increase window height";
      }
      {
        action = "<cmd>resize -2<CR>";
        key = "<C-Down>";
        desc = "Decrease window height";
      }
      {
        action = "<cmd>vertical resize -2<CR>";
        key = "<C-Left>";
        desc = "Decrease window width";
      }
      {
        action = "<cmd>vertical resize +2<CR>";
        key = "<C-Right>";
        desc = "Increase window width";
      }

      # Save and quit
      {
        action = "<cmd>w<CR>";
        key = "<C-s>";
        desc = "Save file";
      }
      {
        action = "<cmd>wq<CR>";
        key = "<leader>w";
        desc = "Save and quit";
      }
      {
        action = "<cmd>q!<CR>";
        key = "<leader>q";
        desc = "Quit without saving";
      }

      # Line manipulation
      {
        mode = "v";
        action = ":m '>+1<CR>gv=gv";
        key = "J";
        desc = "Move line down";
      }
      {
        mode = "v";
        action = ":m '<-2<CR>gv=gv";
        key = "K";
        desc = "Move line up";
      }
      {
        mode = "n";
        action = "<cmd>m .+1<CR>==";
        key = "<A-j>";
        desc = "Move line down";
      }
      {
        mode = "n";
        action = "<cmd>m .-2<CR>==";
        key = "<A-k>";
        desc = "Move line up";
      }

      # Indenting
      {
        mode = "v";
        action = "<gv";
        key = "<";
        desc = "Unindent line";
      }
      {
        mode = "v";
        action = ">gv";
        key = ">";
        desc = "Indent line";
      }

      # Copy/paste
      {
        mode = "v";
        action = ''"_dP'';
        key = "p";
        desc = "Paste without yanking";
      }
      {
        mode = ["n" "v"];
        action = ''"+y'';
        key = "<leader>y";
        desc = "Copy to system clipboard";
      }
      {
        mode = "n";
        action = ''"+Y'';
        key = "<leader>Y";
        desc = "Copy line to system clipboard";
      }

      # Search and replace
      {
        action = "<cmd>noh<CR>";
        key = "<Esc>";
        desc = "Clear search highlights";
      }
      {
        action = '':%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>'';
        key = "<leader>s";
        desc = "Search and replace word under cursor";
      }

      # LSP mappings
      {
        action = "vim.lsp.buf.hover";
        key = "K";
        desc = "LSP hover";
      }
      {
        action = "vim.lsp.buf.definition";
        key = "gd";
        desc = "LSP definition";
      }
      {
        action = "vim.lsp.buf.declaration";
        key = "gD";
        desc = "LSP declaration";
      }
      {
        action = "vim.lsp.buf.implementation";
        key = "gi";
        desc = "LSP implementation";
      }
      {
        action = "vim.lsp.buf.type_definition";
        key = "<leader>D";
        desc = "LSP type definition";
      }
      {
        action = "vim.lsp.buf.references";
        key = "gr";
        desc = "LSP references";
      }
      {
        action = "vim.lsp.buf.signature_help";
        key = "<C-k>";
        mode = "i";
        desc = "LSP signature help";
      }
      {
        action = "vim.lsp.buf.rename";
        key = "<leader>rn";
        desc = "LSP rename";
      }
      {
        action = "vim.lsp.buf.code_action";
        key = "<leader>ca";
        desc = "LSP code action";
      }
      {
        action = "vim.diagnostic.open_float";
        key = "<leader>d";
        desc = "LSP floating diagnostic";
      }
      {
        action = "vim.diagnostic.goto_prev";
        key = "[d";
        desc = "LSP prev diagnostic";
      }
      {
        action = "vim.diagnostic.goto_next";
        key = "]d";
        desc = "LSP next diagnostic";
      }
      {
        action = "vim.diagnostic.setloclist";
        key = "<leader>lq";
        desc = "LSP diagnostic loclist";
      }

      # Format
      {
        action = "vim.lsp.buf.format";
        key = "<leader>fm";
        desc = "LSP formatting";
      }

      # Terminal
      {
        action = "<cmd>split | terminal<CR>";
        key = "<leader>h";
        desc = "New horizontal terminal";
      }
      {
        action = "<cmd>vsplit | terminal<CR>";
        key = "<leader>v";
        desc = "New vertical terminal";
      }
      {
        mode = "t";
        action = "<C-\\><C-n>";
        key = "<Esc>";
        desc = "Terminal normal mode";
      }

      # Miscellaneous
      {
        action = "<cmd>set nu!<CR>";
        key = "<leader>n";
        desc = "Toggle line number";
      }
      {
        action = "<cmd>set rnu!<CR>";
        key = "<leader>rn";
        desc = "Toggle relative number";
      }
      {
        action = "gg=G";
        key = "<leader>=";
        desc = "Format entire file";
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
#{ config, pkgs, inputs, ... }:
#{
#  imports = [
#    inputs.nixvim.homeModules.nixvim
#  ];
#
#  home.packages = with pkgs; [
#    ripgrep # needed to use telescope live_grep
#  ];
#
#  programs.nixvim = {
#    enable = true;
#    opts = {
#      number = true;
#      relativenumber = true;
#      shiftwidth = 2;
#    };
#
#    globals.mapleader = " ";
#
#   keymaps = [
#
#    # Telescope
#    {
#      action = "<cmd>Telescope live_grep<CR>";
#      key = "<leader>g";
#    }
#    # nvim-tree
#    {
#      action = "<cmd>NvimTreeToggle<CR>";
#      key = "<leader>e";
#    }
#    # Bufferline navigation
#
#    ];
#    
#    # Your nixvim configuration here
#    #colorschemes.gruvbox.enable = true;
#    plugins = {
#
#      lualine.enable = true;
#      web-devicons.enable = true;
#
#      # for opening tabs
#      bufferline.enable = true;
#
#      # for using stylinx theme, kinda of
#      mini.enable = true;
#
#      # All commands available straight way
#      telescope.enable = true;
#
#      # $ nvim . will open oil instad of netrw
#      oil.enable = true;
#      
#      # all parsers included, simpl as that
#      treesitter.enable = true;
#
#      # traditional tree pluging
#      nvim-tree = {
#	enable = true;
#	openOnSetup = false;
#      };
#
#      # Add luasnip for snippet support
#      luasnip.enable = true;
#
#      # LSP configuration
#      lsp = {
#        enable = true;
#        servers = {
#          ts_ls.enable = true;
#          
#          # lua
#          lua_ls = {
#            enable = true;
#            settings.telemetry.enable = false;
#          };
#          
#          # rust
#          rust_analyzer = {
#            enable = true;
#            installCargo = true;
#            installRustc = true;
#          };
#        };
#      };
#      
#      # Completion configuration - FIXED
#      cmp = {
#        enable = true;
#        autoEnableSources = true;
#        settings = {
#          sources = [
#            {name = "nvim_lsp";}
#            {name = "path";}
#            {name = "buffer";}
#            {name = "luasnip";}
#          ];
#          
#          mapping = {
#            "<CR>" = "cmp.mapping.confirm({ select = true })";
#            "<Tab>" = ''
#              cmp.mapping(function(fallback)
#                if cmp.visible() then
#                  cmp.select_next_item()
#                elseif require("luasnip").expand_or_jumpable() then
#                  require("luasnip").expand_or_jump()
#                else
#                  fallback()
#                end
#              end, { "i", "s" })
#            '';
#            "<S-Tab>" = ''
#              cmp.mapping(function(fallback)
#                if cmp.visible() then
#                  cmp.select_prev_item()
#                elseif require("luasnip").jumpable(-1) then
#                  require("luasnip").jump(-1)
#                else
#                  fallback()
#                end
#              end, { "i", "s" })
#            '';
#          };
#        };
#      };
#    };
#  };
#}
