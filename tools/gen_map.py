
def print_map(name, width_name, height_name, width, height, data):
    print(f"#define {width_name} {width}")
    print(f"#define {height_name} {height}")
    print(f"const unsigned char {name}[] = {{")
    for y in range(height):
        row = data[y*width : (y+1)*width]
        print("    " + ", ".join(map(str, row)) + ",")
    print("};\n")

def generate_map():
    width = 32
    height = 32
    # 2 = Grass, 1 = Wall, 0 = Path, 3 = Flower
    map_data = [2] * (width * height)
    
    def set_tile(x, y, t):
        if 0 <= x < width and 0 <= y < height:
            map_data[y * width + x] = t

    # Borders
    for i in range(width):
        set_tile(i, 0, 1)
        set_tile(i, height-1, 1)
        set_tile(0, i, 1)
        set_tile(width-1, i, 1)

    # Main Path (Crossroad)
    for i in range(width):
        set_tile(15, i, 0); set_tile(16, i, 0)
        set_tile(i, 15, 0); set_tile(i, 16, 0)

    # Giant Door
    set_tile(15, 1, 41); set_tile(16, 1, 42)
    set_tile(15, 2, 43); set_tile(16, 2, 44)

    house_t1 = [
        [9, 7, 8, 10],   # Peak
        [11, 14, 15, 13], # Roof
        [16, 17, 19, 18], # Walls
        [20, 21, 22, 24]  # Door
    ]
    house_t3 = [
        [61, 63, 64, 62], # Flat Roof
        [65, 68, 68, 66], # Bricks
        [69, 70, 71, 72], # Door/Wall
        [73, 74, 75, 76]  # Base
    ]

    def set_house(x, y, tiles):
        for dy, row in enumerate(tiles):
            for dx, t in enumerate(row):
                set_tile(x + dx, y+dy, t)
        if x < 15:
            for px in range(x+4, 15): set_tile(px, y+3, 0)
        else:
            for px in range(16, x): set_tile(px, y+3, 0)

    def set_tree(x, y):
        set_tile(x, y, 4); set_tile(x+1, y, 5)
        set_tile(x, y+1, 6); set_tile(x+1, y+1, 12)

    # Houses
    set_house(4, 4, house_t1); set_house(22, 4, house_t1)
    set_house(4, 22, house_t1); set_house(22, 22, house_t1)

    import random
    random.seed(42)
    for _ in range(15):
        tx, ty = random.randint(2, 28), random.randint(2, 28)
        if map_data[ty*width+tx] == 2: set_tree(tx, ty)
    for _ in range(20):
        fx, fy = random.randint(1, 30), random.randint(1, 30)
        if map_data[fy*width+fx] == 2: set_tile(fx, fy, 3)
    for _ in range(10):
        rx, ry = random.randint(1, 30), random.randint(1, 30)
        if map_data[ry*width+rx] == 2: set_tile(rx, ry, 23)

    print_map("map_data", "MAP_WIDTH", "MAP_HEIGHT", width, height, map_data)

def generate_house_map():
    w, h = 20, 18
    data = [25] * (w * h)
    def set(x, y, t):
        if 0 <= x < w and 0 <= y < h: data[y * w + x] = t
    for i in range(w): 
        set(i, 0, 26); set(i, h-1, 26)
    for i in range(h):
        set(0, i, 26); set(w-1, i, 26)
    set(9, h-1, 35); set(10, h-1, 35) # Exit
    set(2, 2, 27); set(3, 2, 28) # Bed 1
    set(2, 3, 29); set(3, 3, 30)
    set(16, 2, 27); set(17, 2, 28) # Bed 2
    set(16, 3, 29); set(17, 3, 30)
    set(9, 1, 31); set(10, 1, 32) # Wardrobe
    set(9, 2, 33); set(10, 2, 34)
    print_map("house_map", "HOUSE_WIDTH", "HOUSE_HEIGHT", w, h, data)

def generate_level2_map():
    w, h = 32, 32
    data = [0] * (w * h)
    def set(x, y, t):
        if 0 <= x < w and 0 <= y < h: data[y * w + x] = t
    for i in range(w):
        set(i, 0, 23); set(i, h-1, 23)
        set(0, i, 23); set(w-1, i, 23)
    set(15, h-1, 0); set(16, h-1, 0)
    import random
    random.seed(99)
    for _ in range(40):
        tx, ty = random.randint(2, 28), random.randint(2, 28)
        set(tx, ty, random.choice([2, 3, 4]))
    print_map("level2_map", "L2_WIDTH", "L2_HEIGHT", w, h, data)

def generate_level3_map():
    w, h = 32, 32
    # 2 = Grass, 1 = Wall, 0 = Path, 3 = Flower
    data = [2] * (w * h)
    def set(x, y, t):
        if 0 <= x < w and 0 <= y < h: data[y * w + x] = t
    
    # Borders
    for i in range(w):
        set(i, 0, 1); set(i, h-1, 1)
        set(0, i, 1); set(w-1, i, 1)

    # Houses (using house_t3 defined above)
    house_t3 = [
        [61, 63, 64, 62], # Flat Roof
        [65, 68, 68, 66], # Bricks
        [69, 70, 71, 72], # Door/Wall
        [73, 74, 75, 76]  # Base
    ]
    
    def set_house_v3(x, y):
        for dy, row in enumerate(house_t3):
            for dx, t in enumerate(row):
                set(x + dx, y + dy, t)

    # Central Vertical Path
    for y in range(h):
        set(15, y, 0); set(16, y, 0)
    
    # Entrance/Exit Paths
    set(15, h-1, 0); set(16, h-1, 0)
    set(15, 0, 0); set(16, 0, 0)

    # Ordered Houses
    set_house_v3(5, 5)
    set_house_v3(22, 5)
    set_house_v3(5, 20)
    set_house_v3(22, 20)

    # Portal at the top of the path
    set(15, 1, 41); set(16, 1, 42)
    set(15, 2, 43); set(16, 2, 44)

    # Trees in clusters (not on path)
    import random
    random.seed(33)
    for _ in range(40):
        tx, ty = random.randint(2, 28), random.randint(2, 28)
        if tx < 13 or tx > 18: # Avoid path
            # Don't overwrite houses (simplified check: tile 2 is grass)
            if data[ty * w + tx] == 2:
                set(tx, ty, 4); set(tx+1, ty, 5)
                set(tx, ty+1, 6); set(tx+1, ty+1, 12)
    
    print_map("level3_map", "L3_WIDTH", "L3_HEIGHT", w, h, data)

if __name__ == "__main__":
    generate_map()
    generate_house_map()
    generate_level2_map()
    generate_level3_map()
