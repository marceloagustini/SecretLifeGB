import sys
from PIL import Image

def rgb_to_gb(r, g, b):
    # Standard grayscale mapping
    gray = 0.299 * r + 0.587 * g + 0.114 * b
    if gray > 192:
        return 0  # White
    elif gray > 128:
        return 1  # Light Gray
    elif gray > 64:
        return 2  # Dark Gray
    else:
        return 3  # Black

def convert_image(image_path, output_name):
    try:
        img = Image.open(image_path).convert('RGB')
    except Exception as e:
        print(f"Error opening image: {e}")
        return

    width, height = img.size
    if width % 8 != 0 or height % 8 != 0:
        print("Warning: Image dimensions should be multiples of 8.")

    tiles = []
    
    # Process 8x8 tiles
    # GameBoy tiles are stored row by row
    # Each row is 2 bytes (low bit plane, high bit plane)
    
    print(f"const unsigned char {output_name}[] = {{")
    
    for tile_y in range(0, height, 8):
        for tile_x in range(0, width, 8):
            # Process one tile
            tile_bytes = []
            for y in range(8):
                low_byte = 0
                high_byte = 0
                for x in range(8):
                    # Get pixel color (0-3)
                    px_x = tile_x + x
                    px_y = tile_y + y
                    if px_x < width and px_y < height:
                        r, g, b = img.getpixel((px_x, px_y))
                        color = rgb_to_gb(r, g, b)
                    else:
                        color = 0

                    if color & 1:
                        low_byte |= (1 << (7 - x))
                    if color & 2:
                        high_byte |= (1 << (7 - x))
                
                tile_bytes.append(f"0x{low_byte:02X}")
                tile_bytes.append(f"0x{high_byte:02X}")
            
            print(f"    // Tile at ({tile_x//8}, {tile_y//8})")
            print(f"    {', '.join(tile_bytes)},")

    print("};")

if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Usage: python3 img_to_c.py <input.png> <variable_name>")
    else:
        convert_image(sys.argv[1], sys.argv[2])
