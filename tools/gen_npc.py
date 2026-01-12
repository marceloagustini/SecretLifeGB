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

# CHILD NPC - Standing
child_npc = [
    "0000333333000000",
    "0033111111330000",
    "0311111111113000",
    "3111111111111300",
    "3113111113111300", # Eyes
    "3111112211111300", # Mouth
    "0311111111113000",
    "0033333333330000",
    "0003222222300000", # Shirt
    "0032222222230000",
    "0032222222230000",
    "0032222222230000",
    "0003300003300000", # Legs
    "0031130031130000", # Feet
    "0033330033330000",
    "0000000000000000",
]

if __name__ == "__main__":
    print("const unsigned char npc_child_sprite[] = {")
    print("    // CHILD NPC")
    data = pixel_grid_to_hex(child_npc)
    for i in range(0, len(data), 16):
        chunk = data[i:i+16]
        print("    " + ", ".join([f"0x{b:02X}" for b in chunk]) + ",")
    print("};")
