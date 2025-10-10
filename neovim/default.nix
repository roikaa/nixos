{pkgs, lib, config, ...}:
{
programs.neovim = {
  enable = true;
};   

home.file.".config/nvim" = {
  source = builtins.fetchGit {
    url = nvim-config;
    ref = "main";
  };
  recursive = true;

};
}
