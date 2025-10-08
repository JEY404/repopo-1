safe_mcd() {
    if [ -z "$1" ]; then
        echo "Error: Debes proporcionar un nombre de directorio."
        return 1
    fi
    mkdir -p "$1" && cd "$1" || echo "No se pudo cambiar al directorio."
}