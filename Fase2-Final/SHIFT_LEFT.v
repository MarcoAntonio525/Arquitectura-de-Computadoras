`timescale 1ns/1ns 
module sl(
    input [31:0] sal,
    output reg [31:0] salalu
);
assign salalu= sal<<2;
endmodule


