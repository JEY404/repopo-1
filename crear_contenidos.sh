#!/bin/bash

# Función para agregar encabezados a los archivos
agregar_encabezado() {
    local archivo="$1"
    local modulo=$(dirname "$archivo" | xargs basename)
    
    # Crear contenido con encabezado
    cat > "$archivo" << EOF
#!/bin/bash
# ==========================================
# Script: $(basename "$archivo")
# Módulo: $modulo
# Creado el: $(date)
# Descripción: Script principal para $modulo
# ==========================================

echo "Ejecutando $(basename "$archivo") en $modulo"

EOF
    
    echo "Encabezado agregado a: $archivo"
}

# Procesar todos los archivos main_*.sh
for file in Proyecto/src/module_{1..3}/main_{A,B}.sh; do
    if [ -f "$file" ]; then
        agregar_encabezado "$file"
    fi
done

echo "Proceso completado. Todos los archivos tienen encabezados."