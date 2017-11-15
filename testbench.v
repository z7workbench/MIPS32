module testbench;
    reg clk;
    wire clr;

    mips mips0(.clk(clk), .clr(clr));

    always
    #50 clk=~clk;

    initial 
    begin
        clk = 0;
    end
        

endmodule // testbench