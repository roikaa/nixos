{pkgs, lib, config, inputs, ...}:
{
programs.neovim = {
  enable = true;
};   

home.file.".config/nvim" = {
	source = inputs.nvim-config;
  recursive = true;

};
}
