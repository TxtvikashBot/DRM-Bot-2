FROM python:3.9.7-slim-buster

WORKDIR /app
COPY . /app

# Install all required packages
RUN apt-get update -y && apt-get install -y \
    build-essential \
    curl \
    git \
    cmake \
    aria2 \
    wget \
    pv \
    jq \
    python3-dev \
    ffmpeg \
    mediainfo

# Clone and build Bento4
RUN git clone https://github.com/axiomatic-systems/Bento4.git && \
    cd Bento4 && \
    mkdir cmakebuild && \
    cd cmakebuild && \
    cmake -DCMAKE_BUILD_TYPE=Release .. && \
    make && \
    make install

# Install Python dependencies
RUN pip3 install -r requirements.txt

# Make sure start.sh is executable
RUN chmod +x start.sh

# Start the app
CMD ["sh", "start.sh"]
