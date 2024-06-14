# Secuenciador de imágenes (y video?)

## Requerimientos

1. Processing 4 (https://processing.org/download/)
2. Video Library (https://processing.org/reference/libraries/video/index.html)
3. Node.js (https://nodejs.org/)

## Uso

1. Agregar el material a procesar en la carpeta `data/archivo`
2. Las subcarpetas deben seguir la estructura `data/archivo/1`, `data/archivo/2`, `data/archivo/3`, etc.
3. Las imágenes dentro de las subcarpetas deben seguir la estructura `data/archivo/1/1.jpg`, `data/archivo/1/2.jpg`, `data/archivo/1/3.jpg`, etc. (Pueden también tener un nombre después del número de imagen, por ejemplo `1-primeraimagen.jpg`)
4. Ejecutar el secuenciador usando Processing

## Organizador de archivos

Para facilitar la organización de una gran cantidad de imágenes y videos, hemos incluido un script llamado `organizador.js` en el root del proyecto. Este script toma todos los archivos de una carpeta de entrada y los distribuye en subcarpetas dentro de `data/archivo`, siguiendo una estructura numerada.

### Instrucciones para el organizador

1. **Preparar el entorno:**

   Coloca todas las imágenes y videos que deseas organizar dentro de una carpeta llamada `input` en el directorio principal de tu proyecto.

2. **Instalar Node.js:**

   Si no tienes Node.js instalado, descárgalo e instálalo desde [aquí](https://nodejs.org/).

3. **Ejecutar el script:**

   Abre una terminal en el directorio raíz del proyecto y ejecuta:

   ```bash
   node organizador.js
