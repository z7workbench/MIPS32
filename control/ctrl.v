`define ins_addu    7'b1000011
`define ins_subu    7'b1000111
`define ins_ori     7'b0011010
`define ins_lw      7'b1000110
`define ins_sw      7'b1010110
`define ins_beq     7'b0001000
`define ins_j       7'b0000100

`define npc_nml     2'b00
`define npc_beq     2'b01
`define npc_j       2'b10
`define npc_jmp     2'b11

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
module ctrl(clk, clr, decdOp, zero, PCWr, GPRWr, ExtOp, RWSel, BSel, DMWr, MemToReg, nPCOp, ALUOp, lw);
    input   [6:0]   decdOp;
    input           clk, clr, zero;
    output          PCWr, GPRWr, ExtOp, RWSel, BSel, DMWr, MemToReg, lw;
    output  [1:0]   nPCOp;
    output  [3:0]   ALUOp;

    reg     [2:0]   state;
    reg             flag;

    assign  PCWr = 1'b1;
    // assign  PCWr = (flag && ((decdOp === `ins_j) || ((decdOp === `ins_beq) && zero))) ? 0 : 1;
    assign  GPRWr = (!flag && ((decdOp == `ins_addu) || (decdOp == `ins_subu) || (decdOp == `ins_ori) || (decdOp == `ins_lw))) ? 1 : 0;
    assign  ExtOp = ((decdOp == `ins_ori) || (decdOp == `ins_lw) || (decdOp == `ins_sw) || (decdOp == `ins_beq)) ? 1 : 0;
    assign  RWSel = ((decdOp == `ins_addu) || (decdOp == `ins_subu)) ? 1 : 0;
    assign  BSel = ((decdOp == `ins_ori) || (decdOp == `ins_lw) || (decdOp == `ins_sw) || (decdOp == `ins_beq)) ? 1 : 0;
    assign  DMWr = (!flag && (decdOp == `ins_sw)) ? 1 : 0;
    assign  MemToReg = (decdOp == `ins_lw) ? 0 : 1;
    assign  nPCOp = (flag) ? `npc_jmp : (decdOp === `ins_beq) ? `npc_beq : 
                    (decdOp === `ins_j) ? `npc_j : `npc_nml;
    assign  ALUOp = ((decdOp == `ins_addu) || (decdOp == `ins_lw) || (decdOp == `ins_sw) || (decdOp == `ins_beq)) ? `alu_add : 
                    (decdOp == `ins_subu) ? `alu_sub : 
                    (decdOp == `ins_ori) ? `alu_or : `alu_nop;
    assign  lw = (decdOp == `ins_lw);
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
        if(!flag && ((decdOp == `ins_j) || ((decdOp == `ins_beq) && zero)))
            flag <= 1;
        else flag <= 0;
    end


    initial 
    begin
        state = 0;
    end
endmodule // ctrl