`timescale 1ns/1ns 
module se(
    input [15:0]inst,
    output reg [31:0] sal
);
assign sal = {{16{inst[15]}},inst};
endmodule 
