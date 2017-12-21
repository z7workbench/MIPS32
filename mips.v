module mips(clk, clr);
    input clk, clr;

    wire    [31:0]  ins;
    wire    [31:0]  busAID, busBID, imm32ID, busW;
    wire    [31:0]  busAEX, busBEX, imm32EX, busBNew, busCEX;
    wire    [31:0]  busBMEM, busCMEM, outMEM;
    wire    [31:0]  busCWB, outWB;
    wire    [31:2]  current, next;
    wire    [25:0]  imm26;
    wire    [15:0]  imm16;
    wire    [6:0]   decdOp;
    wire    [4:0]   rs, rt, rdID, rdNew, rdEX, rdMEM, rdWB;
    wire    [3:0]   ALUOpID, ALUOpEX;
    wire    [1:0]   nPCOp;
    wire            zero, PCWr, start;
    wire            GPRWrID, ExtOp, RWSel, BSelID, DMWrID, MTRID, lwID;
    wire            GPRWrEX, BSelEX, DMWrEX, MTREX, lwEX;
    wire            GPRWrMEM, DMWrMEM, MTRMEM, lwMEM;

    wire    [31:0]  extbusA, extbusB;
    wire    [1:0]   extASel, extBSel;
    wire            startEX, startMEM;

    wire            GPRWrWB;

    npc     u_npc(.pc_in(current), .imm26(imm26), .imm16(imm16), .nPCOp(nPCOp), .zero(zero), .start(start), .pc_out(next));
    pc      u_pc(.clk(clk), .clr(clr), .PCWr(PCWr), .pc_in(next), .pc_out(current));
    im_4k   u_im(.pc_addr(current), .ins(ins));
    ifid    u_ifid(.clk(clk), .i_ins(ins), .o_rs(rs), .o_rt(rt), .o_rd(rdID), .o_imm16(imm16), .o_imm26(imm26), .o_op(decdOp));
    ctrl    u_ctrl(.clk(clk), .clr(clr), .decdOp(decdOp), .zero(zero), .PCWr(PCWr), .GPRWr(GPRWrID), .ExtOp(ExtOp), .RWSel(RWSel), .BSel(BSelID), .DMWr(DMWrID), .MemToReg(MTRID), .nPCOp(nPCOp), .ALUOp(ALUOpID), .start(start), .lw(lwID));
    gpr     u_gpr(.clk(clk), .clr(clr), .GPRWr(GPRWrWB), .busW(busW), .rw(rdWB), .rs(rs), .rt(rt), .busA(busAID), .busB(busBID), .zero(zero));
    ext     u_ext(.ExtOp(ExtOp), .imm16(imm16), .imm32(imm32ID));
    mux5_2  u_dist(.src1(rt), .src2(rdID), .sel(RWSel), .rlt(rdNew));
    idex    u_idex(.clk(clk), .i_busA(extbusA), .i_busB(extbusB), .i_imm32(imm32ID), .i_rd(rdNew), .i_signals({GPRWrID, BSelID, DMWrID, MTRID, ALUOpID}), .i_lw(lwID), .i_start(start), .o_busA(busAEX), .o_busB(busBEX), .o_imm32(imm32EX), .o_rd(rdEX), .o_GPRWr(GPRWrEX), .o_BSel(BSelEX), .o_DMWr(DMWrEX), .o_MTR(MTREX), .o_ALUOp(ALUOpEX), .o_lw(lwEX), .o_start(startEX));
    mux32_2 u_b(.src1(busBEX), .src2(imm32EX), .sel(BSelEX), .rlt(busBNew));
    alu     u_alu(.busA(busAEX), .busB(busBNew), .busC(busCEX), .ALUOp(ALUOpEX));
    exmem   u_exmem(.clk(clk), .i_busC(busCEX), .i_busB(busBEX), .i_rd(rdEX), .i_signals({GPRWrEX, DMWrEX, MTREX}), .i_lw(lwEX), .i_start(startEX), .o_busC(busCMEM), .o_busB(busBMEM), .o_rd(rdMEM), .o_GPRWR(GPRWrMEM), .o_DMWR(DMWrMEM), .o_MTR(MTRMEM), .o_lw(lwMEM), .o_start(startMEM));
    dm_4k   u_dm(.din(busBMEM), .clk(clk), .clr(clr), .DMWr(DMWrMEM), .addr(busCMEM), .dout(outMEM));
    memwb   u_memwb(.clk(clk), .i_busC(busCMEM), .i_out(outMEM), .i_rd(rdMEM), .i_signals({GPRWrMEM, MTRMEM}), .o_busC(busCWB), .o_out(outWB), .o_rd(rdWB), .o_GPRWR(GPRWrWB), .o_MTR(MTRWB));
    mux32_2 u_MTR(.src1(outWB), .src2(busCWB), .sel(MTRWB), .rlt(busW));

    forwarding  u_forwarding(.start(start), .startEX(startMEM), .rs(rs), .rt(rt), .rdEX(rdEX), .lwEX(lwEX), .rdMEM(rdMEM), .lwMEM(lwMEM), .GPRWrEX(GPRWrEX), .GPRWrMEM(GPRWrMEM), .ASel(extASel), .BSel(extBSel));
    mux32_4     u_extA(.src1(busAID), .src2(busCEX), .src3(busCMEM), .src4(outMEM), .sel(extASel), .rlt(extbusA));
    mux32_4     u_extB(.src1(busBID), .src2(busCEX), .src3(busCMEM), .src4(outMEM), .sel(extBSel), .rlt(extbusB));
endmodule // mips