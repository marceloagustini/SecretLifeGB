
import sys
import os

def convert_csv_to_c(input_file, array_name, width_macro, height_macro):
    if not os.path.exists(input_file):
        print(f"Error: No se encuentra el archivo {input_file}")
        return

    with open(input_file, 'r') as f:
        content = f.read().strip()

    # Tiled CSV handles tiles starting from 1 (0 is empty in Tiled)
    # But GBDK uses 0-indexed tiles. Usually Tiled tileset starts at 1.
    # We subtract 1 from everything if the tileset in Tiled starts at 1.
    
    rows = [line.split(',') for line in content.split('\n') if line.strip()]
    height = len(rows)
    width = len(rows[0]) if height > 0 else 0

    print(f"#define {width_macro} {width}")
    print(f"#define {height_macro} {height}")
    print(f"const unsigned char {array_name}[] = {{")

    for row in rows:
        clean_row = []
        for val in row:
            if not val.strip(): continue
            # Adjust index: Tiled CSV starts at 1 for the first tile
            val_int = int(val.strip()) - 1
            if val_int < 0: val_int = 0 # Default to tile 0 if empty
            clean_row.append(str(val_int))
        
        print("    " + ", ".join(clean_row) + ",")

    print("};\n")

if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Uso: python3 tiled_to_c.py mapa_exportado.csv nombre_del_array")
        print("Ejemplo: python3 tiled_to_c.py house_export.csv new_house_map")
    else:
        csv_file = sys.argv[1]
        name = sys.argv[2]
        macro_prefix = name.upper()
        convert_csv_to_c(csv_file, name, f"{macro_prefix}_WIDTH", f"{macro_prefix}_HEIGHT")
