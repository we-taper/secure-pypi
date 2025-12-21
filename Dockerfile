FROM ubuntu:24.04

# Setup uv and update PATH to include uv binaries
RUN apt-get update && apt-get install -y curl \
    && curl -LsSf https://astral.sh/uv/install.sh | sh
ENV PATH=$HOME/.local/bin:$PATH

# Setup additional dev tools (not that uv also detects git to generate .gitignore files)
RUN apt-get install -y git