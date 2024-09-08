# Usar una imagen base de Python
FROM python:3.10.14-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libgl1-mesa-glx \
    libglib2.0-0 \
    alsa-utils \
    libasound2 \
    libasound2-dev \
    && rm -rf /var/lib/apt/lists/*

# Create a symlink for /usr/bin/python3 if it's not there (maybe a solution????)
RUN ln -s $(which python3) /usr/bin/python3

# Establecer el directorio de trabajo en la imagen de Docker
WORKDIR /app

# Copiar el archivo de requisitos a la imagen de Docker
COPY requirements.txt .

# Instalar las dependencias
RUN pip install --no-cache-dir -r requirements.txt

# Copiar el código fuente del proyecto a la imagen de Docker, incluyendo la carpeta adicional
COPY . .

# Exponer el puerto que usará la aplicación
EXPOSE 5000

# Comando por defecto para ejecutar la aplicación
CMD ["python", "app.py"]
