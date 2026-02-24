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
