{pkgs, lib, config, ...}:
{
    programs.tmux = {
      enable = true;
      clock24 = true;
    };
    
    home.file.".config/tmux" = {
    	source = ./tmux.conf;
        recursive = true;
    };
}
