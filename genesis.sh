#!/bin/bash

# Función para generar texto aleatorio 
generar_texto() {
  cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 80 | head -n 65
}

# Función para generar una imagen abstracta aleatoria
generar_imagen() {
  local archivo="$1"
  # Generar una imagen con patrones y colores aleatorios
  convert -size 400x400 \
  plasma:fractal \
-modulate 100,150,100 \
-swirl $((RANDOM % 360)) \
-paint $((RANDOM % 5 + 1)) \
"$archivo"
}

# Crear archivos con texto aleatorio
for i in {1..5}; do
  echo "$(generar_texto)" > "./archivo$i.txt"
done

# Convertir todos los archivos TXT a PDF
for i in {1..5}; do
  cp archivo$i.txt archivo$i.html
  wkhtmltopdf -q archivo$i.html archivo$i.pdf
  rm archivo$i.html
done

# Generar 5 imágenes abstractas
for i in {1..5}; do
  generar_imagen "imagen${i}.png"
done