module memwb(clk, i_busC, i_out, i_rd, i_signals, o_busC, o_out, o_rd, o_GPRWR, o_MTR);
    input   [31:0]  i_busC;
    input   [31:0]  i_out;
    input   [4:0]   i_rd;
    input   [1:0]   i_signals;
    input           clk;
    output  [31:0]  o_busC;
    output  [31:0]  o_out;
    output  [4:0]   o_rd;
    output          o_GPRWR, o_MTR;

    reg     [31:0]  busC;
    reg     [31:0]  out;
    reg     [4:0]   rd;
    reg     [1:0]   signals;

    always @(posedge clk) begin
        busC = i_busC;
        out = i_out;
        rd = i_rd;
        signals = i_signals;
    end

    assign  o_busC = busC;
    assign  o_out = out;
    assign  o_rd = rd;
    assign  o_GPRWR = signals[1];
    assign  o_MTR = signals[0];

endmodule // memwb