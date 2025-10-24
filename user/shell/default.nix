{config, lib, pkgs, ...}:

{
  home.packages = with pkgs; [
    zsh
    fzf
    oh-my-posh
    ];
  
programs.starship = {
  enable = true;
  settings = {
    add_newline = true;
    command_timeout = 1300;
    scan_timeout = 50;
    format = "$all$nix_shell$nodejs$lua$golang$rust$php$git_branch$git_commit$git_state$git_status\\n$username$hostname$directory";
    character = {
      success_symbol = "[\uf0da](bold green) ";
      error_symbol = "[✗](bold red) ";
    };
  };
};   
  # programs.oh-my-posh = {
  # enable = true;
  # useTheme = "gruvbox";  # You can choose any theme you prefer
  # enableZshIntegration = true; 
  # };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ll = "ls -l";
      c = "clear"; 
      edit = "sudo -e";
      update = "sudo nixos-rebuild switch";
      youtube = "yt-dlp -f bestaudio -x --audio-format mp3 --audio-quality 320k --embed-thumbnail --add-metadata ";
#yt-dlp -f bestaudio -x --audio-format mp3 --audio-quality 320k --embed-thumbnail --add-metadata --postprocessor-args "-id3v2_version 3"
    };
    
#    initExtraBeforeCompInit = "
#                 oh-my-posh disable notice
#              ";
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
