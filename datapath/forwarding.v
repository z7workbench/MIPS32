`define Origin  2'd0
`define busCEX  2'd1
`define busCMEM 2'd2
`define outMEM  2'd3

module forwarding(start, startEX, rs, rt, rdEX, lwEX, rdMEM, lwMEM, GPRWrEX, GPRWrMEM, ASel, BSel);
    input   [4:0]   rs, rt;
    input   [4:0]   rdEX, rdMEM;
    input           start, lwEX, lwMEM, GPRWrEX, GPRWrMEM, startEX;
    output  [1:0]   ASel, BSel;

    assign  ASel = ((start) || (((rs != rdEX) && (rs != rdMEM)) || ((GPRWrEX == 0) && (GPRWrMEM == 0)))) ? `Origin :
                    ((rs == rdEX) && (GPRWrEX == 1) && (startEX)) ? `Origin : 
                    ((rs == rdEX) && (GPRWrEX == 1)) ? `busCEX : 
                    ((rs == rdMEM) && (GPRWrMEM == 1) && (lwMEM == 0)) ? `busCMEM : `outMEM;
                    
    
    assign  BSel = ((start) || (((rt != rdEX) && (rt != rdMEM)) || ((GPRWrEX == 0) && (GPRWrMEM == 0)))) ? `Origin :
                    ((rt == rdEX) && (GPRWrEX == 1) && (startEX)) ? `Origin : 
                    ((rt == rdEX) && (GPRWrEX == 1)) ? `busCEX : 
                    ((rt == rdMEM) && (GPRWrMEM == 1) && (lwMEM == 0)) ? `busCMEM : `outMEM;

endmodule // forwarding