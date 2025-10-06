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

#!/bin/bash

BANCO="banco.txt"

# Función para mostrar el menú
mostrar_menu() {
    echo "----------------------------------"
    echo "            Banco                 "
    echo "----------------------------------"
    echo "1. Agregar cliente"
    echo "2. Borrar cliente"
    echo "3. Consultar saldo de cliente"
    echo "4. Listar clientes"    # Nueva opción
    echo "5. Consignar"
    echo "6. Retirar"
    echo "7. Total de saldos"
    echo "8. Generar reporte"
    echo "0. Salir"
    echo "----------------------------------"
    echo -n "Selecciona una opción: "
}

# Función para agregar un cliente
agregar_cliente() {
    echo -n "Ingrese el nombre del cliente: "
    read nombre
    # Comprobar si el archivo existe y crearlo si no es así
    if [ ! -f "$BANCO" ]; then
        touch "$BANCO"
        echo "Se ha creado el archivo $BANCO"
    fi
    if grep -q "^$nombre:" "$BANCO"; then
        echo "El cliente ya existe."
    else
        echo -n "Ingrese el saldo inicial: "
        read saldo
        echo "$nombre:$saldo" >> "$BANCO"
        echo "Cliente agregado con éxito."
    fi
}

# Función para borrar un cliente
borrar_cliente() {
    echo -n "Ingrese el nombre del cliente a borrar: "
    read nombre
    sed -i "/^$nombre:/d" "$BANCO"
    echo "Cliente borrado, si existía."
}

# Función para consultar el saldo de un cliente
consultar_saldo() {
    echo -n "Ingrese el nombre del cliente: "
    read nombre
    saldo=$(grep "^$nombre:" "$BANCO" | cut -d ':' -f2)
    if [ -z "$saldo" ]; then
        echo "Cliente no encontrado."
    else
        echo "El saldo de $nombre es: $saldo"
    fi
}

# Función para listar los clientes
listar_clientes() {
    echo "Lista de clientes:"
    echo "╔═══════════════╦════════════╗"
    echo "║ Nombre        ║ Saldo      ║"
    echo "╠═══════════════╬════════════╣"
    awk -F: '{printf "║ %-13s ║ %10d ║\n", $1, $2}' "$BANCO" | sort
    echo "╚═══════════════╩════════════╝"
}

# Función para consignar dinero a un cliente
consignar() {
    echo -n "Ingrese el nombre del cliente: "
    read nombre
    echo -n "Ingrese la cantidad a consignar: "
    read cantidad
    if grep -q "^$nombre:" "$BANCO"; then
        saldo_actual=$(grep "^$nombre:" "$BANCO" | cut -d ':' -f2)
        nuevo_saldo=$((saldo_actual + cantidad))
        sed -i "s/^$nombre:.*/$nombre:$nuevo_saldo/" "$BANCO"
        echo "Consignación realizada. El nuevo saldo es: $nuevo_saldo"
    else
        echo "Cliente no encontrado."
    fi
}

# Función para retirar dinero de un cliente
retirar() {
    echo -n "Ingrese el nombre del cliente: "
    read nombre
    echo -n "Ingrese la cantidad a retirar: "
    read cantidad
    if grep -q "^$nombre:" "$BANCO"; then
        saldo_actual=$(grep "^$nombre:" "$BANCO" | cut -d ':' -f2)
        if [ "$cantidad" -le "$saldo_actual" ]; then
            nuevo_saldo=$((saldo_actual - cantidad))
            sed -i "s/^$nombre:.*/$nombre:$nuevo_saldo/" "$BANCO"
            echo "Retiro realizado. El nuevo saldo es: $nuevo_saldo"
        else
            echo "Saldo insuficiente."
        fi
    else
        echo "Cliente no encontrado."
    fi
}

# Función para mostrar el total de saldos de todos los clientes
total_saldos() {
    total=0
    while IFS=":" read -r nombre saldo; do
        total=$((total + saldo))
    done < "$BANCO"
    echo "El total de saldos es: $total"
}

# Función para generar un reporte ordenado por nombre con total de saldos
generar_reporte() {
    sort -t ':' -k1,1 "$BANCO" > reporte.txt 
    total=0
    while IFS=":" read -r nombre saldo; do
        total=$((total + saldo))
    done < "$BANCO"
    echo "----------------------" >> reporte.txt
    echo "Total de saldos: $total" >> reporte.txt
    echo "Reporte generado en 'reporte.txt'"
}

generar_reporte2() {
  total=0
  echo "╔═══════════════╦════════════╦═════════════════╗" > reporte.txt
  echo "║ Nombre        ║ Saldo      ║ Total Acumulado ║" >> reporte.txt
  echo "╠═══════════════╬════════════╬═════════════════╣" >> reporte.txt
  awk -F: '{printf "║ %-13s ║ %10d ║ %15d ║\n", $1, $2, total+= $2}' "$BANCO" | sort -t ':' -k1,1 >> reporte.txt
  echo "╚═══════════════╩════════════╩═════════════════╝" >> reporte.txt
  echo "Reporte generado en 'reporte.txt'"
}

# Bucle principal
while true; do
    mostrar_menu
    read opcion
    case $opcion in
        1) agregar_cliente ;;
        2) borrar_cliente ;;
        3) consultar_saldo ;;
        4) listar_clientes ;;   
        5) consignar ;;
        6) retirar ;;
        7) total_saldos ;;
        8) generar_reporte2 ;;
        0) echo "Saliendo..."; exit 0 ;;
        *) echo "Opción no válida, intenta de nuevo." ;;
    esac
done