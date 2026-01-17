# 🛠️ GameBoy Development Tools

Este directorio contiene una colección de herramientas en Python diseñadas para automatizar la generación de recursos (tiles, mapas, sprites) para GBDK-2020. Estas herramientas se dividen en **Generadores** (con diseños internos) y **Conversores** (que procesan archivos externos).

---

## 🚀 Automatización Principal

### `build_assets.py`
Este es el "pipeline" principal. Ejecuta secuencialmente los generadores necesarios y consolida toda la salida en `res/assets.c`.
- **Uso**: `python3 tools/build_assets.py`
- **Genera**: `res/assets.c` (listo para compilar).

---

## 🎨 Generadores de Recursos (Hardcoded)

Estas herramientas contienen el diseño de los píxeles dentro del código Python.

| Script | Función |
| :--- | :--- |
| `gen_tiles.py` | Genera los tiles básicos del fondo (hierba, árboles 2x2, casas, flores). |
| `gen_player.py` | Genera los sprites de movimiento del jugador (Link-style). |
| `gen_npc.py` | Genera el sprite del NPC "Perro". |
| `gen_female_npc.py` | Genera el sprite de la aldeana. |
| `gen_guard.py` | Genera el sprite del guardia/enemigo. |
| `gen_projectile.py` | Genera los gráficos de los proyectiles. |
| `gen_text_tiles.py` | Genera la fuente (A-Z, 0-9) y los bordes de las ventanas de diálogo. |
| `gen_map.py` | Genera la matriz del mapa del mundo (0: WORLD_MAP) con diseño de pueblo. |

---

## 🔄 Conversores (PNG & Tiled)

Herramientas para importar recursos desde archivos externos.

### `img_to_c.py`
Convierte cualquier PNG a un array de C compatible con GameBoy.
- **Uso**: `python3 tools/img_to_c.py <imagen.png> <nombre_variable> > output.c`
- **Importante**: La imagen debe usar solo los 4 colores de la paleta GameBoy habituales en estos conversores:
    - `0xFFFFFF` (Blanco)
    - `0xC0C0C0` (Gris Claro)
    - `0x606060` (Gris Oscuro)
    - `0x000000` (Negro)
- **Requisito**: Requiere `Pillow` (`pip install Pillow`).

### `tiled_to_c.py`
Convierte archivos `.csv` exportados desde **Tiled Map Editor** a arrays de C.
- **Uso**: `python3 tools/tiled_to_c.py mapa.csv nombre_array`

### `png_to_tiles.py`
Similar a `img_to_c.py` pero optimizado para generar sets de tiles individuales.

---

## 🔍 Utilidades de Visualización

### `gen_tileset_img.py`
Genera una imagen `res/tileset.bmp` con todos los tiles definidos en el código. Útil para importar el tileset en **Tiled**.

### `export_to_png.py`
Exporta los diseños actuales de los generadores a un archivo PNG (`res/tileset.png`) para previsualización o edición.

---

## 💡 Flujo de Trabajo Recomendado

1. **Modificar Gráficos**: Si cambias el diseño en un `gen_*.py`, ejecuta `python3 tools/build_assets.py` para actualizar el juego.
2. **Nuevos Mapas**: Diseña en Tiled usando el tileset generado por `gen_tileset_img.py`, exporta a CSV y usa `tiled_to_c.py`.
3. **Sprites Externos**: Usa `img_to_c.py` para convertir PNGs de 16x16 directamente a código.

> [!TIP]
> Si estás en macOS/Linux, puedes dar permisos de ejecución a los scripts: `chmod +x tools/*.py`.
