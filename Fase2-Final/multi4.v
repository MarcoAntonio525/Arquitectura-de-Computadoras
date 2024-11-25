//unidad de tiempo 
`timescale 1ns/1ns 
//nombre del modulo 
module multi4(
    //entradas 
    input [31:0]A,
    input[31:0]B,
    input sel,
    //salidas 
    output reg[31:0]C
);
//Asignaciones, instancias, bloques secuenciales*
always @* C <= (sel) ? A: B;
endmodule 
