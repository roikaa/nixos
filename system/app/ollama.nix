{config, lib, ...}:

{
  services.ollama = {
    enable = true;
    loadModels = [ "gemma3" "qwen2.5-coder:7b"];
    acceleration = "cuda";  # NVIDIA GPU acceleration
    # acceleration = "rocm";  # AMD GPU acceleration
  };

  services.open-webui.enable = true;
}
