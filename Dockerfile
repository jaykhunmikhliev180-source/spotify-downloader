FROM python:3.13-slim-bullseye

LABEL maintainer="Silverarmor"

# Allow customizing the user/group IDs
# Default to 1000
ARG UID=1000
ARG GID=1000

# Install dependencies (Debian tizimi uchun)
RUN apt-get update && apt-get install -y \
    ffmpeg \
    openssl \
    aria2 \
    git \
    && rm -rf /var/lib/apt/lists/*

# Create spotdl user and group
RUN addgroup --gid $GID spotdl && \
    adduser --disabled-password --gecos "" --uid $UID --gid $GID spotdl

# Set workdir
WORKDIR /app

# Copy requirements files
COPY . .

# Install uv and packages
RUN pip install --upgrade pip uv wheel spotify

# Install spotdl requirements
RUN uv sync --no-dev

# Fix permissions for the app dir
RUN chown -R spotdl:spotdl /app

CMD ["spotdl", "web", "--port", "10000", "--host", "0.0.0.0"]

