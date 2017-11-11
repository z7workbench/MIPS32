`define Init    3'b000
`define Fetch   3'b001
`define Decd    3'b010
`define Exe     3'b011
`define OpMem   3'b100
`define WrBack  3'b101
module ctrl();

    reg     [2:0] state;

    // Finite State Machine
    always @(posedge clk) begin
        if(clr)
            state <= 0;
        else case (state)
            `Init   : state <= `Fetch;
            `Fetch  : state <= `Decd;
            `Decd   : state <= `Exe;
            `Exe    : state <= `OpMem;
            `OpMem  : state <= `WrBack;
            `WrBack : state <= `Fetch;
        endcase
    end

endmodule // ctrl