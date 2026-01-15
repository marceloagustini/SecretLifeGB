import os
import sys
from PIL import Image

# This script now reads from res/tileset.png and outputs C code
# It replaces the old hardcoded tile definitions.

def rgb_to_gb(rgb):
    r, g, b = rgb[:3]
    avg = (r + g + b) // 3
    if avg > 225: return 0
    if avg > 144: return 1
    if avg > 48: return 2
    return 3

def to_gb_tile(tile_pixels):
    hex_bytes = []
    for y in range(8):
        lo = 0
        hi = 0
        for x in range(8):
            val = tile_pixels[y][x]
            bit = 7 - x
            if val & 1:
                lo |= (1 << bit)
            if val & 2:
                hi |= (1 << bit)
        hex_bytes.append(f"0x{lo:02X}")
        hex_bytes.append(f"0x{hi:02X}")
    return hex_bytes

def convert_tiles(png_path, var_name, indices, filter_magenta=True):
    if not os.path.exists(png_path):
        print(f"// Error: {png_path} not found", file=sys.stderr)
        return
    
    img = Image.open(png_path).convert('RGB')
    width, height = img.size
    grid_w = width // 8
    
    tiles_data = {}
    
    for idx in indices:
        tx = idx % grid_width
        ty = idx // grid_width
        
        tile_pixels = []
        is_magenta = True
        for y in range(8):
            row = []
            for x in range(8):
                pixel = img.getpixel((tx * 8 + x, ty * 8 + y))
                if pixel != (255, 0, 255):
                    is_magenta = False
                row.append(rgb_to_gb(pixel))
            tile_pixels.append(row)
        
        if not (filter_magenta and is_magenta):
            tiles_data[idx] = tile_pixels

    print(f"const unsigned char {var_name}[] = {{")
    if tiles_data:
        # For the main tileset, we want to fill gaps up to the max index in 'indices'
        max_idx_in_set = max(indices)
        for idx in range(max_idx_in_set + 1):
            if idx not in indices: continue # Skip if not in requested set
            
            print(f"    // Tile {idx}")
            if idx in tiles_data:
                bytes_str = ", ".join(to_gb_tile(tiles_data[idx]))
            else:
                bytes_str = ", ".join(["0x00"] * 16)
            print(f"    {bytes_str},")
    print("};\n")

if __name__ == "__main__":
    base_dir = os.path.dirname(__file__)
    png_path = os.path.join(base_dir, "../res/tileset.png")
    grid_width = 16
    
    print("/* Generated from res/tileset.png */")
    
    # Original main tiles: 0-35 and 41-44 (added more for padding)
    main_indices = list(range(36)) + list(range(41, 77))
    convert_tiles(png_path, "tiles_data", main_indices, filter_magenta=True)
    
    # Original anim tiles: 36-40
    anim_indices = list(range(36, 41))
    convert_tiles(png_path, "tiles_anim_data", anim_indices, filter_magenta=False)
