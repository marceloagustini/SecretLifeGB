#!/usr/bin/env python3
"""
Generate Female NPC Sprite Data for GameBoy
Creates a 16x16 sprite with feminine features (long hair, dress)
"""

def pixel_art_to_gb_tiles(frames):
    """Convert pixel art frames to GameBoy tile data"""
    output = []
    
    for frame in frames:
        # Process 2x2 tiles (16x16 sprite = 4 tiles of 8x8)
        tiles = [[], [], [], []]  # Top-left, Top-right, Bottom-left, Bottom-right
        
        for row_idx, row in enumerate(frame):
            tile_row = row_idx // 8  # 0 for top tiles, 1 for bottom tiles
            
            for tile_col in range(2):  # 0 for left tiles, 1 for right tiles
                tile_idx = tile_row * 2 + tile_col
                start_col = tile_col * 8
                end_col = start_col + 8
                pixel_row = row[start_col:end_col]
                
                # Convert to GameBoy 2bpp format
                byte1 = 0
                byte2 = 0
                for i, pixel in enumerate(pixel_row):
                    bit_pos = 7 - i
                    if pixel == '1':  # Light gray
                        byte1 |= (1 << bit_pos)
                    elif pixel == '2':  # Dark gray
                        byte2 |= (1 << bit_pos)
                    elif pixel == '3':  # Black
                        byte1 |= (1 << bit_pos)
                        byte2 |= (1 << bit_pos)
                
                tiles[tile_idx].append(byte1)
                tiles[tile_idx].append(byte2)
        
        output.extend(tiles)
    
    return output

# Female NPC sprite - standing pose with long hair and dress
# 0 = white/transparent, 1 = light gray, 2 = dark gray, 3 = black
female_npc_frame = [
    "0000333333330000",  # Hair top
    "0003222222223000",  # Hair
    "0032222222222300",  # Hair
    "0322221111222230",  # Hair with face
    "0322111111112230",  # Face
    "0322113113112230",  # Eyes
    "0322111111112230",  # Face
    "0032211331122300",  # Mouth (smile)
    "0003222222223000",  # Hair bottom/neck
    "0000032223200000",  # Shoulders
    "0000322222230000",  # Dress top
    "0003222222223000",  # Dress
    "0032222222222300",  # Dress wide
    "0032222222222300",  # Dress
    "0003222002223000",  # Dress bottom with legs
    "0000220000220000",  # Feet
]

def format_c_array(tile_data, name):
    """Format tile data as C array"""
    output = f"const unsigned char {name}[] = {{\n"
    
    for tile_idx, tile in enumerate(tile_data):
        output += "    "
        for i in range(0, len(tile), 2):
            if i + 1 < len(tile):
                output += f"0x{tile[i]:02X}, 0x{tile[i+1]:02X}, "
        output += f"// Tile {tile_idx}\n"
    
    output += "};\n"
    return output

if __name__ == "__main__":
    tiles = pixel_art_to_gb_tiles([female_npc_frame])
    print(format_c_array(tiles, "npc_woman_sprite"))
