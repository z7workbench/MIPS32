module idex(clk, i_busA, i_busB, i_imm32, i_rd, o_busA, o_busB, o_imm32, o_rd);
    input   [31:0]  i_busA;
    input   [31:0]  i_busB;
    input   [31:0]  i_imm32;
    input   [4:0]   i_rd;
    input           clk;
    output  [31:0]  o_busA;
    output  [31:0]  o_busB;
    output  [31:0]  o_imm32;
    output  [4:0]   o_rd;

    reg     [31:0]  busA;
    reg     [31:0]  busB;
    reg     [31:0]  imm32;
    reg     [4:0]   rd;

    always @(posedge clk) begin
        busA = i_busA;
        busB = i_busB;
        imm32 = i_imm32;
        rd = i_rd;
    end

    assign  o_busA = busA;
    assign  o_busB = busB;
    assign  o_imm32 = imm32;
    assign  o_rd = rd;
endmodule // idex