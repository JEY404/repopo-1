# Agenda Telefónica

## Descripción General
Sistema de gestión de contactos implementado en Bash para almacenar nombres y números de teléfono.

## Archivo Principal
- **agenda.sh**: Script principal que ejecuta la agenda telefónica

## Funcionalidades Implementadas
1. **Agregar contacto**: Permite añadir nuevos contactos con nombre y teléfono
2. **Consultar contacto**: Busca y muestra el número de teléfono de un contacto específico
3. **Borrar contacto**: Elimina un contacto de la agenda
4. **Listar contactos**: Muestra todos los contactos almacenados con formato visual
5. **Ordenar por nombre**: Organiza contactos alfabéticamente por nombre
6. **Ordenar por teléfono**: Organiza contactos numéricamente por teléfono
7. **Generar reporte**: Crea un archivo `reporte_agenda.txt` con lista ordenada de contactos

## Archivos de Datos
- **agenda.txt**: Archivo de almacenamiento con formato `nombre:telefono`
- **reporte_agenda.txt**: Archivo generado con el reporte de contactos

## Estado del Proyecto
- Fecha de implementación: Octubre 6, 2025
- Estado: Completo y funcional
- Todas las funcionalidades probadas exitosamente

## Estructura del Código
El script utiliza comandos bash estándar:
- `grep`: Para búsqueda de contactos
- `sed`: Para eliminación de contactos
- `sort`: Para ordenamiento
- `awk`: Para formateo de salida
- `cut`: Para extracción de campos

## Otros Archivos del Proyecto
- **linux1_shell.md**: Documentación sobre shell en Unix/Linux
- **linux2_commands.md**: Comandos esenciales de Bash
- **linux3_scripting.md**: Guía de scripting en Bash
- **hacker-lab/scanner.sh**: Script de escaneo de seguridad
