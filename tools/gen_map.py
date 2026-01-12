
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
        set_tile(15, i, 0)
        set_tile(16, i, 0)
        set_tile(i, 15, 0)
        set_tile(i, 16, 0)

    def set_house(x, y):
        # 4x4 house
        # TL: 7, 8, 9, 10
        # Row 2: 11, 13, 14, 15
        # Row 3: 16, 17, 18, 19
        # Row 4: 20, 21, 22, 24
        tiles = [
            [7, 8, 9, 10],
            [11, 13, 14, 15],
            [16, 17, 18, 19],
            [20, 21, 22, 24]
        ]
        for dy, row in enumerate(tiles):
            for dx, t in enumerate(row):
                set_tile(x + dx, y+dy, t)
        # Connect to path
        if x < 15:
            for px in range(x+4, 15): set_tile(px, y+3, 0)
        else:
            for px in range(16, x): set_tile(px, y+3, 0)

    def set_tree(x, y):
        set_tile(x, y, 4)
        set_tile(x+1, y, 5)
        set_tile(x, y+1, 6)
        set_tile(x+1, y+1, 12)

    # Houses in quadrants
    set_house(4, 4)
    set_house(22, 4)
    set_house(4, 22)
    set_house(22, 22)

    # Some nature
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

    print("#define MAP_WIDTH 32")
    print("#define MAP_HEIGHT 32")
    print("const unsigned char map_data[] = {")
    for y in range(height):
        row = map_data[y*width : (y+1)*width]
        print("    " + ", ".join(map(str, row)) + ",")
    print("};\n")

def generate_house_map():
    # House is small, 20x18 (standard screen)
    w, h = 20, 18
    # 25 = floor, 26 = wall
    data = [25] * (w * h)
    
    def set(x, y, t):
        if 0 <= x < w and 0 <= y < h: data[y * w + x] = t

    # Walls
    for i in range(w): 
        set(i, 0, 26)
        set(i, h-1, 26)
    for i in range(h):
        set(0, i, 26)
        set(w-1, i, 26)

    # Exit at bottom center
    set(9, h-1, 35)
    set(10, h-1, 35)

    # Bed 1 (Top Left)
    set(2, 2, 27); set(3, 2, 28)
    set(2, 3, 29); set(3, 3, 30)
    
    # Bed 2 (Top Right)
    set(16, 2, 27); set(17, 2, 28)
    set(16, 3, 29); set(17, 3, 30)

    # Wardrobe (Center wall)
    set(9, 1, 31); set(10, 1, 32)
    set(9, 2, 33); set(10, 2, 34)

    print("#define HOUSE_WIDTH 20")
    print("#define HOUSE_HEIGHT 18")
    print("const unsigned char house_map[] = {")
    for y in range(h):
        row = data[y*w : (y+1)*w]
        print("    " + ", ".join(map(str, row)) + ",")
    print("};")

if __name__ == "__main__":
    generate_map()
    generate_house_map()
