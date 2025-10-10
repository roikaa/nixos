{pkgs, lib, config, inputs, ...}:
{
programs.neovim = {
  enable = true;
};   

home.file.".config/nvim" = {
	url = inputs.nvim-config;
  recursive = true;

};
}
