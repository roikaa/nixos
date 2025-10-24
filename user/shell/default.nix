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
    
    # Custom format for a clean, two-line prompt
    format = lib.concatStrings [
      "$username"
      "$hostname"
      "$directory"
      "$git_branch"
      "$git_status"
      "$nix_shell"
      "$nodejs"
      "$python"
      "$rust"
      "$golang"
      "$lua"
      "$php"
      "$docker_context"
      "$line_break"
      "$character"
    ];

    # Character symbols
    character = {
      success_symbol = "[➜](bold green)";
      error_symbol = "[✗](bold red)";
      vimcmd_symbol = "[←](bold green)";
    };

    # Directory settings
    directory = {
      truncation_length = 3;
      truncate_to_repo = true;
      style = "bold cyan";
      read_only = " 󰌾";
      format = "[$path]($style)[$read_only]($read_only_style) ";
    };

    # Git branch
    git_branch = {
      symbol = " ";
      style = "bold purple";
      format = "on [$symbol$branch]($style) ";
    };

    # Git status
    git_status = {
      style = "bold red";
      conflicted = "🏳";
      ahead = "⇡\${count}";
      behind = "⇣\${count}";
      diverged = "⇕⇡\${ahead_count}⇣\${behind_count}";
      untracked = "?\${count}";
      stashed = "📦";
      modified = "!\${count}";
      staged = "+\${count}";
      renamed = "»\${count}";
      deleted = "✘\${count}";
      format = "([$all_status$ahead_behind]($style))";
    };

    # Nix shell
    nix_shell = {
      symbol = " ";
      style = "bold blue";
      format = "via [$symbol$state]($style) ";
    };

    # Programming languages
    nodejs = {
      symbol = " ";
      style = "bold green";
      format = "via [$symbol($version )]($style)";
    };

    python = {
      symbol = " ";
      style = "bold yellow";
      format = "via [$symbol$pyenv_prefix($version )(\($virtualenv\) )]($style)";
    };

    rust = {
      symbol = " ";
      style = "bold red";
      format = "via [$symbol($version )]($style)";
    };

    golang = {
      symbol = " ";
      style = "bold cyan";
      format = "via [$symbol($version )]($style)";
    };

    lua = {
      symbol = " ";
      style = "bold blue";
      format = "via [$symbol($version )]($style)";
    };

    php = {
      symbol = " ";
      style = "bold purple";
      format = "via [$symbol($version )]($style)";
    };

    # Docker context
    docker_context = {
      symbol = " ";
      style = "bold blue";
      format = "via [$symbol$context]($style) ";
      only_with_files = true;
    };

    # Username (only show if SSH or root)
    username = {
      style_user = "bold yellow";
      style_root = "bold red";
      format = "[$user]($style)@";
      show_always = false;
    };

    # Hostname (only show if SSH)
    hostname = {
      ssh_only = true;
      style = "bold green";
      format = "[$hostname]($style) in ";
    };

    # Execution time
    cmd_duration = {
      min_time = 2000;
      style = "bold yellow";
      format = "took [$duration]($style) ";
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
    nix-shell = "nix-shell --run $SHELL";  # or use $SHELL if you want it dynamic
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
