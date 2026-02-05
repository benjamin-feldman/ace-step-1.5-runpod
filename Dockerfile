FROM pytorch/pytorch:2.4.0-cuda12.4-cudnn9-runtime

ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1

RUN apt-get update && apt-get install -y --no-install-recommends \
    git ffmpeg sox \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

RUN git clone --depth 1 https://github.com/ace-step/ACE-Step-1.5.git && \
    cd ACE-Step-1.5 && pip install --no-cache-dir -e .

WORKDIR /workspace/ACE-Step-1.5

EXPOSE 7860

CMD ["python3", "acestep/acestep_v15_pipeline.py", "--server-name", "0.0.0.0"]
