{pkgs, lib, config, inputs, ...}:
{
programs.neovim = {
  enable = true;
};   

home.file.".config/nvim" = {
	source = inputs.nvim-config;
  recursive = true;

};
  home.packages = [
  (pkgs.lua5_1.withPackages (ps: with ps; [
    lfs
    penlight
  ]))
];
}
