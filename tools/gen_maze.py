
import random

def generate_maze(width, height):
    # Initialize with walls (1)
    maze = [[1 for _ in range(width)] for _ in range(height)]
    
    # We use a 2x2 path system to make it playable for 16x16 sprites
    # Grid size for 2-wide paths and 1-wide walls: (2+1)*N + 1 = 31 -> N=10
    
    def walk(x, y):
        # Mark 2x2 path
        for i in range(2):
            for j in range(2):
                if y+i < height-1 and x+j < width-1:
                    maze[y+i][x+j] = 2
        
        directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]
        random.shuffle(directions)
        
        for dx, dy in directions:
            nx, ny = x + dx * 3, y + dy * 3
            if 0 < nx < width-1 and 0 < ny < height-1 and maze[ny][nx] == 1:
                # Carve 2x2 bridge
                for i in range(2):
                    for j in range(2):
                        maze[y + dy + i][x + dx + j] = 2
                walk(nx, ny)

    walk(1, 1)
    
    # Add entrance (Top)
    maze[0][1] = 2
    maze[0][2] = 2
    maze[1][1] = 2
    maze[1][2] = 2
    
    # Add exit (Bottom) - find a path near bottom
    maze[height-2][width-2] = 2
    maze[height-2][width-3] = 2
    maze[height-1][width-2] = 2
    maze[height-1][width-3] = 2
    
    return maze

def print_maze_c(name, maze):
    width = len(maze[0])
    height = len(maze)
    print(f"const unsigned char {name}[] = {{")
    for row in maze:
        print("    " + ", ".join(map(str, row)) + ",")
    print("};\n")
    print(f"#define {name.upper()}_WIDTH {width}")
    print(f"#define {name.upper()}_HEIGHT {height}")

if __name__ == "__main__":
    # Create a 31x31 maze to fit in 32x32 area with border
    maze = generate_maze(31, 31)
    
    # Pad to 32x32
    for row in maze:
        row.append(1)
    maze.append([1] * 32)
    
    print_maze_c("maze_map", maze)

    # Sanctuary Map (20x18)
    sanctuary = [[25] * 20 for _ in range(18)]
    for y in range(1, 17):
        for x in range(1, 19):
            sanctuary[y][x] = 35
    
    sanctuary[17][9] = 35
    sanctuary[17][10] = 35
    
    # Table
    sanctuary[8][9] = 31
    sanctuary[8][10] = 32
    sanctuary[9][9] = 33
    sanctuary[9][10] = 34
    
    print_maze_c("sanctuary_map", sanctuary)
