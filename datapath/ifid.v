module ifid(clk, i_ins, o_rs, o_rt, o_rd, o_imm16, o_imm26, o_op);
    input   [31:0]  i_ins;
    input           clk;
    output  [4:0]   o_rs;
    output  [4:0]   o_rt;
    output  [4:0]   o_rd;
    output  [15:0]  o_imm16;
    output  [25:0]  o_imm26;
    output  [7:0]   o_op;

    reg     [31:0]  ins;

    always @(posedge clk) begin
        ins <= i_ins;
    end

    assign  o_rs = ins[25:21];
    assign  o_rt = ins[20:16];
    assign  o_rd = ins[15:11];
    assign  o_imm16 = ins[15:0];
    assign  o_imm26 = ins[25:0];
    assign  o_op = (ins[31:26] == 6'd0) ? {ins[5:0], 1'b1} : {ins[31:26], 1'b0};

endmodule // ifid