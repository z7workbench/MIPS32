module exmem(clk, i_busC, i_busB, i_rd, i_signals, i_lw, i_start, o_busC, o_busB, o_rd, o_GPRWR, o_DMWR, o_MTR, o_lw, o_start);
    input   [31:0]  i_busC;
    input   [31:0]  i_busB;
    input   [4:0]   i_rd;
    input   [2:0]   i_signals;
    input           i_lw, i_start;
    input           clk;
    output  [31:0]  o_busC;
    output  [31:0]  o_busB;
    output  [4:0]   o_rd;
    output          o_GPRWR, o_DMWR, o_MTR, o_lw, o_start;

    reg     [31:0]  busC;
    reg     [31:0]  busB;
    reg     [4:0]   rd;
    //GPRWrEX, DMWrEX, MTREX
    reg     [2:0]   signals;
    reg             lw;
    reg             start;

    always @(posedge clk) begin
        busC <= i_busC;
        busB <= i_busB;
        rd <= i_rd;
        signals <= i_signals;
        lw <= i_lw;
        start <= i_start;
    end

    assign  o_busC = busC;
    assign  o_busB = busB;
    assign  o_rd = rd;
    assign  o_GPRWR = signals[2];
    assign  o_DMWR = signals[1];
    assign  o_MTR = signals[0];
    assign  o_lw = lw;
    assign  o_start = start;
endmodule // exmem