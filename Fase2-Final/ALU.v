`timescale 1ns/1ns 
//CREACION DEL MODULO 
module ALU(
    //ENTRADAS 
    input [31:0] op1,
    input [31:0] op2, 
    input reg [2:0] sel,
    //SALIDAS 
    output reg [31:0] res,
    output reg zf
);//BLOQUE ALWAYS
always @*
    begin 
    case (sel)
        3'd0: res = op1 + op2; //SUMA
        3'd1: res = op1 - op2; //RESTA
        3'd2: res = op1 & op2; //AND
        3'd3: res = op1 | op2;//OR
        3'd4: res = (op1 < op2) ? 1:0;//SLT
        3'd5: res = op1 * op2;//MULTIPLICACI�N 
        3'd6: res = op1 / op2; //DIVISI�N
        3'd7: res = op1 << 0; //NO OPERACI�N
        default: res= 32'bx; 
    endcase 
      zf <= (res) ? 0:1;
end
endmodule 

