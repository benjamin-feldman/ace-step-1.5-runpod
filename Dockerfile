FROM nvidia/cuda:12.8.0-cudnn-runtime-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1

RUN apt-get update && apt-get install -y --no-install-recommends \
    software-properties-common && \
    add-apt-repository -y ppa:deadsnakes/ppa && \
    apt-get update && apt-get install -y --no-install-recommends \
    git python3.11 python3.11-venv ffmpeg sox curl \
    && curl -LsSf https://astral.sh/uv/install.sh | sh \
    && rm -rf /var/lib/apt/lists/*

ENV PATH="/root/.local/bin:$PATH"

WORKDIR /workspace

RUN git clone --depth 1 https://github.com/ace-step/ACE-Step-1.5.git && \
    cd ACE-Step-1.5 && \
    uv sync

WORKDIR /workspace/ACE-Step-1.5

EXPOSE 7860

CMD ["uv", "run", "acestep", "--server-name", "0.0.0.0"]
