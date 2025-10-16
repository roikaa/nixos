{pkgs, lib, config, inputs, ...}:
{

programs.neovim = {
  enable = true;
  extraPython3Packages = ps: with ps; [
    pynvim
  ];
};   

home.file.".config/nvim" = {
	source = inputs.nvim-config;
  recursive = true;

};

home.packages = with pkgs;[
  lua54Packages.luarocks-nix 
  lua5_1
  ripgrep
  fd
  tree-sitter
];
}
