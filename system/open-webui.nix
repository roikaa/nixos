{config, lib, pkgs, ...}:
{ services = {
  open-webui = {
    enable = true;
  #  image = "backplane/open-webui:0-ollama"; # Specify the Docker image
  };
};
}
