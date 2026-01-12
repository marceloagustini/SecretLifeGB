#!/usr/bin/env python3

def pixel_grid_to_hex(grid):
    """Convert a 16-line pixel grid (each 16 chars wide) to GB 2bpp hex.
    0 = Transparent
    1 = Light (Skin/Light Brown)
    2 = Dark (Brown/Dark)
    3 = Black
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

# DOG NPC - Standing (Down-facing)
dog_down = [
    "0000000000000000",
    "0001111111100000",
    "0011222222110000",
    "0112222222211000",
    "0122333333221000",
    "0122333333221000",
    "0122222222221000",
    "0012222222100000",
    "0001222221000000",
    "0001222221000000",
    "0011222222110000",
    "0112222222211000",
    "0122000000221000",
    "0120000000021000",
    "0110000000011000",
    "0000000000000000",
]

print("const unsigned char npc_dog_sprite[] = {")
print("    // DOG NPC")
data = pixel_grid_to_hex(dog_down)
for i in range(0, len(data), 16):
    chunk = data[i:i+16]
    print("    " + ", ".join([f"0x{b:02X}" for b in chunk]) + ",")
print("};")
