module temp(clk, din, dout);
    input   [31:0]  din;
    input           clk;
    output  [31:0]  dout;
    reg     [31:0]  value;

    always @(posedge clk) begin
        value <= din;
    end

    assign  dout = value;
endmodule // temp