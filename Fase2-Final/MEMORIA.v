`timescale 1ns/1ns
//CREACION DEL MODULO 
module MEMORIA(
//ENTRADAS
    input [31:0]WD,
    input [31:0]Adress,
    input MTW,
    input MTR,
//SALIDAS
    output reg[31:0] RD
);
reg [31:0] memoria [0:31];
//BLOQUE ALWAYS
initial 
        $readmemb("datomemo.txt", memoria);
always @* 
begin 
//CONDICIONAL, LEER O ESCRIBIR 
    if (MTW == 1) 
        begin 
            memoria[Adress] <=WD;
            RD <= 32'bx;
        end 
        else 
            RD <= memoria[Adress];
    end 
endmodule 

