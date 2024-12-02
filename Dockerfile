FROM python:3.10-slim

WORKDIR /app

# Install required system packages and cleanup
RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first for better caching
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy config file
COPY config.py .

# Copy all other files
COPY . .

# Railway configuration
ENV PORT=5000
EXPOSE 5000

# For debugging
RUN ls -la /app

CMD ["python", "app.py"]