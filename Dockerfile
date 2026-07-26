# 1. Use the official, ultra-lightweight Micromamba image
FROM mambaorg/micromamba:1.5.8-alpine
# 2. Set the working directory inside the container
WORKDIR /app
# 3. Copy the environment file first (helps Docker cache build steps)
COPY --chown=$MAMBA_USER:$MAMBA_USER environment.yml /app/environment.yml
# 4. Install all dependencies from the YAML file
RUN micromamba install -y -n base -f /app/environment.yml && \ micromamba clean --all --yes
# 5. Copy your newly merged python and bash scripts into the container
COPY --chown=$MAMBA_USER:$MAMBA_USER . /app/
# 6. Ensure the main execution environment is active by default
ARG MAMBA_DOCKERFILE_ACTIVATE=1
