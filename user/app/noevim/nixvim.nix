#{ config, pkgs, inputs, ... }:
#
#{
#  imports = [
#    inputs.nixvim.homeModules.nixvim
#  ];
#
#  programs.nixvim = {
#    enable = true;
#
#    opts = {
#     number = true;
#     relativenumber = true;
#
#     shiftwidth = 2;
#
#    };
#    
#    # Your nixvim configuration here
#    #colorschemes.gruvbox.enable = true;
#    plugins = {
#      lualine.enable = true;
#      mini.enable = true;
#    };
#
#    plugins.lsp = {
#      enable = true;
#
#      servers = {
#        ts_ls.enable = true;
#	
#	# lua
#        lua_ls = {
#          enable = true;
#          settings.telemetry.enable = false;
#        };
#
#	# rust
#        rust_analyzer = {
#          enable = true;
#          installCargo = true;
#	  installRustc = true;
#        };
#      };
#    };
#
#      plugins.cmp = {
#      enable = true;
#      autoEnableSources = true;
#      settings = {
#      sources = [
#        {name = "nvim_lsp";}
#        {name = "path";}
#        {name = "buffer";}
#        {name = "luasnip";}
#      ];
#      };
#
#      mapping = {
#        "<CR>" = "cmp.mapping.confirm({ select = true })";
#        "<Tab>" = {
#          action = ''
#            function(fallback)
#              if cmp.visible() then
#                cmp.select_next_item()
#              elseif luasnip.expandable() then
#                luasnip.expand()
#              elseif luasnip.expand_or_jumpable() then
#                luasnip.expand_or_jump()
#              elseif check_backspace() then
#                fallback()
#              else
#                fallback()
#              end
#            end
#          '';
#          modes = [ "i" "s" ];
#        };
#      };
#    };
#  };
#}
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
{ config, pkgs, inputs, ... }:
{
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];
  programs.nixvim = {
    enable = true;
    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
    };
    
    # Your nixvim configuration here
    #colorschemes.gruvbox.enable = true;
    plugins = {
      lualine.enable = true;
      mini.enable = true;
      
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
      
      # Add luasnip for snippet support
      luasnip.enable = true;
    };
  };
}
