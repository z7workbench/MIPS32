module im_4k(pc_addr, ins);
    input   [31:2] pc_addr;
    output  [31:0] ins;

    reg     [31:0] im [1023:0];

    assign ins = im[pc_addr[11:2]];

    initial
        $readmemh("code.txt", im);

endmodule // im
