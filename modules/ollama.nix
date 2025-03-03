{config, lib, ...}:

{
  services.ollama = {
    enable = true;
    acceleration = "cuda";  # NVIDIA GPU acceleration
    # acceleration = "rocm";  # AMD GPU acceleration
  };

  services.open-webui.enable = true;
}
