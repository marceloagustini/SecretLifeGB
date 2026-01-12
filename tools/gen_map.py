
import random

def generate_map():
    width = 32
    height = 32
    
    # 0 = Cobblestone Path
    # 1 = Wall/Boundary
    # 2 = Grass
    # 3 = Flower
    # 4,5,6,12 = 2x2 Tree
    # 23 = Rock
    # 7-24 (selected) = 4x4 House
    
    # Initialize with Grass
    map_data = [2] * (width * height)
    
    def set_tile(x, y, t):
        if 0 <= x < width and 0 <= y < height:
            map_data[y * width + x] = t

    def set_house(hx, hy):
        # 4x4 House layout
        house_tiles = [
            [7, 8, 9, 10],
            [11, 13, 14, 15],
            [16, 17, 18, 19],
            [20, 21, 22, 24]
        ]
        for dy in range(4):
            for dx in range(4):
                set_tile(hx + dx, hy + dy, house_tiles[dy][dx])

    def set_tree(tx, ty):
        # 2x2 Tree layout
        set_tile(tx, ty, 4)
        set_tile(tx + 1, ty, 5)
        set_tile(tx, ty + 1, 6)
        set_tile(tx + 1, ty + 1, 12)

    # 1. Outer Boundary (Fences/Walls placeholder)
    for x in range(width):
        set_tile(x, 0, 1)
        set_tile(x, height-1, 1)
    for y in range(height):
        set_tile(0, y, 1)
        set_tile(width-1, y, 1)

    # 2. Main Cobblestone Roads (Town center)
    # Vertical Road
    for y in range(2, height-2):
        set_tile(15, y, 0)
        set_tile(16, y, 0)
    # Horizontal Road
    for x in range(2, width-2):
        set_tile(x, 15, 0)
        set_tile(x, 16, 0)

    # 3. Houses in corners/lots
    # Top Left
    set_house(4, 4)
    # Top Right
    set_house(22, 4)
    # Bottom Left
    set_house(4, 22)
    # Bottom Right
    set_house(22, 22)

    # Add small paths to houses
    # Path to House 1
    for x in range(8, 15): set_tile(x, 7, 0)
    # Path to House 2
    for x in range(17, 22): set_tile(x, 7, 0)
    # Path to House 3
    for x in range(8, 15): set_tile(x, 25, 0)
    # Path to House 4
    for x in range(17, 22): set_tile(x, 25, 0)

    # 4. Fill with Trees, Flowers and Rocks
    for _ in range(15):
        tx, ty = random.randint(2, width-3), random.randint(2, height-3)
        # Only place if grass
        if map_data[ty * width + tx] == 2 and map_data[ty * width + tx + 1] == 2 and \
           map_data[(ty+1) * width + tx] == 2 and map_data[(ty+1) * width + tx + 1] == 2:
            set_tree(tx, ty)

    for _ in range(20):
        rx, ry = random.randint(2, width-3), random.randint(2, height-3)
        if map_data[ry * width + rx] == 2:
            set_tile(rx, ry, 3 if random.random() > 0.5 else 23)

    print(f"#define MAP_WIDTH {width}")
    print(f"#define MAP_HEIGHT {height}")
    print(f"const unsigned char map_data[{width*height}] = {{")
    for i in range(0, len(map_data), width):
        row = map_data[i:i+width]
        print("    " + ", ".join(map(str, row)) + ",")
    print("};")

if __name__ == "__main__":
    generate_map()
