`timescale 1ns/1ns
module data(
    input clk
);
// Wires o señales
wire [31:0] verdecito;
wire [31:0] amarillo;
wire [31:0] morado;
wire [31:0] moradito;
wire [31:0] naranja;
wire [31:0] verde;
wire [31:0] rojo;
wire [31:0] green2;
wire [31:0] m3;
wire [2:0] cafecito;
wire [31:0] m4;
wire [4:0] m2;
wire [31:0] sl;
wire [31:0] azul;
wire lila;
wire green1;
wire violeta;
wire cremita;
wire [2:0] celeste;
wire cafe;
wire naranjita;
wire gris;
wire red;
wire rosa;
wire [31:0] amarillito;

// Instancias
// PC
pc pc(
    .clk(clk),
    .suma(rojo),
    .pc(verdecito)
);

// Primer sumador
add FirstAdd(
    .pc(verdecito),
    .bits(32'd4),
    .suma(amarillo)
);

// Primer multiplexor
multi1 primero(
    .A(amarillo),
    .B(azul), 
    .C(rojo),
    .sel(green1) // Control de salto desde AND
);

// Memoria de instrucciones
im insMem (
    .ra(verdecito),
    .instruction(morado)
);

// Banco de registros
BancoReg br(
    .RR1(morado[25:21]),
    .RR2(morado[20:16]),
    .WD(amarillito),
    .WR(m2),
    .RD1(green2),
    .RD2(moradito),
    .RegWrite(cafe) // Desde unidad de control
);

// ALU
ALU alu(
    .op1(green2),
    .op2(m3), 
    .sel(cafecito), // Desde ALU_CONTROL
    .res(verde),
    .zf(red) // Flag de cero para Branch
);

// Memoria de datos
MEMORIA memory(
    .WD(moradito),
    .Adress(verde), // Dirección desde ALU
    .RD(m4),
    .MTW(gris), // Señal de escritura desde unidad de control
    .MTR(violeta) // Señal de lectura desde unidad de control
);

// Cuarto multiplexor
multi4 cuarto(
    .A(m4),
    .C(amarillito),
    .B(verde),
    .sel(cremita) // Señal MemToReg desde unidad de control
);

// Segundo multiplexor
multi2 segundo(
    .A(morado[20:16]),
    .B(morado[15:11]),
    .C(m2),
    .sel(lila) // Señal RegDst desde unidad de control
);

// Tercer multiplexor
multi3 tercero(
    .A(moradito),
    .B(naranja),
    .C(m3),
    .sel(naranjita) // Señal ALUSrc desde unidad de control
);

// Sign extend
se signExt(
    .inst(morado[15:0]),
    .sal(naranja)
);

// Shift left
sl shifL(
    .sal(naranja),
    .salalu(sl)
);

// Segundo sumador 
add secondAdd(
    .pc(amarillo),
    .bits(sl),
    .suma(azul) // Dirección de salto
);

// Unidad de control
unidad_control uc(
    .OP(morado[31:26]),
    .RegDst(lila),
    .Branch(rosa),
    .MemRead(violeta),
    .ALUSrc(naranjita),
    .MemToReg(cremita),
    .MemWrite(gris),
    .RegWrite(cafe), 
    .ALUop(celeste)
);

// ALU control
ALU_CONTROL ac(
    .func(morado[5:0]),
    .ALUop(celeste),
    .op(cafecito)
);

// Compuerta AND para Branch
andd c_and(
    .A(rosa),
    .B(red),
    .C(green1) // Señal de salto
);

endmodule
