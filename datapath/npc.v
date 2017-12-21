`define npc_nml     2'b00
`define npc_beq     2'b01
`define npc_j       2'b10

module npc(pc_in, imm26, imm16, nPCOp, zero, start, pc_out);
    input   [31:2]  pc_in;
    input   [25:0]  imm26;
    input   [15:0]  imm16;
    input   [1:0]   nPCOp;
    input           zero;
    input           start;
    output  [31:2]  pc_out;

    assign pc_out = (start) ? pc_in + 1 :
                    (nPCOp == `npc_nml) ? pc_in + 1 :
                    (nPCOp == `npc_beq && zero == 0) ? pc_in + 1 :
                    (nPCOp == `npc_beq && zero == 1) ? pc_in + {{16{imm16[15]}}, imm16} :
                    (nPCOp == `npc_j) ? { pc_in[31:28], imm26 } : 0;

endmodule // npc