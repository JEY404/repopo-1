#!/bin/bash
# Directorios de destino
directorio_textos="textos"
directorio_pdf="documentos"
directorio_imagenes="imagenes"

# Crear directorios si no existen
mkdir -p "$directorio_textos" "$directorio_pdf" "$directorio_imagenes"

# Mover archivos
for archivo in *; do
  extension="${archivo##*.}"
  case "$extension" in
    txt)
      mv "$archivo" "$directorio_textos"
      ;;
    pdf)
      mv "$archivo" "$directorio_pdf"
      ;;
    png)
      mv "$archivo" "$directorio_imagenes"
      ;;
    *)
      echo "Archivo $archivo: extensión no reconocida"
      ;;
  esac
done