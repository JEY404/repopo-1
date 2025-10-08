#!/bin/bash
# ==========================================
# Script: backup.sh
# Sistema de Backup Automatizado
# Objetivo: Identificar archivos modificados en las últimas 24h,
# crear un backup comprimido y registrar el resultado en un log.
# ==========================================

# Variables
FECHA=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_DIR="backups"
LOG_DIR="logs"
BACKUP_FILE="backup_${FECHA}.tar.gz"
LOG_FILE="${LOG_DIR}/backup_${FECHA}.log"

# Crear directorios si no existen
mkdir -p "$BACKUP_DIR" "$LOG_DIR"

echo "===== INICIO DEL BACKUP =====" | tee -a "$LOG_FILE"
echo "Fecha: $(date)" | tee -a "$LOG_FILE"
echo "----------------------------------" | tee -a "$LOG_FILE"

# 1. Identificar archivos modificados en las últimas 24 horas
echo "[INFO] Buscando archivos modificados en las últimas 24h..." | tee -a "$LOG_FILE"
ARCHIVOS=$(find . -type f -mtime -1 ! -path "./$BACKUP_DIR/*" ! -path "./$LOG_DIR/*")

if [ -z "$ARCHIVOS" ]; then
    echo "[WARN] No se encontraron archivos modificados en las últimas 24 horas." | tee -a "$LOG_FILE"
    echo "===== FIN DEL BACKUP =====" | tee -a "$LOG_FILE"
    exit 0
fi

echo "[INFO] Archivos encontrados:" | tee -a "$LOG_FILE"
echo "$ARCHIVOS" | tee -a "$LOG_FILE"

# 2. Crear archivo comprimido con expansión de llaves
echo "[INFO] Creando archivo comprimido: $BACKUP_FILE" | tee -a "$LOG_FILE"
tar -czf "${BACKUP_DIR}/${BACKUP_FILE}" $ARCHIVOS 2>>"$LOG_FILE"

# 3. Verificar resultado del comando
if [ $? -eq 0 ]; then
    echo "[OK] Backup creado correctamente en ${BACKUP_DIR}/${BACKUP_FILE}" | tee -a "$LOG_FILE"
else
    echo "[ERROR] Fallo al crear el archivo comprimido." | tee -a "$LOG_FILE"
fi

# 4. Simular envío de correo electrónico
echo "[INFO] Simulando envío de correo electrónico..." | tee -a "$LOG_FILE"
echo "Asunto: Backup del $FECHA" >> "$LOG_FILE"
echo "Adjuntos: ${BACKUP_FILE}, ${LOG_FILE}" >> "$LOG_FILE"
echo "[SIMULACIÓN] Correo enviado a: admin@correo.com" | tee -a "$LOG_FILE"

echo "----------------------------------" | tee -a "$LOG_FILE"
echo "===== FIN DEL BACKUP =====" | tee -a "$LOG_FILE"