import tkinter as tk
from tkinter import filedialog, messagebox

# Diccionario de operaciones tipo R con sus códigos binarios (funct)
alu_codes_r = {
    'add': '100000',
    'sub': '100010',
    'and': '100100',
    'or': '100101',
    'slt' : '101010',
    'mul' : '011000',
    'div' : '011010',
}

# Diccionario de operaciones tipo I con sus códigos binarios (opcode)
alu_codes_i = {
    'addi': '001000',
    'slti': '001010',
    'andi': '001100',
    'ori': '001101',
    'sw': '101011',
    'lw': '100011',
    'beq': '000100',
    'nop': '000000'  # nop es especial, todo será 0
}
# Código de operación para instrucciones tipo R
OPCODE_R = "000000"

# Variable global para almacenar el contenido convertido
contenido_binario = []

def seleccionar_archivo():
    """Abre un cuadro de diálogo para seleccionar un archivo y lo carga."""
    archivo = filedialog.askopenfilename(title="Seleccionar archivo", filetypes=(("Text files", "*.txt"), ("All files", "*.*")))
    if archivo:
        with open(archivo, 'r') as f:
            contenido = f.read()
        consola.insert(tk.END, "Contenido del archivo seleccionado:\n")
        consola.insert(tk.END, contenido + "\n\n")
        decodificar_a_binario(contenido)

def dividir_en_bloques(binario, bloque=8):
    """Divide una cadena binaria en bloques de longitud específica."""
    return '\n'.join(binario[i:i+bloque] for i in range(0, len(binario), bloque))

def decodificar_a_binario(contenido):
    """Convierte el contenido a un formato binario específico y lo muestra en la consola."""
    global contenido_binario
    contenido_binario = []  # Reinicia la lista de contenido binario

    try:
        for linea in contenido.splitlines():
            if linea.strip():
                partes = linea.split()
                instruccion = partes[0]

                if instruccion in alu_codes_r:  # Instrucción tipo R
                    rd = format(int(partes[1][1:]), '05b')  # Registro de destino
                    rs = format(int(partes[2][1:]), '05b')  # Primer operando fuente
                    rt = format(int(partes[3][1:]), '05b')  # Segundo operando fuente
                    shamt = "00000"  # Shift amount (siempre 0 para estas operaciones)
                    funct = alu_codes_r[instruccion]  # Código de función

                    # Formatear la instrucción en el formato requerido
                    linea_binaria = f"{OPCODE_R}{rs}{rt}{rd}{shamt}{funct}"
                    contenido_binario.append(dividir_en_bloques(linea_binaria))

                elif instruccion in alu_codes_i:  # Instrucción tipo I
                    opcode = alu_codes_i[instruccion]
                    if instruccion == "nop":  # nop es una instrucción especial
                        linea_binaria = "0" * 32
                    else:
                        rs = format(int(partes[2][1:]), '05b')  # Primer registro fuente
                        rt = format(int(partes[1][1:]), '05b')  # Registro de destino o fuente
                        immediate = format(int(partes[3][1:]), '016b')  # Valor inmediato (16 bits)

                        # Formatear la instrucción en el formato requerido
                        linea_binaria = f"{opcode}{rs}{rt}{immediate}"

                    contenido_binario.append(dividir_en_bloques(linea_binaria))

        consola.insert(tk.END, "Contenido convertido a binario (8 bits por línea):\n")
        consola.insert(tk.END, "\n\n".join(contenido_binario) + "\n\n")
    except Exception as e:
        messagebox.showerror("Error", f"Ocurrió un error: {e}")

def guardar_archivo():
    """Permite al usuario guardar el archivo convertido manualmente."""
    global contenido_binario
    if not contenido_binario:
        messagebox.showwarning("Advertencia", "No hay contenido convertido para guardar.")
        return

    archivo_guardar = filedialog.asksaveasfilename(title="Guardar archivo como", defaultextension=".txt", filetypes=(("Text files", "*.txt"), ("All files", "*.*")))
    if archivo_guardar:
        try:
            with open(archivo_guardar, 'w') as f:
                f.write('\n\n'.join(contenido_binario))
            messagebox.showinfo("Éxito", f"El archivo se ha guardado en '{archivo_guardar}'")
        except Exception as e:
            messagebox.showerror("Error", f"No se pudo guardar el archivo: {e}")

def salir():
    """Cierra la aplicación."""
    root.quit()

# Configuración de la ventana principal
root = tk.Tk()
root.title("Decodificador de Instrucciones")
root.geometry("700x500")

# Consola para mostrar resultados
consola = tk.Text(root, height=20, width=80, bg="white", fg="black", font=("Courier", 10))
consola.pack(pady=10)

# Crear botones
btn_seleccionar = tk.Button(root, text="Seleccionar Archivo", command=seleccionar_archivo)
btn_seleccionar.pack(pady=5)

btn_guardar = tk.Button(root, text="Guardar Archivo", command=guardar_archivo)
btn_guardar.pack(pady=5)

btn_salir = tk.Button(root, text="Salir", command=salir)
btn_salir.pack(pady=5)

# Iniciar el bucle principal
root.mainloop()
