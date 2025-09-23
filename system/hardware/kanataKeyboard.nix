{pkgs, lib, config, ...}:
{
services.kanata = {
    enable = true;
    keyboards = {
      internalKeyboard = {
        devices = [
          # Replace the paths below with the appropriate device paths for your setup.
          # Use `ls /dev/input/by-path/` to find your keyboard devices.
          "/dev/input/by-path/pci-0000:00:14.0-usb-0:8:1.0-event-kbd"
          
        ];
	extraDefCfg = ''
			process-unmapped-keys yes
		      '';
        config = ''
          (defsrc
           caps tab d h j k l
          )
          (defvar
           tap-time 200
           hold-time 200
          )
          (defalias
           caps (tap-hold 200 200 esc lmet)
           tab (tap-hold $tap-time $hold-time tab (layer-toggle arrow))
           del del  ;; Alias for the true delete key action
          )
          (deflayer base
           @caps @tab d h j k l
          )
          (deflayer arrow
           _ _ @del left down up right
          )
        '';
      };
    };
  };
}
