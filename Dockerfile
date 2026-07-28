# 1. Use the official, ultra-lightweight and stable Debian Slim
FROM mambaorg/micromamba:2.8.1-debian13-slim
# 2. Set the working directory inside the container
WORKDIR /app
# 3. Copy the environment file first (helps Docker cache build steps)
COPY --chown=$MAMBA_USER:$MAMBA_USER environment.yml /app/environment.yml
# 4. Install all dependencies from the YAML file
RUN /usr/bin/micromamba install -y -n base -f /app/environment.yml && \ 
	/usr/bin/micromamba clean --all --yes
# 5. Install Python libraries using explicit pip context
RUN /opt/conda/bin/pip install --no-cache-dir pandas==2.2.2 numpy==2.0.0
# 5. --- THE SRA-TOOLS FIX --- This creates the configuration directory and writes a dummy configuration profile. It fakes the 
# interactive configuration so fasterq-dump / prefetch work automatically.
RUN mkdir -p /home/$MAMBA_USER/.ncbi && \ 
	printf '/LIBS/GUID = "vcfgenerator-container-guid-001"\n' > /home/$MAMBA_USER/.ncbi/user-settings.mkfg
# 6. Copy your newly merged python and bash scripts into the container
COPY --chown=$MAMBA_USER:$MAMBA_USER . /app/
# 7. Ensure the main execution environment is active by default
ARG MAMBA_DOCKERFILE_ACTIVATE=1
