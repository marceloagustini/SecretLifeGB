#!/usr/bin/env python3

def pixel_grid_to_hex(grid):
    """Convert a 16-line pixel grid (each 16 chars wide) to GB 2bpp hex.
    0 = Transparent
    1 = Light (Skin)
    2 = Dark (Clothes)
    3 = Black (Outline)
    """
    hex_data = []
    
    # Split into four 8x8 tiles: TL, TR, BL, BR
    tiles = [
        [grid[y][:8] for y in range(8)],      # Top-Left
        [grid[y][8:16] for y in range(8)],    # Top-Right
        [grid[y][:8] for y in range(8, 16)],  # Bottom-Left
        [grid[y][8:16] for y in range(8, 16)] # Bottom-Right
    ]
    
    for tile in tiles:
        for row in tile:
            byte0 = 0
            byte1 = 0
            for i, pixel in enumerate(row):
                val = int(pixel)
                bit_pos = 7 - i
                if val & 1:
                    byte0 |= (1 << bit_pos)
                if val & 2:
                    byte1 |= (1 << bit_pos)
            hex_data.append(byte0)
            hex_data.append(byte1)
    
    return hex_data

# CARTOON GUARD - Standing
guard_sprite = [
    "0000333333300000", # Hat top
    "0003222222230000", # Hat body (Blue)
    "0033333333330000", # Hat brim
    "0031111111111300", # Face top
    "0031131111311300", # Eyes
    "0031111122111300", # Nose/Mouth area
    "0003111111113000", # Face bottom
    "0000333333330000", # Chin/Neck
    "0003222222223000", # Shoulders
    "0032222222222300", # Uniform
    "0032233222332300", # Uniform with Badge/Detail
    "0033333333333300", # Belt
    "0003223003223000", # Pants
    "0003223003223000", # Pants
    "0033333003333300", # Shoes
    "0000000000000000", # Padding
]

if __name__ == "__main__":
    print("const unsigned char guard_sprite_data[] = {")
    print("    // GUARD NPC")
    data = pixel_grid_to_hex(guard_sprite)
    for i in range(0, len(data), 16):
        chunk = data[i:i+16]
        print("    " + ", ".join([f"0x{b:02X}" for b in chunk]) + ",")
    print("};")
