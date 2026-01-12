
def to_gb_tile(pixels):
    # pixels is a list of 8 strings, each 8 chars long (0-3)
    hex_bytes = []
    for row in pixels:
        lo = 0
        hi = 0
        for i, char in enumerate(row):
            val = int(char)
            bit = 7 - i
            if val & 1:
                lo |= (1 << bit)
            if val & 2:
                hi |= (1 << bit)
        hex_bytes.append(f"0x{lo:02X}")
        hex_bytes.append(f"0x{hi:02X}")
    return hex_bytes

def convert_tiles(name, tiles_map):
    print(f"const unsigned char {name}[] = {{")
    
    sorted_indices = sorted(tiles_map.keys())
    
    for idx in sorted_indices:
        pixels = tiles_map[idx]
        print(f"    // Tile {idx}")
        rows = [r.strip().replace(' ', '') for r in pixels if r.strip()]
        if len(rows) != 8:
            print(f"Error: Tile {idx} has {len(rows)} rows, expected 8")
            continue
            
        bytes_str = ", ".join(to_gb_tile(rows))
        print(f"    {bytes_str},")

    print("};")

# tile design 0-3
# 0: Lightest (White/Transp equivalent for BG)
# 1: Light Gray
# 2: Dark Gray
# 3: Darkest (Black)

tiles_design = {
    0: [ # Empty/Path (Dirt with pebbles)
        "11111111",
        "11011111",
        "11111101",
        "10111111",
        "11110111",
        "11111111",
        "11011110",
        "11111111" 
    ],
    1: [ # Wall (Bricks)
        "33333333",
        "31113113",
        "31113113",
        "33333333",
        "11311113",
        "11311113",
        "33333333",
        "22222222" # Shadow at bottom
    ],
    2: [ # Grass (Blades)
        "11111111",
        "12111112",
        "21211121",
        "11111111",
        "11112111",
        "11121211",
        "12111111",
        "11111111" 
    ],
    3: [ # Flower
        "11111111",
        "11000111",
        "10222011",
        "10212011",
        "10222011",
        "11010111",
        "11111111",
        "11111111" 
    ],
    4: [ # Tree Top (Bushy, Blended)
        "11222211",
        "12233221",
        "22333322",
        "23333332",
        "23333332",
        "22333322",
        "12233221",
        "11222211" 
    ],
    5: [ # Tree Bottom (Trunk, Blended)
        "11222211",
        "11133111",
        "11132111",
        "11132111",
        "11133111",
        "11333311",
        "13333331",
        "11111111" 
    ],
    6: [ # Rock (Blended)
        "11111111",
        "11222211",
        "12211221",
        "22133122",
        "22133122",
        "22333322",
        "12222221",
        "11111111" 
    ],
    7: [ # House Roof Left (Blended)
        "11111113",
        "11111132",
        "11111322",
        "11113222",
        "11132222",
        "11322222",
        "13222222",
        "33333333" 
    ],
    8: [ # House Roof Right (Blended)
        "31111111",
        "23111111",
        "22311111",
        "22231111",
        "22223111",
        "22222311",
        "22222231",
        "33333333" 
    ],
    9: [ # House Wall Left (Window, Blended)
        "32222222",
        "21111112",
        "21333112",
        "21313112", # Window (center lightened)
        "21333112",
        "21111112",
        "21111112",
        "32222222" 
    ],
    10: [ # House Wall Right (Blended)
        "22222223",
        "21111112",
        "21111112",
        "21111112",
        "21111112",
        "21111112",
        "21111112",
        "22222223" 
    ],
    11: [ # House Door (Blended)
        "22222222",
        "23333332",
        "23111132", # Door interior lighter
        "23122132",
        "23122132",
        "23122132",
        "23111132",
        "22222222" 
    ]
}

if __name__ == "__main__":
    convert_tiles("tiles_data", tiles_design)
