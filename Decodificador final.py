import tkinter as tk
from tkinter import filedialog, messagebox

# Mapeo de operaciones a sus códigos binarios
alu_codes = {
    'suma': '010',
    'resta': '110',
    'and': '000',
    'or': '001',
    'nor': '100',
    'moverq': '111',
    'leer': '000',    # Código de operación para leer (opcional)
}

def seleccionar_archivo():
    """Abre un cuadro de diálogo para seleccionar un archivo y lo carga."""
    archivo = filedialog.askopenfilename(title="Seleccionar archivo", filetypes=(("Text files", "*.txt"), ("All files", "*.*")))
    if archivo:
        with open(archivo, 'r') as f:
            contenido = f.read()
        decodificar_a_binario(contenido)

def decodificar_a_binario(contenido):
    """Convierte el contenido a un formato binario específico y lo guarda en un nuevo archivo."""
    try:
        lineas_binarias = []

        for linea in contenido.splitlines():
            if linea.strip():
                partes = linea.split()
                instruccion = partes[0]
                
                # Determinar el valor de 'we'
                if instruccion == 'leer':
                    we = '00'
                else:
                    we = '01'  # Para escribir

                operando1 = format(int(partes[1][1:]), '05b')  # Convertir a binario (5 bits)
                operando2 = format(int(partes[2][1:]), '05b')  # Convertir a binario (5 bits)
                lugar_guardar = format(int(partes[3][1:]), '05b')  # Convertir a binario (5 bits)

                if instruccion in alu_codes:
                    alu = alu_codes[instruccion]
                    # Formatear la línea
                    linea_binaria = f"{we} {operando1} {alu} {operando2} {lugar_guardar}"
                    lineas_binarias.append(linea_binaria)

        # Abrir un cuadro de diálogo para seleccionar dónde guardar el archivo
        archivo_guardar = filedialog.asksaveasfilename(title="Guardar archivo como", defaultextension=".txt", filetypes=(("Text files", "*.txt"), ("All files", "*.*")))
        if archivo_guardar:
            # Guardar los resultados en el archivo seleccionado
            with open(archivo_guardar, 'w') as f:
                f.write('\n'.join(lineas_binarias))
            
            messagebox.showinfo("Éxito", f"El contenido se ha decodificado y guardado en '{archivo_guardar}'")
    except Exception as e:
        messagebox.showerror("Error", f"Ocurrió un error: {e}")

def salir():
    """Cierra la aplicación."""
    root.quit()

# Configuración de la ventana principal
root = tk.Tk()
root.title("Decodificador de Instrucciones")
root.geometry("400x200")

# Crear botones
btn_seleccionar = tk.Button(root, text="Seleccionar Archivo", command=seleccionar_archivo)
btn_seleccionar.pack(pady=20)

btn_salir = tk.Button(root, text="Salir", command=salir)
btn_salir.pack(pady=20)

# Iniciar el bucle principal
root.mainloop()
