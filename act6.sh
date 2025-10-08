#!/bin/bash

# Archivo para almacenar las tareas
TAREAS_FILE="tareas.txt"

# Función para agregar una tarea
agregar_tarea() {
  read -p "Ingrese la descripción de la tarea: " tarea
  echo "$tarea" >> "$TAREAS_FILE"
  echo "Tarea agregada."
}

# Función para listar las tareas
listar_tareas() {
  if [ ! -f "$TAREAS_FILE" ]; then
    echo "No hay tareas registradas."
    return
  fi

  echo "Listado de tareas:"
  i=1
  while IFS= read -r tarea; do
    echo "$i. $tarea"
    i=$((i+1))
  done < "$TAREAS_FILE"
}

# Función para eliminar una tarea
eliminar_tarea() {
  if [ ! -f "$TAREAS_FILE" ]; then
    echo "No hay tareas registradas."
    return
  fi

  listar_tareas

  read -p "Ingrese el número de la tarea a eliminar: " numero
  if ! [[ "$numero" =~ ^[0-9]+$ ]]; then
    echo "Por favor, ingrese un número válido."
    return
  fi

  linea_a_eliminar=$((numero - 1))
  
  if [ "$linea_a_eliminar" -lt 0 ]; then
      echo "Número de tarea inválido."
      return
  fi

  temp_file=$(mktemp)
  i=0
  while IFS= read -r tarea; do
    if [ "$i" -ne "$linea_a_eliminar" ]; then
      echo "$tarea" >> "$temp_file"
    fi
    i=$((i+1))
  done < "$TAREAS_FILE"

  # Verificar si el número de tarea es mayor que el número total de tareas
  num_tareas=$(wc -l < "$TAREAS_FILE")
  if [ "$linea_a_eliminar" -ge "$num_tareas" ]; then
    echo "Número de tarea inválido."
    rm -f "$temp_file"
    return
  fi

  mv "$temp_file" "$TAREAS_FILE"
  echo "Tarea eliminada."
}

# Menú principal
while true; do
  echo "
Administrador de Tareas

1. Agregar tarea
2. Listar tareas
3. Eliminar tarea
4. Salir
"
  read -p "Seleccione una opción: " opcion

  case $opcion in
    1)
      agregar_tarea
      ;;
    2)
      listar_tareas
      ;;
    3)
      eliminar_tarea
      ;;
    4)
      echo "Saliendo..."
      break
      ;;
    *)
      echo "Opción inválida."
      ;;
  esac
done