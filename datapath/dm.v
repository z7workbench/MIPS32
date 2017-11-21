module dm_4k(din, clk, clr, DMWr, addr, dout);
    input   [31:0] din, addr;
    input   clk, clr, DMWr;
    output  [31:0] dout;

    integer i;
    reg     [31:0] dm [1023:0];

    assign dout = dm[addr[11:2]];

    always @(posedge clk) begin
        if(clr) begin
            for (i = 0; i<1024; i = i + 1) begin
                dm[i] <= 0;
            end
        end
        else if(DMWr) begin
            dm[addr[11:2]] <= din;
        end
    end

endmodule // dm
