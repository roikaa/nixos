{ config, lib, pkgs, inputs, ... }:
{
services.longview.mysqlPassword = "katanasho";
services.mysql = {
  enable = true;
  package = pkgs.mariadb; # or pkgs.mysql for MySQL
  ensureDatabases = [ "shopex" ];
  ensureUsers = [
    {
      name = "root";
      ensurePermissions = {
        "shopex.*" = "ALL PRIVILEGES";
      };
    }
  ];
};
}
