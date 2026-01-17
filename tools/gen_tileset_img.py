
import os
import sys
import struct

# Import the design from the other script
sys.path.append(os.path.dirname(__file__))
from export_to_png import tiles_design, anim_design

# GameBoy Palette (B, G, R for BMP)
COLORS_BGR = [
    (255, 255, 255), # 0: White
    (192, 192, 192), # 1: Light Gray
    (96, 96, 96),   # 2: Dark Gray
    (0, 0, 0)       # 3: Black
]

def write_bmp(width, height, pixels_2d, output_path):
    # BMP 24-bit header
    file_size = 54 + (3 * width * height)
    header = struct.pack('<2sIHHI', b'BM', file_size, 0, 0, 54)
    dib_header = struct.pack('<IiiHHIIIIII', 40, width, height, 1, 24, 0, 3 * width * height, 2835, 2835, 0, 0)
    
    with open(output_path, 'wb') as f:
        f.write(header)
        f.write(dib_header)
        # BMP pixels are stored bottom-to-top
        for y in range(height - 1, -1, -1):
            for x in range(width):
                b, g, r = pixels_2d[y][x]
                f.write(struct.pack('BBB', b, g, r))
            # Padding to 4 bytes
            padding = (4 - (width * 3) % 4) % 4
            f.write(b'\x00' * padding)

def generate_tileset_image():
    tile_size = 8
    grid_width = 16
    
    # Merge designs for export
    all_tiles = {**tiles_design, **anim_design}
    
    max_idx = max(all_tiles.keys())
    grid_height = (max_idx // grid_width) + 1
    
    img_w = grid_width * tile_size
    img_h = grid_height * tile_size
    
    # Initialize with Magenta (255, 0, 255)
    pixels_2d = [[(255, 0, 255) for _ in range(img_w)] for _ in range(img_h)]
    
    for idx, rows in all_tiles.items():
        base_x = (idx % grid_width) * tile_size
        base_y = (idx // grid_width) * tile_size
        
        for y, row in enumerate(rows):
            for x, char in enumerate(row):
                color_idx = int(char)
                pixels_2d[base_y + y][base_x + x] = COLORS_BGR[color_idx]
                
    output_path_bmp = os.path.join(os.path.dirname(__file__), '../res/tileset.bmp')
    write_bmp(img_w, img_h, pixels_2d, output_path_bmp)
    print(f"Tileset image saved to {output_path_bmp}")
    
    # Also save as PNG if possible
    try:
        from PIL import Image
        # Flatten pixels_2d and convert to bytes
        img_data = []
        for row in pixels_2d:
            for b, g, r in row:
                img_data.extend([r, g, b])
        
        img = Image.frombytes('RGB', (img_w, img_h), bytes(img_data))
        output_path_png = os.path.join(os.path.dirname(__file__), '../res/tileset.png')
        img.save(output_path_png)
        print(f"Tileset PNG saved to {output_path_png}")
    except ImportError:
        print("Pillow not installed, skipping PNG generation")

if __name__ == "__main__":
    generate_tileset_image()
