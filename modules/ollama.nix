{config, lib, ...}:

{
  services.ollama = {
    enable = true;
    loadModels = [ "gemma3"];
    acceleration = "cuda";  # NVIDIA GPU acceleration
    # acceleration = "rocm";  # AMD GPU acceleration
  };

  services.open-webui.enable = true;
}
