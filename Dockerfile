# Use NVIDIA CUDA development base image
FROM nvidia/cuda:12.6.3-devel-ubuntu24.04

RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y git build-essential \
    python3 python3-pip python3-venv python-is-python3 gcc wget \
    ocl-icd-opencl-dev opencl-headers clinfo \
    libclblast-dev libopenblas-dev \
    && mkdir -p /etc/OpenCL/vendors && echo "libnvidia-opencl.so.1" > /etc/OpenCL/vendors/nvidia.icd

# RUN python3 -m pip install --upgrade --break-system-packages pip
RUN python3 -m pip install --upgrade --break-system-packages pytest cmake scikit-build setuptools fastapi uvicorn sse-starlette pydantic-settings starlette-context tqdm

COPY requirements.txt .

RUN python3 -m pip install --break-system-packages -r requirements.txt
RUN python3 -m pip install --break-system-packages torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121

# Install Python dependencies
RUN CUDACXX=/usr/local/cuda/bin/nvcc CMAKE_ARGS="-DGGML_CUDA=on -DCMAKE_CUDA_ARCHITECTURES=80" FORCE_CMAKE=1 pip install --break-system-packages llama-cpp-python

# Create a directory for the script and copy it into the container
WORKDIR /workspace

# Set the default command
CMD ["python", "main.py"]
