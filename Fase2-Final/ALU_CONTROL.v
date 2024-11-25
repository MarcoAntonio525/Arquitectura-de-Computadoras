module ALU_CONTROL(
    input [5:0] func,
    input [2:0] ALUop,
    output reg [2:0] op
);
always @(*) 
begin 
    case (ALUop)
        3'b010: // Tipo R
            case (func)
                6'b100000: op = 3'd0; // SUMA
                6'b100010: op = 3'd1; // RESTA
                6'b100100: op = 3'd2; // AND
                6'b100101: op = 3'd3; // OR
                6'b101010: op = 3'd4; // SLT
                6'b011000: op = 3'd5; // MULTIPLICACIÓN
                6'b011010: op = 3'd6; // DIVISIÓN
                6'b000000: op = 3'd7; // NOP
                default: op = 3'bxxx;
            endcase   
        3'b000: op = 3'd0; // Suma para LW, SW, ADDI
        3'b001: op = 3'd1; // Resta para BEQ
        default: op = 3'bxxx;
    endcase 
end
endmodule

