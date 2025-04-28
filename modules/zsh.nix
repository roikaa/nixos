{config, lib, pkgs, ...}:

{
  home.packages = with pkgs; [
    zsh
    fzf
    oh-my-posh
    ];
  
  programs.oh-my-posh = {
  enable = true;
  useTheme = "stelbent.minimal";  # You can choose any theme you prefer
  enableZshIntegration = true; 
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ll = "ls -l";
      edit = "sudo -e";
      update = "sudo nixos-rebuild switch";
    };
    
    initExtraBeforeCompInit = "
                  oh-my-posh disable notice
                ";
    #defaultKeymap = "";

    history = {
    size = 10000;
    save = 10000;
    append = true;
    share = true;
    ignoreAllDups = true;
    ignorePatterns = ["rm *" "pkill *" "cp *"];
    ignoreSpace = true;
    path = "$HOME/.zsh_history";
    extended = true;
    };

    oh-my-zsh = {
      enable = true;
      plugins = ["git" "fzf"];
      #theme = "robbyrussell";
    };

  };
}
