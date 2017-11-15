module mips(clk, clr);
    input clk, clr;

    wire    [31:0]  ins;
    wire    [31:0]  busAID, busBID, imm32ID, busW;
    wire    [31:0]  busAEX, busBEX, imm32EX, busBNew, busCEX;
    wire    [31:2]  current, next;
    wire    [25:0]  imm26;
    wire    [15:0]  imm16;
    wire    [6:0]   decdOp;
    wire    [4:0]   rs, rt, rdID, rdNew, rdEX;

    wire    [4:0]   rdWB;
    wire    [3:0]   ALUOpID, ALUOpEX;
    wire    [1:0]   nPCOp;
    wire            zero, PCWr;
    wire            GPRWrID, ExtOp, RWSel, BSelID, DMWrID, MTRID;
    wire            GPRWrEX, BSelEX, DMWrEX, MTREX;

    wire            GPRWrWB;

    npc     u_npc(.pc_in(current), .imm26(imm26), .imm16(imm16), .nPCOp(nPCOp), .zero(zero), .pc_out(next));
    pc      u_pc(.clk(clk), .clr(clr), .PCWr(PCWr), .pc_in(next), .pc_out(current));
    im_4k   u_im(.pc_addr(current), .ins(ins));
    ifid    u_ifid(.clk(clk), .i_ins(ins), .o_rs(rs), .o_rt(rt), .o_rd(rdID), .o_imm16(imm16), .o_imm26(imm26), .o_op(decdOp));
    ctrl    u_ctrl(.clk(clk), .clr(clr), .decdOp(decdOp), .PCWr(PCWr), .GPRWr(GPRWrID), .ExtOp(ExtOp), .RWSel(RWSel), .BSel(BSelID), .DMWr(DMWrID), .MemToReg(MTRID), .nPCOp(nPCOp), .ALUOp(ALUOpID));
    gpr     u_gpr(.clk(clk), .clr(clr), .GPRWr(GPRWrWB), .busW(busW), .rw(rdWB), .rs(rs), .rt(rt), .busA(busAID), .busB(busBID), .zero(zero));
    ext     u_ext(.ExtOp(ExtOp), .imm16(imm16), .imm32(imm32ID));
    mux5_2  u_dist(.src1(rt), .src2(rdID), .sel(RWSel), .rlt(rdNew));
    idex    u_idex(.clk(clk), .i_busA(busAID), .i_busB(busBID), .i_imm32(imm32ID), .i_rd(rdNew), .i_signals({GPRWrID, BSelID, DMWrID, MTRID, ALUOpID}), .o_busA(busAEX), .o_busB(busBEX), .o_imm32(imm32EX), .o_rd(rdEX), .o_GPRWr(GPRWrEX), .o_BSel(BSelEX), .o_DMWr(DMWrEX), .o_MTR(MTREX), .o_ALUOp(ALUOpEX));
    mux32_2 u_b(.src1(busBEX), .src2(imm32EX), .sel(BSelEX), .rlt(busBNew));
    alu     u_alu(.busA(busAEX), .busB(busBNew), .busC(busCEX), .ALUOp(ALUOpEX));
    
endmodule // mips