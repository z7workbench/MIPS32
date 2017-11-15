`define ins_addu    7'b1000011
`define ins_subu    7'b1000111
`define ins_ori     7'b0011010
`define ins_lw      7'b1000110
`define ins_sw      7'b1010110
`define ins_beq     7'b0001000
`define ins_j       7'b0000100

`define alu_nop 4'h0
`define alu_add 4'h1
`define alu_sub 4'h2
`define alu_and 4'h3
`define alu_or  4'h4
`define alu_slt 4'h5
`define alu_sll 4'h6
`define alu_lui 4'h7

`define Init    3'b000
`define Fetch   3'b001
`define Decd    3'b010
`define Exe     3'b011
`define OpMem   3'b100
`define WrBack  3'b101
module ctrl(clk, clr, decdOp, PCWr, GPRWr, ExtOp, RWSel, BSel, DMWr, MemToReg, nPCOp, ALUOp);
    input   [6:0]   decdOp;
    input           clk, clr;
    output          PCWr, GPRWr, ExtOp, RWSel, BSel, DMWr, MemToReg;
    output  [1:0]   nPCOp;
    output  [3:0]   ALUOp;

    reg     [2:0] state;

    assign  PCWr = 1'b1;
    assign  GPRWr = ((decdOp == `ins_addu) || (decdOp == `ins_subu) || (decdOp == `ins_ori) || (decdOp == `ins_lw)) ? 1 : 0;
    assign  ExtOp = ((decdOp == `ins_ori) || (decdOp == `ins_lw) || (decdOp == `ins_sw) || (decdOp == `ins_beq)) ? 1 : 0;
    assign  RWSel = ((decdOp == `ins_addu) || (decdOp == `ins_subu)) ? 1 : 0;
    assign  BSel = ((decdOp == `ins_ori) || (decdOp == `ins_lw) || (decdOp == `ins_sw) || (decdOp == `ins_beq)) ? 1 : 0;
    assign  DMWr = (decdOp == `ins_sw) ? 1 : 0;
    assign  MemToReg = (decdOp == `ins_lw) ? 0 : 1;
    assign  nPCOp = 0;
    assign  ALUOp = ((decdOp == `ins_addu) || (decdOp == `ins_lw) || (decdOp == `ins_sw) || (decdOp == `ins_beq)) ? `alu_add : 
                    (decdOp == `alu_sub) ? `alu_sub : 
                    (decdOp == `ins_ori) ? `alu_or : `alu_nop;

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