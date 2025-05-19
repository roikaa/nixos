{config, lib, ...}:

{
  services.ollama = {
    enable = true;
    loadModels = [ "llama3.1:8b" "deepseek-r1:1.5b"];
    acceleration = "cuda";  # NVIDIA GPU acceleration
    # acceleration = "rocm";  # AMD GPU acceleration
  };

  services.open-webui.enable = true;
}
