`define alu_nop 4'h0
`define alu_add 4'h1
`define alu_sub 4'h2
`define alu_and 4'h3
`define alu_or  4'h4
`define alu_slt 4'h5
`define alu_sll 4'h6
`define alu_lui 4'h7

module alu(busA, busB, busC, ALUOp);
    input   [31:0] busA, busB;
    input   [3:0] ALUOp;
    output  [31:0] busC;

    wire [32:0] tmp_rlt;

    assign  tmp_rlt = (ALUOp == `alu_add) ? {busA[31], busA[31:0]} + {busB[31], busB[31:0]} : 
                      (ALUOp == `alu_slt) ? {busA[31], busA[31:0]} - {busB[31], busB[31:0]} : 32'd0;

    assign  busC = (ALUOp == `alu_add) ? tmp_rlt[31:0] : 
                   (ALUOp == `alu_sub) ? busA - busB : 
                   (ALUOp == `alu_and) ? busA & busB : 
                   (ALUOp == `alu_or)  ? busA | busB : 
                   (ALUOp == `alu_slt) ? {31'd0, tmp_rlt[32]} : 
                   (ALUOp == `alu_sll) ? busA << busB[4:0] :
                   (ALUOp == `alu_lui) ? busB << 16 : 
                   (ALUOp == `alu_nop) ? 0 : 0;

endmodule // alu