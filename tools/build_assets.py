import subprocess

scripts = [
    "tools/gen_tiles.py",
    "tools/gen_map.py",
    "tools/gen_player.py",
    "tools/gen_npc.py",
    "tools/gen_female_npc.py",
    "tools/gen_guard.py",
    "tools/gen_projectile.py",
    "tools/gen_text_tiles.py",
    "tools/gen_maze.py"
]

with open("res/assets.c", "w") as out:
    out.write("/* Generated Assets */\n")
    out.write('#include "assets.h"\n')
    out.write('#include <gb/gb.h>\n\n')
    
    for s in scripts:
        print(f"Running {s}...")
        res = subprocess.run(["python3", s], capture_output=True, text=True)
        # Filter out any lines that are not part of the C code (like 'Error: ...')
        lines = res.stdout.splitlines()
        for line in lines:
            if not line.startswith("const unsigned char") and not line.startswith("    ") and not line.startswith("};") and not line.startswith("//"):
                if line.startswith("#define"): continue # These go in assets.h or are handles differently
            out.write(line + "\n")
        out.write("\n")

print("Assets compiled to res/assets.c")
