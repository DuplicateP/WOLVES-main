# Step 1: Python ka stable version use karein
FROM python:3.10.8-slim-buster

# Step 2: System dependencies install karein (Video downloading aur FFmpeg ke liye)
RUN apt-get update -y && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends \
    gcc \
    python3-dev \
    libffi-dev \
    musl-dev \
    ffmpeg \
    aria2 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Step 3: Working directory set karein
WORKDIR /app

# Step 4: Pehle requirements install karein (Caching optimization ke liye)
COPY requirements.txt .
RUN pip3 install --no-cache-dir --upgrade pip \
    && pip3 install --no-cache-dir -r requirements.txt

# Step 5: Saari project files copy karein
COPY . .

# Step 6: Environment variables set karein
# Render automatically $PORT assign karta hai, hum default 10000 rakh rahe hain
ENV PORT=10000
ENV PYTHONUNBUFFERED=1

# Step 7: Bot aur Flask ko ek saath start karein
# Note: Agar aapne main.py mein threading setup kar liya hai (jo maine pehle bataya), 
# toh sirf 'python3 main.py' hi kaafi hai. 
CMD ["python3", "main.py"]
