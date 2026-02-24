{
  pkgs,
  inputs,
  ...
}: {
  programs.neovim = {
    enable = true;
    extraPython3Packages = ps:
      with ps; [
        pynvim
      ];

    extraPackages = with pkgs; [
      nil
      nixd
      alejandra
    ];

    plugins = with pkgs.vimPlugins; [
      # ...
      {
        type = "lua";
        plugin = gruvbox-material-nvim;
        config = ''
          require('gruvbox-material').setup({
                      italics = true,
                      contrast = "hard",
                      comments = {
                        italics = true,
                      },
                      background = {
                        transparent = false,
                      },
                      float = {
                        force_background = false,
                        background_color = nil,
                      },
                      signs = {
                        force_background = false,
                        background_color = nil,
                      },
                      customize = nil,
                    })
        '';
      }
    ];
  };

  xdg.configFile."nvim".source = inputs.nvim-config;

  home.packages = with pkgs; [
    lua54Packages.luarocks-nix
    lua5_1
    ripgrep
    fd
    tree-sitter
    alejandra
  ];
}
