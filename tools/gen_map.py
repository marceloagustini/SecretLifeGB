
import random

def generate_map():
    width = 32
    height = 32
    
    # 0 = Path/Dirt
    # 1 = Wall
    # 2 = Grass
    # 3 = Flower
    # 4 = Tree Top
    # 5 = Tree Bottom
    # 6 = Rock
    # 7-11 = House parts
    
    # Initialize with Grass
    map_data = [2] * (width * height)
    
    def set_tile(x, y, t):
        if 0 <= x < width and 0 <= y < height:
            map_data[y * width + x] = t

    # Borders (Trees)
    for x in range(width):
        set_tile(x, 0, 4)
        set_tile(x, 1, 5)
        set_tile(x, height-2, 4)
        set_tile(x, height-1, 5)
    for y in range(height):
        set_tile(0, y, 4) # Overlap logic simplistic here, just blocking
        set_tile(width-1, y, 4)

    # Some paths
    for i in range(5, 25):
        set_tile(i, 10, 0)
        set_tile(10, i, 0)

    # A House
    hx, hy = 15, 8
    # Roof
    set_tile(hx, hy, 7)
    set_tile(hx+1, hy, 8)
    set_tile(hx+2, hy, 7)
    set_tile(hx+3, hy, 8)
    # Walls
    set_tile(hx, hy+1, 9)
    set_tile(hx+1, hy+1, 11) # Door
    set_tile(hx+2, hy+1, 9)
    set_tile(hx+3, hy+1, 10)

    # Another House
    hx, hy = 5, 20
    set_tile(hx, hy, 7)
    set_tile(hx+1, hy, 8)
    set_tile(hx, hy+1, 9)
    set_tile(hx+1, hy+1, 10)

    # Random trees and rocks
    for _ in range(10):
        rx, ry = random.randint(2, width-3), random.randint(2, height-3)
        if map_data[ry * width + rx] == 2: # If grass
            set_tile(rx, ry, 6) # Rock
            
    for _ in range(8):
        tx, ty = random.randint(2, width-3), random.randint(2, height-4)
        if map_data[ty * width + tx] == 2 and map_data[(ty+1) * width + tx] == 2:
            set_tile(tx, ty, 4)
            set_tile(tx, ty+1, 5)

    print(f"#define MAP_WIDTH {width}")
    print(f"#define MAP_HEIGHT {height}")
    print(f"const unsigned char map_data[{width*height}] = {{")
    
    for i in range(0, len(map_data), width):
        row = map_data[i:i+width]
        print("    " + ", ".join(map(str, row)) + ",")
        
    print("};")

if __name__ == "__main__":
    generate_map()
