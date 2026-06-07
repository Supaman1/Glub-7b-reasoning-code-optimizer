FROM ghcr.io/ggml-org/llama.cpp:server

USER root

# Install python and down-loader scripts cleanly
RUN apt-get update && apt-get install -y python3 python3-pip && rm -rf /var/lib/apt/lists/*
RUN pip3 install --no-cache-dir huggingface_hub --break-system-packages

WORKDIR /app

# OVERRIDE: Destroys the hidden entrypoint block so standard commands work
ENTRYPOINT []

EXPOSE 7860

# Securely downloads your optimization weights and executes the local binary layer
CMD ["/bin/sh", "-c", "python3 -c \"from huggingface_hub import hf_hub_download; hf_hub_download(repo_id='Supaman1/glub-ai-7b-reasoning-optimization', filename='qwen2.5-coder-7b-instruct.Q4_K_M.gguf', local_dir='.')\" && ./llama-server --model qwen2.5-coder-7b-instruct.Q4_K_M.gguf -c 2048 --host 0.0.0.0 --port 7860"]
