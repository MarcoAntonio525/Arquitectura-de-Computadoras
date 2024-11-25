`timescale 1ns/1ns
//1. Creación del módulo
module BancoReg(
    input [4:0] RR1,
    input [4:0] RR2,
    input [4:0] WR,
    input [31:0] WD,
    input RegWrite,
    output reg [31:0] RD1,
    output reg [31:0] RD2
);
    reg [31:0] memoria [0:31];
    
    // Inicialización de la memoria desde archivo
    initial 
        $readmemb("bancoreg.txt", memoria);

    
    // Siempre que haya un cambio en las señales, se evalúa la memoria
    always @* begin
        if (RegWrite) 
            memoria[WR] = WD;  // Escritura en la memoria si RegWrite es 1
        RD1 = memoria[RR1];  // Lectura de la memoria
        RD2 = memoria[RR2];  // Lectura de la memoria
    end
endmodule
