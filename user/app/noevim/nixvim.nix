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
      key = "<leader>g";
    }
    # nvim-tree
    {
      action = "<cmd>NvimTreeToggle<CR>";
      key = "<leader>e";
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
