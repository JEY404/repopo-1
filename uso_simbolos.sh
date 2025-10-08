#!/bin/bash

echo "=== ANÁLISIS DE VARIABLES ESPECIALES EN BASH ==="
echo ""

# 1. Verificar modos de operación de Bash
echo "1. Modos actuales de Bash (\$-): $-"
echo "   Interpretación:"
if [[ $- == *i* ]]; then
    echo "   - Modo interactivo (i) activo"
fi
if [[ $- == *x* ]]; then
    echo "   - Modo debug (x) activo"
fi
if [[ $- == *u* ]]; then
    echo "   - Nounset (u) activo - variables no definidas causan error"
fi
echo ""

# 2. Mostrar opciones completas del shell
echo "2. Opciones completas del shell (set -o):"
set -o | grep "on$" | head -5
echo ""

# 3. Ejecutar comandos en segundo plano y capturar PIDs
echo "3. Procesos en segundo plano:"
echo "   Iniciando procesos..."
sleep 15 &
pid1=$!
sleep 10 &
pid2=$!

echo "   PID del último comando en segundo plano (\$!): $!"
echo "   PIDs capturados: $pid1, $pid2"
echo ""

# 4. Mostrar información de argumentos
echo "4. Información de argumentos:"
echo "   Nombre del script (\$0): $0"
echo "   Número de argumentos (\$#): $#"
echo "   Todos los argumentos (\$@): $@"
echo "   PID del script actual ($$): $$"
echo ""

# 5. Verificar códigos de salida
echo "5. Verificación de códigos de salida:"
ls /existe &>/dev/null
echo "   Código de salida de 'ls /existe': $?"
ls /nonexistent &>/dev/null
echo "   Código de salida de 'ls /nonexistent': $?"