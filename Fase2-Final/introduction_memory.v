`timescale 1ns/1ns 
module im(
    input [31:0] ra,                // Dirección de lectura de la instrucción
    output reg [31:0] instruction   // Instrucción de 32 bits leída
); 
    reg [7:0] memoria [0:399];      // Memoria de 400 bytes para instrucciones

    // Inicializar memoria desde un archivo binario
    initial 
        $readmemb("imemoria.txt", memoria);

    // Siempre que cambie 'ra', se actualiza la instrucción
    always @(ra) begin
        // Leer 4 bytes consecutivos para formar la instrucción de 32 bits
        instruction = {memoria[ra], memoria[ra + 1], memoria[ra + 2], memoria[ra + 3]};
    end 
endmodule

