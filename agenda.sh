#!/bin/bash

AGENDA="agenda.txt"

# Mostrar menú
mostrar_menu() {
    echo "----------------------------------"
    echo "         AGENDA TELEFONICA        "
    echo "----------------------------------"
    echo "1. Agregar contacto"
    echo "2. Consultar contacto"
    echo "3. Borrar contacto"
    echo "4. Listar contactos"
    echo "5. Ordenar por nombre"
    echo "6. Ordenar por telefono"
    echo "7. Generar reporte"
    echo "0. Salir"
    echo "----------------------------------"
    echo -n "Selecciona una opción: "
}

# Función para agregar un contacto
agregar_contacto() {
    echo -n "Ingrese el nombre del contacto: "
    read nombre
    
    if [ ! -f "$AGENDA" ]; then
        touch "$AGENDA"
        echo "Se ha creado el archivo $AGENDA"
    fi
    
    if grep -q "^$nombre:" "$AGENDA"; then
        echo "El contacto ya existe."
    else
        echo -n "Ingrese el número de teléfono: "
        read telefono
        echo "$nombre:$telefono" >> "$AGENDA"
        echo "Contacto agregado con éxito."
    fi
}

# Función para consultar un contacto
consultar_contacto() {
    echo -n "Ingrese el nombre del contacto a consultar: "
    read nombre
    
    if [ ! -f "$AGENDA" ]; then
        echo "La agenda está vacía."
        return
    fi
    
    telefono=$(grep "^$nombre:" "$AGENDA" | cut -d ':' -f2)
    if [ -z "$telefono" ]; then
        echo "Contacto no encontrado."
    else
        echo "El teléfono de $nombre es: $telefono"
    fi
}

# Función para borrar un contacto
borrar_contacto() {
    echo -n "Ingrese el nombre del contacto a borrar: "
    read nombre
    
    if [ ! -f "$AGENDA" ]; then
        echo "La agenda está vacía."
        return
    fi
    
    if grep -q "^$nombre:" "$AGENDA"; then
        sed -i "/^$nombre:/d" "$AGENDA"
        echo "Contacto borrado con éxito."
    else
        echo "Contacto no encontrado."
    fi
}

# Función para listar todos los contactos
listar_contactos() {
    if [ ! -f "$AGENDA" ] || [ ! -s "$AGENDA" ]; then
        echo "La agenda está vacía."
        return
    fi
    
    echo "Lista de contactos:"
    echo "╔═══════════════════════╦═══════════════╗"
    echo "║ Nombre                ║ Teléfono      ║"
    echo "╠═══════════════════════╬═══════════════╣"
    awk -F: '{printf "║ %-21s ║ %-13s ║\n", $1, $2}' "$AGENDA"
    echo "╚═══════════════════════╩═══════════════╝"
}

# Función para ordenar contactos por nombre
ordenar_por_nombre() {
    if [ ! -f "$AGENDA" ] || [ ! -s "$AGENDA" ]; then
        echo "La agenda está vacía."
        return
    fi
    
    echo "Contactos ordenados por nombre:"
    echo "╔═══════════════════════╦═══════════════╗"
    echo "║ Nombre                ║ Teléfono      ║"
    echo "╠═══════════════════════╬═══════════════╣"
    sort -t ':' -k1,1 "$AGENDA" | awk -F: '{printf "║ %-21s ║ %-13s ║\n", $1, $2}'
    echo "╚═══════════════════════╩═══════════════╝"
}

# Función para ordenar contactos por teléfono
ordenar_por_telefono() {
    if [ ! -f "$AGENDA" ] || [ ! -s "$AGENDA" ]; then
        echo "La agenda está vacía."
        return
    fi
    
    echo "Contactos ordenados por teléfono:"
    echo "╔═══════════════════════╦═══════════════╗"
    echo "║ Nombre                ║ Teléfono      ║"
    echo "╠═══════════════════════╬═══════════════╣"
    sort -t ':' -k2,2 "$AGENDA" | awk -F: '{printf "║ %-21s ║ %-13s ║\n", $1, $2}'
    echo "╚═══════════════════════╩═══════════════╝"
}

# Función para generar reporte
generar_reporte() {
    if [ ! -f "$AGENDA" ] || [ ! -s "$AGENDA" ]; then
        echo "La agenda está vacía. No se puede generar reporte."
        return
    fi
    
    echo "╔═══════════════════════╦═══════════════╗" > reporte_agenda.txt
    echo "║ Nombre                ║ Teléfono      ║" >> reporte_agenda.txt
    echo "╠═══════════════════════╬═══════════════╣" >> reporte_agenda.txt
    sort -t ':' -k1,1 "$AGENDA" | awk -F: '{printf "║ %-21s ║ %-13s ║\n", $1, $2}' >> reporte_agenda.txt
    echo "╚═══════════════════════╩═══════════════╝" >> reporte_agenda.txt
    echo "" >> reporte_agenda.txt
    total=$(wc -l < "$AGENDA")
    echo "Total de contactos: $total" >> reporte_agenda.txt
    echo "Reporte generado en 'reporte_agenda.txt'"
}

# Bucle principal
while true; do
    mostrar_menu
    read opcion
    case $opcion in
        1) agregar_contacto ;;
        2) consultar_contacto ;;
        3) borrar_contacto ;;
        4) listar_contactos ;;
        5) ordenar_por_nombre ;;
        6) ordenar_por_telefono ;;
        7) generar_reporte ;;
        0) echo "Saliendo..."; exit 0 ;;
        *) echo "Opción no válida, intenta de nuevo." ;;
    esac
    echo ""
done
