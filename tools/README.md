# GameBoy Development Tools

Este directorio contiene una colección de herramientas en Python diseñadas para facilitar el desarrollo de juegos para GameBoy (utilizando GBDK-2020). Estos scripts automatizan la generación de datos de mapas, tiles, sprites y fuentes en formato compatible con C.

---

## 🛠️ Herramientas Disponibles

### 1. `gen_map.py`
Genera un mapa de 32x32 tiles con un diseño de **pueblo/ciudad**.
- **Novedad**: Incluye caminos de adoquines (cobblestone), casas grandes de 4x4 y árboles decorativos de 2x2.
- **Función**: Crea una matriz de datos de mapa (`map_data`) con lógica de zonificación urbana.
- **Uso**: `python3 gen_map.py > output_map.c`

### 2. `gen_npc.py`
Genera los datos de tiles para un sprite de NPC (actualmente un perro).
- **Función**: Convierte una cuadrícula de píxeles (formato de texto) a un array 2bpp de GameBoy.
- **Uso**: `python3 gen_npc.py > npc_data.c`

### 4. `gen_text_tiles.py`
Genera los datos de fuente y caracteres de dibujo de cajas (border decor).
- **Función**: Contiene definiciones de mapas de bits para letras (A-Z), puntuación y bordes de ventanas UI.
- **Uso**: `python3 gen_text_tiles.py > font_data.c`

### 5. `gen_tiles.py`
Genera el conjunto básico de tiles para el fondo (Background).
- **Función**: Define diseños de 8x8 píxeles para hierba, paredes, flores, árboles y partes de casas.
- **Uso**: `python3 gen_tiles.py > tiles_data.c`

### 6. `img_to_c.py`
Convertidor genérico de imágenes PNG a arrays de C compatibles con GameBoy.
- **Función**: Mapea colores RGB a la paleta de 4 grises de GameBoy y organiza los datos en formato 2bpp (2 bytes por fila de 8 píxeles).
- **Uso**: `python3 img_to_c.py <imagen.png> <nombre_variable> > output.c`
- **Requisito**: Requiere la librería `Pillow` (`pip install Pillow`).

### 7. `gen_tileset_img.py`
Genera una imagen visual de todos los tiles actuales.
- **Función**: Crea un archivo `res/tileset.bmp` que contiene todos los tiles definidos en `gen_tiles.py`. Esta imagen es perfecta para cargarla como "Tileset" en editores externos como **Tiled Map Editor**.
- **Uso**: `python3 gen_tileset_img.py`
- **Nota**: No requiere librerías externas.

---

## 🚀 Cómo usar
La mayoría de estas herramientas imprimen el código C directamente en la consola. Puedes redirigir la salida a un archivo para usarlo en tu proyecto:

```bash
python3 tools/gen_tiles.py > src/tiles_data.c
```

> [!NOTE]
> Estas herramientas están optimizadas para el flujo de trabajo de este proyecto específico, generando arrays `unsigned char` listos para ser usados con funciones de GBDK como `set_bkg_data` o `set_sprite_data`.

## Paso a paso para agregar un sprite

Dibuja el Sprite: Crea un PNG de 16x16 píxeles usando solo 4 colores (Blanco, Gris Claro, Gris Oscuro, Negro).
Convierte la Imagen: Usa la herramienta incluida en el proyecto: python3 tools/img_to_c.py tu_imagen.png nombre_variable
Agrega los Datos: Copia el resultado en 
res/assets.c
 y decláralo en 
res/assets.h
.
Carga en VRAM: En 
game_init
 (en 
src/states/game.c
), usa set_sprite_data para cargar tus nuevos gráficos.
Crea la Entidad: Usa el índice donde cargaste el sprite al crear tu entidad en 
src/data/map_config.c
.