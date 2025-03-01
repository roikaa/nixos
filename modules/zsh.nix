{config, lib, pkgs, ...}:

{
  home.packages = with pkgs; [zsh];
  
  programs.oh-my-posh = {
  enable = true;
  useTheme = "gruvbox";  # You can choose any theme you prefer
  enableZshIntegration = true;
};

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    #autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ll = "ls -l";
      edit = "sudo -e";
      update = "sudo nixos-rebuild switch";
    };

    history.size = 10000;
    history.ignoreAllDups = true;
    history.path = "$HOME/.zsh_history";
    history.ignorePatterns = ["rm *" "pkill *" "cp *"];
    oh-my-zsh = {
      #enable = true;
      #plugins = ["git" "thefuck"];
      #theme = "robbyrussell";
    };

  };
}
