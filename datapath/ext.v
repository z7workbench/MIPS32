`define ext_zero    1'b0
`define ext_sign    1'b1

module ext(ExtOp, imm16, imm32);
    input   [15:0] imm16;
    input   ExtOp;
    output  [31:0] imm32;

    assign imm32 = (ExtOp == `ext_zero) ? {16'd0, imm16} :
                   (ExtOp == `ext_sign) ? {{16{imm16[15]}}, imm16} : 31'd0;
                   
endmodule // ext
