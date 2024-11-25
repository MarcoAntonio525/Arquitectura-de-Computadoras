module unidad_control(
    input [5:0] OP,
    output reg RegDst,
    output reg Branch,
    output reg MemRead,
    output reg ALUSrc,
    output reg MemToReg,
    output reg MemWrite,
    output reg RegWrite, 
    output reg [2:0] ALUop
);

always @* begin
    case (OP)
        6'b000000: // Tipo R
        begin
            RegDst = 1'b1;
            Branch = 1'b0;
            MemRead = 1'b0;
            ALUSrc = 1'b0;
            MemToReg = 1'b0;
            MemWrite = 1'b0;
            RegWrite = 1'b1;
            ALUop = 3'b010; // Función de la ALU determinada por func
        end
        6'b100011: // LW
        begin
            RegDst = 1'b0;
            Branch = 1'b0;
            MemRead = 1'b1;
            ALUSrc = 1'b1;
            MemToReg = 1'b1;
            MemWrite = 1'b0;
            RegWrite = 1'b1;
            ALUop = 3'b000; // Suma para calcular dirección
        end
        6'b101011: // SW
        begin
            RegDst = 1'bx; // No aplica
            Branch = 1'b0;
            MemRead = 1'b0;
            ALUSrc = 1'b1;
            MemToReg = 1'bx; // No aplica
            MemWrite = 1'b1;
            RegWrite = 1'b0;
            ALUop = 3'b000; // Suma para calcular dirección
        end
        6'b000100: // BEQ
        begin
            RegDst = 1'bx; // No aplica
            Branch = 1'b1;
            MemRead = 1'b0;
            ALUSrc = 1'b0;
            MemToReg = 1'bx; // No aplica
            MemWrite = 1'b0;
            RegWrite = 1'b0;
            ALUop = 3'b001; // Resta para comparación
        end
        6'b001000: // ADDI
        begin
            RegDst = 1'bx; // No aplica
            Branch = 1'b0;
            MemRead = 1'b0;
            ALUSrc = 1'b1; // Usar inmediato
            MemToReg = 1'bx; // No aplica
            MemWrite = 1'b1; // Escribir en memoria de datos
            RegWrite = 1'b0; // No escribir en registros
            ALUop = 3'b000; // Suma
        end
        6'b001010: // SLTI
        begin
            RegDst = 1'bx; // No aplica
            Branch = 1'b0;
            MemRead = 1'b0;
            ALUSrc = 1'b1; // Usar inmediato
            MemToReg = 1'bx; // No aplica
            MemWrite = 1'b1; // Escribir en memoria de datos
            RegWrite = 1'b0; // No escribir en registros
            ALUop = 3'b100; // SLT
        end
        6'b001100: // ANDI
        begin
            RegDst = 1'bx; // No aplica
            Branch = 1'b0;
            MemRead = 1'b0;
            ALUSrc = 1'b1; // Usar inmediato
            MemToReg = 1'bx; // No aplica
            MemWrite = 1'b1; // Escribir en memoria de datos
            RegWrite = 1'b0; // No escribir en registros
            ALUop = 3'b010; // AND
        end
        6'b001101: // ORI
        begin
            RegDst = 1'bx; // No aplica
            Branch = 1'b0;
            MemRead = 1'b0;
            ALUSrc = 1'b1; // Usar inmediato
            MemToReg = 1'bx; // No aplica
            MemWrite = 1'b1; // Escribir en memoria de datos
            RegWrite = 1'b0; // No escribir en registros
            ALUop = 3'b011; // OR
        end
        default: // Instrucción desconocida
        begin
            RegDst = 1'bx;
            Branch = 1'bx;
            MemRead = 1'bx;
            ALUSrc = 1'bx;
            MemToReg = 1'bx;
            MemWrite = 1'bx;
            RegWrite = 1'bx;
            ALUop = 3'bx;
        end
    endcase
end

endmodule
