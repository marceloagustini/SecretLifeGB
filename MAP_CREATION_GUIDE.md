
# Guía: Creación de Mapas con Tiled para GameBoy

Esta guía explica cómo diseñar niveles usando la herramienta [Tiled](https://www.mapeditor.org/) e integrarlos en el motor del juego.

## Paso 1: Generar la Imagen del Tileset
Para que Tiled sepa qué dibujos usar, necesitamos una imagen (PNG o BMP) que contenga todos tus tiles en orden.

1.  Abre la terminal en la carpeta del proyecto.
2.  Ejecuta:
    ```bash
    python3 tools/gen_tileset_img.py
    ```
3.  Esto generará un archivo en `res/tileset.png`. Este archivo contiene todos los tiles definidos en el sistema.

## Paso 2: Configurar Tiled
1.  Abre **Tiled** y crea un **Nuevo Mapa**.
    -   **Orientación**: Ortogonal.
    -   **Formato de capa de capas**: CSV.
    -   **Tamaño del mapa**: (Ejemplo: 32x32).
    -   **Tamaño del patrón**: 8x8 píxeles (¡Muy importante!).
2.  Añade un **Nuevo Conjunto de Patrones (Tileset)**.
    -   **Imagen**: Selecciona `res/tileset.png`.
    -   **Tamaño del tile**: 8x8 píxeles.
    -   **Margen y Espaciado**: 0.

## Paso 3: Diseñar el Mapa
-   Dibuja tu nivel usando los tiles del panel derecho.
-   Recuerda que los índices de los tiles en Tiled deben coincidir con los de tu código. El primer tile de la imagen será el ID 0 en el juego.

## Paso 4: Exportar el Mapa
1.  En Tiled, ve a **Archivo > Exportar como...**.
2.  Selecciona el formato **CSV files (*.csv)**.
3.  Guarda el archivo (ejemplo: `mi_nuevo_mapa.csv`).

## Paso 5: Convertir a Código C
Usa la herramienta que ya tenemos para convertir ese archivo CSV en un array de C que el GameBoy entienda.

1.  Ejecuta en la terminal:
    ```bash
    python3 tools/tiled_to_c.py mi_nuevo_mapa.csv mi_array_mapa
    ```
2.  La herramienta imprimirá en pantalla algo como esto:
    ```c
    #define MI_ARRAY_MAPA_WIDTH 32
    #define MI_ARRAY_MAPA_HEIGHT 32
    const unsigned char mi_array_mapa[] = {
        1, 1, 1, ...
    };
    ```

## Paso 6: Integración en el Juego
1.  **res/assets.c**: Copia el array generado al final del archivo.
2.  **res/assets.h**: Declara el array y las dimensiones:
    ```c
    extern const unsigned char mi_array_mapa[];
    #define MI_ARRAY_MAPA_WIDTH 32
    #define MI_ARRAY_MAPA_HEIGHT 32
    ```
3.  **src/data/map_config.c**: Añade el mapa a la lista `maps[]` para que el juego pueda cargarlo.

---
**Nota**: Si añades nuevos tiles visuales, primero agrégalos a tus definiciones de diseño, luego regenera la imagen del tileset (Paso 1) y los datos de tiles para que aparezcan en Tiled.
