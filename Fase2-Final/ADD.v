`timescale 1ns/1ns 
module add(
    input[31:0] pc,
    input [31:0] bits,
    output reg [31:0] suma
); 
assign suma=pc + 4;
endmodule 
