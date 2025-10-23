{pkgs, lib, config, ...}:
{

programs.rofi = {
  enable = true;
  
  extraConfig = {
    modi = "drun,run,filebrowser";
    show-icons = true;
    display-drun = "";
    display-run = "";
    display-filebrowser = "";
  #  display-window = "";
    drun-display-format = "{name} [<span weight='light' size='small'><i>({generic})</i></span>]";
    window-format = "{w} · {c} · {t}";
  };

  theme = 
    let
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
      "window" = {
       # location = lib.mkForce (mkLiteral "east");
        #anchor = lib.mkForce (mkLiteral "east");
        fullscreen = lib.mkForce false;
        height = lib.mkForce (mkLiteral "50%");
        width = lib.mkForce (mkLiteral "500px");
        x-offset = lib.mkForce (mkLiteral "0px");
        y-offset = lib.mkForce (mkLiteral "0px");
        margin = lib.mkForce (mkLiteral "0px");
        padding = lib.mkForce (mkLiteral "0px");
        border = lib.mkForce (mkLiteral "0px solid");
        border-radius = lib.mkForce (mkLiteral "0px");
      };

      "mainbox" = {
        spacing = lib.mkForce (mkLiteral "15px");
        margin = lib.mkForce (mkLiteral "0px");
        padding = lib.mkForce (mkLiteral "45px");
        border = lib.mkForce (mkLiteral "0px solid");
        border-radius = lib.mkForce (mkLiteral "0px 0px 0px 0px");
        children = lib.mkForce (map mkLiteral [ "inputbar" "message" "listview" "mode-switcher" ]);
      };

      "inputbar" = {
        spacing = lib.mkForce (mkLiteral "10px");
        margin = lib.mkForce (mkLiteral "0px");
        padding = lib.mkForce (mkLiteral "0px");
        border = lib.mkForce (mkLiteral "0px solid");
        border-radius = lib.mkForce (mkLiteral "8px");
        children = lib.mkForce (map mkLiteral [ "prompt" "entry" ]);
      };

      "entry" = {
        placeholder = lib.mkForce "search...";
      };

      "listview" = {
        columns = lib.mkForce 1;
        lines = lib.mkForce 20;
        cycle = lib.mkForce true;
        dynamic = lib.mkForce true;
        scrollbar = lib.mkForce false;
        fixed-height = lib.mkForce true;
        fixed-columns = lib.mkForce true;
        spacing = lib.mkForce (mkLiteral "6px");
        margin = lib.mkForce (mkLiteral "0px");
        padding = lib.mkForce (mkLiteral "0px");
        border = lib.mkForce (mkLiteral "0px solid");
        border-radius = lib.mkForce (mkLiteral "0px");
      };

      "scrollbar" = {
        handle-width = lib.mkForce (mkLiteral "5px");
        border-radius = lib.mkForce (mkLiteral "8px");
      };

      "element" = {
        spacing = lib.mkForce (mkLiteral "10px");
        margin = lib.mkForce (mkLiteral "0px");
        padding = lib.mkForce (mkLiteral "5px");
        border = lib.mkForce (mkLiteral "0px solid");
        border-radius = lib.mkForce (mkLiteral "5px");
      };

      "element-icon" = {
        border-radius = lib.mkForce (mkLiteral "5px");
        padding = lib.mkForce (mkLiteral "5px");
        size = lib.mkForce (mkLiteral "20px");
      };

      "element-text" = {
        vertical-align = lib.mkForce (mkLiteral "0.5");
        horizontal-align = lib.mkForce (mkLiteral "0.0");
      };

      "mode-switcher" = {
        spacing = lib.mkForce (mkLiteral "7px");
        margin = lib.mkForce (mkLiteral "0px");
        padding = lib.mkForce (mkLiteral "0px");
        border = lib.mkForce (mkLiteral "0px solid");
        border-radius = lib.mkForce (mkLiteral "0px");
      };

      "button" = {
        padding = lib.mkForce (mkLiteral "15px");
        border = lib.mkForce (mkLiteral "0px solid");
        border-radius = lib.mkForce (mkLiteral "4px");
      };

      "message" = {
        margin = lib.mkForce (mkLiteral "0px");
        padding = lib.mkForce (mkLiteral "0px");
        border = lib.mkForce (mkLiteral "0px solid");
        border-radius = lib.mkForce (mkLiteral "0px 0px 0px 0px");
      };

      "textbox" = {
        padding = lib.mkForce (mkLiteral "8px");
        border = lib.mkForce (mkLiteral "0px solid");
        border-radius = lib.mkForce (mkLiteral "4px");
        vertical-align = lib.mkForce (mkLiteral "0.5");
        horizontal-align = lib.mkForce (mkLiteral "0.0");
      };

      "error-message" = {
        padding = lib.mkForce (mkLiteral "10px");
        border = lib.mkForce (mkLiteral "0px solid");
        border-radius = lib.mkForce (mkLiteral "4px");
      };
    };
};
 }


