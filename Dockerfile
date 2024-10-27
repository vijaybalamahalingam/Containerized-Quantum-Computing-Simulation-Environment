# Use the official Jupyter Notebook base image with Python
FROM jupyter/base-notebook:latest

# Set non-interactive installation mode
ARG DEBIAN_FRONTEND=noninteractive

# Install system dependencies required for Python packages like spacy
USER root
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    build-essential \
    libblas-dev \
    liblapack-dev \
    libatlas-base-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Switch back to the default user for jupyter images
USER jovyan

# Set the working directory in the container
WORKDIR /usr/src/app

# Install necessary Python libraries
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy the contents of your project into the container
COPY . .

# Expose the port the notebook runs on
EXPOSE 8888

# Start the Jupyter Notebook server
CMD ["start-notebook.sh", "--NotebookApp.token=''", "--NotebookApp.password=''"]
    