`timescale 1ns/1ns 
module pc(
    input clk,
    input [31:0]suma,
    output reg [31:0]pc
);  
initial 
    pc= 32'b0;
always @(posedge clk) 
begin
    pc= suma;
end 
endmodule  