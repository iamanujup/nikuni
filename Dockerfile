FROM python:3.10-slim
# Prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive
# Install system dependencies
RUN apt-get update -y && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends \
        gcc \
        libffi-dev \
        ffmpeg \
        aria2 \
        python3-pip \
        libpango-1.0-0 \
        libpangoft2-1.0-0 \
        libharfbuzz0b \
        fontconfig \
        fonts-noto \
        tesseract-ocr \
        libjpeg-dev \
        zlib1g-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
# Set workdir
WORKDIR /app
# Copy files
COPY . /app/
# Install python dependencies
RUN pip3 install --no-cache-dir --upgrade -r requirements.txt
# Optional: set Tesseract path (safe default)
ENV TESSDATA_PREFIX=/usr/share/tesseract-ocr/4.00/tessdata
# Default command (run main bot)
CMD ["sh", "-c", "python3 main.py & python3 bot.py"]
