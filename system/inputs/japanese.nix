{ config, lib, pkgs, ...}:

{
  imports = [];

  #############################################################
  ## Select internationalisation properties for the console. ##
  #############################################################

  # The font to be used on the console when logging in.  Since most people
  # only use Japanese in X, you can leave this as the default value.
  i18n.consoleFont = "Lat2-Terminus16";

  # The keymap to be used on the console.  Unless you use a special keyboard
  # layout, you can leave this as the default value.
  i18n.consoleKeyMap = "us";

  # The locale to use by default.  Any locale is fine as long as the character
  # set is "UTF-8".  If you want applications on your system to use Japanese by
  # default, you could set the value to "ja_JP.UTF-8".
  i18n.defaultLocale = "en_US.UTF-8";

  ###################
  ## Font Settings ##
  ###################

  # Enable fonts to use on your system.  You should make sure to add at least
  # one English font (like dejavu_fonts), as well as Japanese fonts like
  # "ipafont" and "kochi-substitute".
#  fonts.fonts = with pkgs; [
#    carlito
#    dejavu_fonts
#    ipafont
#    kochi-substitute
#    source-code-pro
#    ttf_bitstream_vera
#  ];
#
#  # Enable the "ultimate" font config.  This enables a few extra options to
#  # make sure fonts look nice.  However, if you enable this and fonts look
#  # strange, try disabling it.
#  fonts.fontconfig.ultimate.enable = true;
#
#  # These settings enable default fonts for your system.  This setting is very
#  # important.  It lets fontconfig know that you want to fall back to a Japanese
#  # font (for example "IPAGothic") if an application tries to show fonts with
#  # Japanese.  For instance, this is important if you are using a terminal
#  # emulator and you `cat` some Japanese text to the screen. If you don't have
#  # "defaultFonts" configured, fontconfig will pick a random Japanese font to
#  # use.  If you have this "defaultFonts" setting configured, fontconfig will
#  # pick the font you have selected.  This makes sure Japanese fonts look nice.
#  fonts.fontconfig.defaultFonts = {
#    monospace = [
#      "DejaVu Sans Mono"
#      "IPAGothic"
#    ];
#    sansSerif = [
#      "DejaVu Sans"
#      "IPAPGothic"
#    ];
#    serif = [
#      "DejaVu Serif"
#      "IPAPMincho"
#    ];
#  };
#
  ###############################
  ## Input Method Editor (IME) ##
  ###############################

  # This enables "fcitx" as your IME.  This is an easy-to-use IME.  It supports many different input methods.
  i18n.inputMethod.enabled = "fcitx";

  # This enables "mozc" as an input method in "fcitx".  This has a relatively
  # complete dictionary.  I recommend it for Japanese input.
  i18n.inputMethod.fcitx.engines = with pkgs.fcitx-engines; [ mozc ];
}
