#!/usr/bin/env python3
"""
Generate simple projectile sprite (8x8 fireball/rock)
"""

# Simple 8x8 projectile (fireball)
# 0 = white/transparent, 1 = light gray, 2 = dark gray, 3 = black
projectile_sprite = [
    "00011000",
    "00122100",
    "01233210",
    "12333321",
    "12333321",
    "01233210",
    "00122100",
    "00011000",
]

def pixel_art_to_gb_tile(pixels):
    """Convert 8x8 pixel art to GameBoy tile data"""
    tile_data = []
    
    for row in pixels:
        byte1 = 0
        byte2 = 0
        for i, pixel in enumerate(row):
            bit_pos = 7 - i
            if pixel == '1':  # Light gray
                byte1 |= (1 << bit_pos)
            elif pixel == '2':  # Dark gray
                byte2 |= (1 << bit_pos)
            elif pixel == '3':  # Black
                byte1 |= (1 << bit_pos)
                byte2 |= (1 << bit_pos)
        
        tile_data.append(byte1)
        tile_data.append(byte2)
    
    return tile_data

if __name__ == "__main__":
    tile = pixel_art_to_gb_tile(projectile_sprite)
    print("const unsigned char projectile_sprite[] = {")
    print("    ", end="")
    for i, byte in enumerate(tile):
        print(f"0x{byte:02X}", end="")
        if i < len(tile) - 1:
            print(", ", end="")
    print("\n};")
