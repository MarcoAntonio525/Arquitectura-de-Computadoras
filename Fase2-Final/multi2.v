//unidad de tiempo 
`timescale 1ns/1ns 
//nombre del modulo 
module multi2(
    //entradas 
    input [4:0]A,
    input[4:0]B,
    input sel,
    //salidas 
    output reg[4:0]C
);
//Asignaciones, instancias, bloques secuenciales*
always @* C <= (sel) ? B : A;
endmodule 
