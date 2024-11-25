`timescale 1ns/1ns 
module tb();
//wires
reg clk;
data td(
    .clk(clk)
);
always #100 
    clk = ~clk;
initial 
    begin
#10 
    clk <= 0; 
#1200 $stop;
end
endmodule 

