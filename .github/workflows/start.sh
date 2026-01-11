#!/usr/bin/env bash
set -e

mkdir -p /workspace/{tmp,.cache/pip,hf/accelerate,models,datasets,output,apps,logs}

# Raccourcis utiles
ln -sf /opt/kohya_ss /workspace/apps/kohya_ss
ln -sf /opt/ComfyUI  /workspace/apps/ComfyUI

# Centralise les modèles ComfyUI sur /workspace
mkdir -p /opt/ComfyUI/models/{checkpoints,loras,controlnet,vae}
mkdir -p /workspace/models/{checkpoints,loras,controlnet,vae}

ln -sf /workspace/models/checkpoints /opt/ComfyUI/models/checkpoints
ln -sf /workspace/models/loras       /opt/ComfyUI/models/loras
ln -sf /workspace/models/controlnet  /opt/ComfyUI/models/controlnet
ln -sf /workspace/models/vae         /opt/ComfyUI/models/vae

exec /usr/bin/supervisord
