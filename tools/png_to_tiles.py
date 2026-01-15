import os
import sys
from PIL import Image

def rgb_to_gb(rgb):
    # GameBoy 4-shade grayscale conversion
    # White: (255, 255, 255) -> 0
    # Light Gray: (192, 192, 192) -> 1
    # Dark Gray: (96, 96, 96) -> 2
    # Black: (0, 0, 0) -> 3
    r, g, b = rgb[:3]
    avg = (r + g + b) // 3
    if avg > 225: return 0
    if avg > 144: return 1
    if avg > 48: return 2
    return 3

def to_gb_tile(tile_pixels):
    # tile_pixels is an 8x8 list of 0-3 values
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

def convert_png_to_c(png_path, var_name, anim_indices=None):
    img = Image.open(png_path).convert('RGB')
    width, height = img.size
    
    grid_w = width // 8
    grid_h = height // 8
    
    tiles_data = {}
    
    for ty in range(grid_h):
        for tx in range(grid_w):
            idx = ty * grid_w + tx
            tile_pixels = []
            for y in range(8):
                row = []
                for x in range(8):
                    rgb = img.getpixel((tx * 8 + x, ty * 8 + y))
                    row.append(rgb_to_gb(rgb))
                tile_pixels.append(row)
            
            # Check if tile is empty (all Magenta or all White)
            # In our case, magenta was used as padding in gen_tileset_img
            # Let's see if the tile has any non-white/non-magenta pixels
            is_magenta = all(img.getpixel((tx * 8 + x, ty * 8 + y)) == (255, 0, 255) for y in range(8) for x in range(8))
            if not is_magenta:
                tiles_data[idx] = tile_pixels

    print(f"// Generated from {os.path.basename(png_path)}")
    print(f"const unsigned char {var_name}[] = {{")
    
    max_idx = max(tiles_data.keys()) if tiles_data else 0
    for idx in range(max_idx + 1):
        print(f"    // Tile {idx}")
        if idx in tiles_data:
            bytes_str = ", ".join(to_gb_tile(tiles_data[idx]))
        else:
            bytes_str = ", ".join(["0x00"] * 16)
        print(f"    {bytes_str},")
    print("};\n")

if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Usage: python3 png_to_tiles.py <input.png> <variable_name>")
        sys.exit(1)
    
    convert_png_to_c(sys.argv[1], sys.argv[2])
