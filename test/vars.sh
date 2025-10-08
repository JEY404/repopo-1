#!/bin/bash

echo "Nombre del script: $0"
echo "Primer argumento: $1"
echo "Segundo argumento: $2"
echo "Número de argumentos: $#"
echo "Todos los argumentos (usando \$@): $@"
echo "Todos los argumentos (usando \$*): $*"
ls /nonexistentfile
echo "Código de salida del último comando: $?"
echo "PID del script: $$"
sleep 5 &
echo "PID del último comando en segundo plano: $!"
echo "Opciones de shell actuales: $-"
sleep 3
echo "Último argumento del último comando ejecutado: $_"