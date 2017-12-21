`define Origin  3'd0
`define busCEX  3'd1
`define busCMEM 3'd2
`define outMEM  3'd3
`define busW    3'd4

module forwarding(start, startEX, rs, rt, rdEX, lwEX, rdMEM, lwMEM, rdWB, GPRWrEX, GPRWrMEM, GPRWrWB, ASel, BSel);
    input   [4:0]   rs, rt;
    input   [4:0]   rdEX, rdMEM, rdWB;
    input           start, lwEX, lwMEM, GPRWrEX, GPRWrMEM, GPRWrWB, startEX;
    output  [2:0]   ASel, BSel;

    assign  ASel = ((start) || (((rs != rdEX) && (rs != rdMEM) && (rs != rdWB)) || ((GPRWrEX == 0) && (GPRWrMEM == 0) && (GPRWrWB == 0)))) ? `Origin :
                    ((rs == rdEX) && (GPRWrEX == 1) && (startEX)) ? `Origin : 
                    ((rs == rdEX) && (GPRWrEX == 1)) ? `busCEX : 
                    ((rs == rdMEM) && (GPRWrMEM == 1) && (lwMEM == 0)) ? `busCMEM : 
                    ((rs == rdMEM) && (GPRWrMEM == 1) && (lwMEM == 1)) ? `outMEM : `busW;
                    
    
    assign  BSel = ((start) || (((rt != rdEX) && (rt != rdMEM) && (rs != rdWB)) || ((GPRWrEX == 0) && (GPRWrMEM == 0) && (GPRWrWB == 0)))) ? `Origin :
                    ((rt == rdEX) && (GPRWrEX == 1) && (startEX)) ? `Origin : 
                    ((rt == rdEX) && (GPRWrEX == 1)) ? `busCEX : 
                    ((rt == rdMEM) && (GPRWrMEM == 1) && (lwMEM == 0)) ? `busCMEM : 
                    ((rt == rdWB) && (GPRWrMEM == 1) && (lwMEM == 1)) ? `outMEM : `busW;

endmodule // forwarding