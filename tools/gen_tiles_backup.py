
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
    4: [ # Tree Top (Bushy)
        "00122100",
        "01211210",
        "12122121",
        "21222212",
        "22122122",
        "12212221",
        "01222210",
        "00122100" 
    ],
    5: [ # Tree Bottom (Trunk)
        "00122100", # Continuation of top shadow
        "00033000",
        "00032000",
        "00032000",
        "00033000",
        "00133100", # Roots
        "01333310",
        "11111111"  # Grass base
    ],
    6: [ # Rock
        "11111111",
        "11022011",
        "10212201",
        "02213220",
        "02223220",
        "02233320",
        "10222201",
        "11000011" 
    ],
    7: [ # House Roof Left
        "00000003",
        "00000032",
        "00000322",
        "00003222",
        "00032222",
        "00322222",
        "03222222",
        "33333333" 
    ],
    8: [ # House Roof Right
        "30000000",
        "23000000",
        "22300000",
        "22230000",
        "22223000",
        "22222300",
        "22222230",
        "33333333" 
    ],
    9: [ # House Wall Left (Window)
        "32222222",
        "21111112",
        "21333112",
        "21303112", # Window
        "21333112",
        "21111112",
        "21111112",
        "32222222" 
    ],
    10: [ # House Wall Right
        "22222223",
        "21111112",
        "21111112",
        "21111112",
        "21111112",
        "21111112",
        "21111112",
        "22222223" 
    ],
    11: [ # House Door
        "22222222",
        "23333332",
        "23000032",
        "23022032",
        "23022032",
        "23022032",
        "23000032",
        "22222222" 
    ]
}

if __name__ == "__main__":
    convert_tiles("tiles_data", tiles_design)
