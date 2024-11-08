

mkdir -p ./models/clip/
mkdir -p ./models/clip_vision/
mkdir -p ./models/ipadapter/
mkdir -p ./models/upscale_models/

declare -A downloads
aria2c -c -x 16 -s 16 -d ./models/checkpoints -o sd_xl_base_1.0.safetensors https://huggingface.co/stabilityai/stable-diffusion-xl-base-1.0/resolve/main/sd_xl_base_1.0.safetensors
downloads["https://huggingface.co/stabilityai/stable-diffusion-xl-base-1.0/resolve/main/sd_xl_base_1.0.safetensors"]="./models/checkpoints/"
downloads["https://huggingface.co/stabilityai/stable-diffusion-xl-refiner-1.0/resolve/main/sd_xl_refiner_1.0.safetensors"]="./models/checkpoints/"
downloads["https://huggingface.co/stabilityai/stable-diffusion-xl-base-1.0/resolve/main/sd_xl_base_1.0_0.9vae.safetensors"]="./models/checkpoints/"
downloads["https://huggingface.co/runwayml/stable-diffusion-v1-5/blob/main/v1-5-pruned.safetensors"]="./models/checkpoints/"
downloads["https://huggingface.co/runwayml/stable-diffusion-v1-5/resolve/main/v1-5-pruned-emaonly.safetensors"]="./models/checkpoints/"
downloads["https://huggingface.co/frankjoshua/realisticVisionV51_v51VAE/resolve/main/realisticVisionV51_v51VAE.safetensors"]="./models/checkpoints/"
downloads["https://huggingface.co/akshitapps/TurboVisionXL/resolve/main/turbovisionxlSuperFastXLBasedOnNew_tvxlV431Bakedvae.safetensors"]="./models/checkpoints/"
downloads["https://huggingface.co/digiplay/AbsoluteReality_v1.8.1/resolve/main/absolutereality_v181.safetensors"]="./models/checkpoints/"
downloads["https://huggingface.co/autismanon/modeldump/resolve/main/dreamshaper_8.safetensors"]="./models/checkpoints/"
downloads["https://huggingface.co/h94/IP-Adapter/resolve/main/models/ip-adapter-plus_sd15.safetensors"]="./models/ipadapter/"
downloads["https://huggingface.co/h94/IP-Adapter/resolve/main/models/ip-adapter-plus-face_sd15.safetensors"]="./models/ipadapter/"
downloads["https://huggingface.co/h94/IP-Adapter/resolve/main/models/ip-adapter_sd15.safetensors"]="./models/ipadapter/"
downloads["https://huggingface.co/h94/IP-Adapter/resolve/main/models/ip-adapter-full-face_sd15.safetensors"]="./models/ipadapter/"
downloads["https://huggingface.co/h94/IP-Adapter/resolve/main/models/image_encoder/model.safetensors"]="./models/clip_vision/"
downloads["https://huggingface.co/comfyanonymous/ControlNet-v1-1_fp16_safetensors/resolve/main/control_v11e_sd15_ip2p_fp16.safetensors"]="./models/controlnet/"
downloads["https://huggingface.co/comfyanonymous/ControlNet-v1-1_fp16_safetensors/resolve/main/control_v11e_sd15_shuffle_fp16.safetensors"]="./models/controlnet/"
downloads["https://huggingface.co/comfyanonymous/ControlNet-v1-1_fp16_safetensors/resolve/main/control_v11p_sd15_canny_fp16.safetensors"]="./models/controlnet/"
downloads["https://huggingface.co/comfyanonymous/ControlNet-v1-1_fp16_safetensors/resolve/main/control_v11f1p_sd15_depth_fp16.safetensors"]="./models/controlnet/"
downloads["https://huggingface.co/comfyanonymous/ControlNet-v1-1_fp16_safetensors/resolve/main/control_v11p_sd15_inpaint_fp16.safetensors"]="./models/controlnet/"
downloads["https://huggingface.co/comfyanonymous/ControlNet-v1-1_fp16_safetensors/resolve/main/control_v11p_sd15_lineart_fp16.safetensors"]="./models/controlnet/"
downloads["https://huggingface.co/comfyanonymous/ControlNet-v1-1_fp16_safetensors/resolve/main/control_v11p_sd15_mlsd_fp16.safetensors"]="./models/controlnet/"
downloads["https://huggingface.co/comfyanonymous/ControlNet-v1-1_fp16_safetensors/resolve/main/control_v11p_sd15_normalbae_fp16.safetensors"]="./models/controlnet/"
downloads["https://huggingface.co/comfyanonymous/ControlNet-v1-1_fp16_safetensors/resolve/main/control_v11p_sd15_openpose_fp16.safetensors"]="./models/controlnet/"
downloads["https://huggingface.co/comfyanonymous/ControlNet-v1-1_fp16_safetensors/resolve/main/control_v11p_sd15_scribble_fp16.safetensors"]="./models/controlnet/"
downloads["https://huggingface.co/comfyanonymous/ControlNet-v1-1_fp16_safetensors/resolve/main/control_v11p_sd15_seg_fp16.safetensors"]="./models/controlnet/"
downloads["https://huggingface.co/comfyanonymous/ControlNet-v1-1_fp16_safetensors/resolve/main/control_v11p_sd15_softedge_fp16.safetensors"]="./models/controlnet/"
downloads["https://huggingface.co/comfyanonymous/ControlNet-v1-1_fp16_safetensors/resolve/main/control_v11p_sd15s2_lineart_anime_fp16.safetensors"]="./models/controlnet/"
downloads["https://huggingface.co/comfyanonymous/ControlNet-v1-1_fp16_safetensors/resolve/main/control_v11u_sd15_tile_fp16.safetensors"]="./models/controlnet/"
downloads["https://huggingface.co/stabilityai/sd-vae-ft-ema-original/resolve/main/vae-ft-ema-560000-ema-pruned.ckpt"]="./models/vae/"
downloads["https://huggingface.co/uwg/upscaler/resolve/main/ESRGAN/4x_NickelbackFS_72000_G.pth"]="./models/upscale_models"

# Loop through the associative array
for url in "${!downloads[@]}"; do
    outdir="${downloads[$url]}"

    # Extract the filename from the URL
    filename=$(basename "$url")

    # Run aria2c with the specified options
    echo "Downloading $filename to $outdir using aria2c"
    aria2c -c -x 16 -s 16 -d "$outdir" -o "$filename" "$url"
done

# Unique download params
aria2c -c -x 16 -s 16 --auto-file-renaming=false -d ./models/checkpoints/ "https://civitai.com/api/download/models/251662"
aria2c -c -x 16 -s 16 --auto-file-renaming=false -d ./models/checkpoints/ "https://civitai.com/api/download/models/132632"
aria2c -c -x 16 -s 16 -d ./models/clip_vision/ -o SD15_CLIP-ViT-bigG-14-laion2B-39B-b160k.safetensors "https://huggingface.co/h94/IP-Adapter/resolve/main/models/image_encoder/model.safetensors"






#













