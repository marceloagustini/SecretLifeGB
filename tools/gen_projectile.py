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

    # Flower Sprite (Small plant)
    flower_pixels = [
        "00000000",
        "00111100",
        "01311310",
        "01122110",
        "01122110",
        "01311310",
        "00111100",
        "00000000"
    ]
    flower_tile = pixel_art_to_gb_tile(flower_pixels)
    print("\nconst unsigned char flower_sprite[] = {")
    print("    ", end="")
    for i, byte in enumerate(flower_tile):
        print(f"0x{byte:02X}", end="")
        if i < len(flower_tile) - 1:
            print(", ", end="")
    print("\n};")

    # Portal Sprite (16x16 - 4 tiles: TL, TR, BL, BR)
    portal_grid = [
        "0001110000111000",
        "0013331001333100",
        "0132223113222310",
        "1320002332000231",
        "1320002332000231",
        "0132223113222310",
        "0013331001333100",
        "0001110000111000",
        "0001110000111000",
        "0013331001333100",
        "0132223113222310",
        "1320002332000231",
        "1320002332000231",
        "0132223113222310",
        "0013331001333100",
        "0001110000111000",
    ]
    
    # Simple split into 4 8x8 tiles
    print("\nconst unsigned char portal_sprite[] = {")
    for ty_s in [0, 8]:
        for tx_s in [0, 8]:
            p_strip = [row[tx_s:tx_s+8] for row in portal_grid[ty_s:ty_s+8]]
            p_tile = pixel_art_to_gb_tile(p_strip)
            for byte in p_tile:
                print(f"0x{byte:02X}, ", end="")
            print()
    print("};")
    # Explosion Sprite (16x16 - 4 tiles)
    explosion_grid = [
        "0001221000122100",
        "0013333101333310",
        "0133003313300331",
        "1330000333000033",
        "1330000333000033",
        "0133003313300331",
        "0013333101333310",
        "0001221000122100",
        "0001221000122100",
        "0013333101333310",
        "0133003313300331",
        "1330000333000033",
        "1330000333000033",
        "0133003313300331",
        "0013333101333310",
        "0001221000122100",
    ]
    print("\nconst unsigned char explosion_sprite[] = {")
    for ty_s in [0, 8]:
        for tx_s in [0, 8]:
            strip = [row[tx_s:tx_s+8] for row in explosion_grid[ty_s:ty_s+8]]
            tile_bytes = pixel_art_to_gb_tile(strip)
            for byte in tile_bytes:
                print(f"0x{byte:02X}, ", end="")
            print()
    print("};")
