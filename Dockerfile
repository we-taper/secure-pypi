FROM python:3.13.7-slim-trixie

# Setup basic dependencies: curl for uv, and guarddog
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    && rm -rf /var/lib/apt/lists/*

RUN curl -LsSf https://astral.sh/uv/install.sh | sh
ENV PATH=$HOME/.local/bin:$PATH
RUN pip install --no-cache-dir guarddog
