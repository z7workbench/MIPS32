module idex(clk, i_busA, i_busB, i_imm32, i_rd, i_signals, o_busA, o_busB, o_imm32, o_rd, o_GPRWr, o_BSel, o_DMWr, o_MTR, o_ALUOp);
    input   [31:0]  i_busA;
    input   [31:0]  i_busB;
    input   [31:0]  i_imm32;
    input   [7:0]   i_signals;
    input   [4:0]   i_rd;
    input           clk;
    output  [31:0]  o_busA;
    output  [31:0]  o_busB;
    output  [31:0]  o_imm32;
    output  [4:0]   o_rd;
    output          o_GPRWr, o_BSel, o_DMWr, o_MTR, o_ALUOp;

    reg     [31:0]  busA;
    reg     [31:0]  busB;
    reg     [31:0]  imm32;
    // GPRWr, BSel, DMWr, MTR, ALUOp[4:0]
    reg     [7:0]   signals;
    reg     [4:0]   rd;

    always @(posedge clk) begin
        busA <= i_busA;
        busB <= i_busB;
        imm32 <= i_imm32;
        signals <= i_signals;
        rd <= i_rd;
    end

    assign  o_busA = busA;
    assign  o_busB = busB;
    assign  o_imm32 = imm32;
    assign  o_rd = rd;
    assign  o_GPRWr = signals[7];
    assign  o_BSel = signals[6];
    assign  o_DMWr = signals[5];
    assign  o_MTR = signals[4];
    assign  o_ALUOp = signals[3:0];
endmodule // idex