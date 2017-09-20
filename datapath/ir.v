module ir(clk, clr, IRWr, ins, rs, rt, rd, shamt, imm16, imm26, decdOp);
    input   [31:0] ins;
    input   clk, clr, IRWr;
    output  [25:0] imm26;
    output  [15:0] imm16;
    output  [4:0] rs, rt, rd, shamt;
    output  [6:0] decdOp;

    reg     [31:0] ireg;

    always @(posedge clk) begin
        if(IRWr)
            ireg <= ins;
    end

    assign  decdOp = (ireg[31:26] == 6'd0) ? {ireg[5:0], 1'b1} : {ireg[31:26], 1'b0};
    assign  rs = ireg[25:21];
    assign  rt = ireg[20:16];
    assign  rd = ireg[15:11];
    assign  shamt = ireg[10:6];
    assign  imm16 = ireg[15:0];
    assign  imm26 = ireg[25:0];

   // initial
     //   ireg = 0;

endmodule // ir