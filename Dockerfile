FROM runpod/pytorch:2.8.0-py3.11-cuda12.8.1-cudnn-devel-ubuntu22.04

RUN apt-get update && apt-get install -y --no-install-recommends ffmpeg sox \
    && rm -rf /var/lib/apt/lists/* \
    && curl -LsSf https://astral.sh/uv/install.sh | sh

ENV PATH="/root/.local/bin:$PATH"

WORKDIR /workspace

RUN git clone --depth 1 https://github.com/ace-step/ACE-Step-1.5.git

WORKDIR /workspace/ACE-Step-1.5

EXPOSE 7860

CMD uv sync && uv run acestep --server-name 0.0.0.0
