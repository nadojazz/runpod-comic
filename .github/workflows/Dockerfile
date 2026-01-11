FROM runpod/pytorch:2.4.0-py3.11-cuda12.4.1-devel-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive

# Tout ce qui écrit (cache/temp) doit aller sur /workspace (network volume RunPod)
ENV WORKSPACE=/workspace \
    TMPDIR=/workspace/tmp \
    XDG_CACHE_HOME=/workspace/.cache \
    PIP_CACHE_DIR=/workspace/.cache/pip \
    HF_HOME=/workspace/hf \
    ACCELERATE_CONFIG_DIR=/workspace/hf/accelerate

RUN apt-get update && apt-get install -y --no-install-recommends \
    git aria2 ffmpeg unzip p7zip-full libgl1 \
    python3-venv python3-tk \
    supervisor \
 && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /workspace/tmp /workspace/.cache/pip /workspace/hf/accelerate \
    /workspace/models /workspace/datasets /workspace/output /workspace/apps /workspace/logs

# --- Kohya ---
WORKDIR /opt
RUN git clone https://github.com/bmaltais/kohya_ss.git
WORKDIR /opt/kohya_ss
RUN python3 -m venv /opt/kohya_ss/venv \
 && . /opt/kohya_ss/venv/bin/activate \
 && python -m pip install --upgrade pip \
 && pip install --no-cache-dir -r requirements_runpod.txt

# --- ComfyUI ---
WORKDIR /opt
RUN git clone https://github.com/comfyanonymous/ComfyUI.git
WORKDIR /opt/ComfyUI
RUN python3 -m pip install --no-cache-dir -r requirements.txt

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 7860 8188
CMD ["/start.sh"]
