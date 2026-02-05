FROM nvidia/cuda:12.8.0-cudnn-runtime-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1

RUN apt-get update && apt-get install -y --no-install-recommends \
    git python3 python3-pip ffmpeg sox curl \
    && curl -LsSf https://astral.sh/uv/install.sh | sh \
    && rm -rf /var/lib/apt/lists/*

ENV PATH="/root/.local/bin:$PATH"

WORKDIR /workspace

RUN git clone --depth 1 https://github.com/ace-step/ACE-Step-1.5.git && \
    cd ACE-Step-1.5 && \
    uv pip install --system acestep/third_parts/nano-vllm && \
    uv pip install --system -e .

WORKDIR /workspace/ACE-Step-1.5

EXPOSE 7860

CMD ["python3", "acestep/acestep_v15_pipeline.py", "--server-name", "0.0.0.0"]
