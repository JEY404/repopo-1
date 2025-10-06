#!/bin/bash

echo "Iniciando el escaneo..." > scan_report.txt

# Busca archivos que contengan la palabra 'password'
grep -rils "password" /etc /var >> scan_report.txt &

# Busca archivos con permisos de ejecución para todos
find /var -type f -perm -111 2>/dev/null >> scan_report.txt &

echo "Escaneo completado. Revisa el archivo scan_report.txt para los resultados."