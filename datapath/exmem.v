module exmem(clk, i_busC, i_busB, i_rd, o_busC, o_busB, o_rd);
    input   [31:0]  i_busC;
    input   [31:0]  i_busB;
    input   [4:0]   i_rd;
    input           clk;
    output  [31:0]  o_busC;
    output  [31:0]  o_busB;
    output  [4:0]   o_rd;

    reg     [31:0]  busC;
    reg     [31:0]  busB;
    reg     [4:0]   rd;

    always @(posedge clk) begin
        busC = i_busC;
        busB = i_busB;
        rd = i_rd;
    end

    assign  o_busC = busC;
    assign  o_busB = busB;
    assign  o_rd = rd;
endmodule // exmem