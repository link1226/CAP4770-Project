# Use slim Python base
FROM python:3.10-slim

# Install system deps
RUN apt-get update &&  \
    apt-get install -y sqlite3 && \
    apt-get install -y build-essential && \
    rm -rf /var/lib/apt/lists/*

# Set workdir
WORKDIR /app

# Install Python deps
COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Copy your code and data
COPY . .

# Expose ports:
# - 8501 for Streamlit
# - 8888 for Jupyter
EXPOSE 8501 8888

# Make start.sh executable
RUN chmod +x start.sh

# Run the startup script
CMD ["./start.sh"]
