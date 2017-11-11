module memwb(clk, i_busC, i_out, o_busC, o_out);
    input   [31:0]  i_busC;
    input   [31:0]  i_out;
    input           clk;
    output  [31:0]  o_busC;
    output  [31:0]  o_out;

    reg     [31:0]  busC;
    reg     [31:0]  out;

    always @(posedge clk) begin
        busC = i_busC;
        out = i_out;
    end

    assign  o_busC = busC;
    assign  o_out = out;

endmodule // memwb