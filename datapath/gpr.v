module gpr(clk, clr, GPRWr, busW, rw, rs, rt, busA, busB, zero);
    input   [31:0] busW;
    input   [4:0] rw, rs, rt;
    input   clk, clr, GPRWr;
    output  [31:0] busA, busB;
    output  zero;

    reg     [31:0] reg_files [31:0];
    integer i;
    assign  busA = reg_files[rs];
    assign  busB = reg_files[rt];
    assign  zero = (busA == busB) ? 1 : 0;
    
    always @(posedge clk) begin
        if (clr) begin
            for (i = 0; i < 32 ; i = i + 1) begin
                reg_files[i] <= 0;
            end
            reg_files[28] <= 32'h1800;
            reg_files[29] <= 32'h2ffc;
        end
        else if (GPRWr)
            reg_files[rw] <= busW;
        reg_files[0] <= 0;
    end

    initial begin
        for (i = 0; i < 32 ; i = i + 1) begin
            reg_files[i] = 0;
        end
        reg_files[29] = 10'h2ff;
    end

endmodule // regfiles