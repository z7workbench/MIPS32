`define Origin  3'd0
`define busCEX  3'd1
`define busCMEM 3'd2
`define outMEM  3'd3
`define busW    3'd4

module forwarding(rs, rt, rdEX, lwEX, rdMEM, lwMEM, rdWB, GPRWrEX, GPRWrMEM, GPRWrWB, ASel, BSel);
    input   [4:0]   rs, rt;
    input   [4:0]   rdEX, rdMEM, rdWB;
    input           lwEX, lwMEM, GPRWrEX, GPRWrMEM, GPRWrWB;
    output  [2:0]   ASel, BSel;

    assign  ASel = (((rs != rdEX) && (rs != rdMEM) && (rs != rdWB)) || ((GPRWrEX === 0) && (GPRWrMEM === 0) && (GPRWrWB === 0))) ? `Origin :
                    ((rs === rdEX) && (GPRWrEX === 1)) ? `busCEX : 
                    ((rs === rdMEM) && (GPRWrMEM === 1) && (lwMEM === 0)) ? `busCMEM : 
                    ((rs === rdMEM) && (GPRWrMEM === 1) && (lwMEM === 1)) ? `outMEM : 
                    ((rs === rdWB) && (GPRWrWB === 1)) ? `busW : `Origin;
                    
    
    assign  BSel = (((rt != rdEX) && (rt != rdMEM) && (rt != rdWB)) || ((GPRWrEX === 0) && (GPRWrMEM === 0) && (GPRWrWB === 0))) ? `Origin :
                    ((rt === rdEX) && (GPRWrEX === 1)) ? `busCEX : 
                    ((rt === rdMEM) && (GPRWrMEM === 1) && (lwMEM === 0)) ? `busCMEM : 
                    ((rt === rdMEM) && (GPRWrMEM === 1) && (lwMEM === 1)) ? `outMEM : 
                    ((rt === rdWB) && (GPRWrWB === 1)) ? `busW : `Origin;

endmodule // forwarding