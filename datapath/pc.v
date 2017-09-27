module pc(clk, clr, PCWr, pc_in, pc_out);
    input   [31:2] pc_in;
    input   clk, clr, PCWr;
    output  [31:2] pc_out;

    reg [31:2] pc;

    assign pc_out=pc;
    always @(posedge clk) begin
        if (clr)
            pc <= 30'h0000_0c00;
        else if (PCWr)
            pc <= pc_in;
    end

    initial begin
        pc = 30'h0000_0c00;
    end


endmodule // pc
