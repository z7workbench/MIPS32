module mux32_2(src1, src2, sel, rlt);
    input   [31:0] src1, src2;
    input   sel;
    output  [31:0] rlt;

    assign  rlt = (sel) ? src2 : src1;
endmodule // mux32_2

module mux5_3(src1, src2, src3, sel, rlt);
    input   [4:0] src1, src2, src3;
    input   [1:0] sel;
    output  [4:0] rlt;

    assign  rlt = (sel == 2'b00) ? src1 : 
                  (sel == 2'b01) ? src2 : src3;
endmodule // mux5_3

module mux32_3(src1, src2, src3, sel, rlt);
    input   [31:0] src1, src2, src3;
    input   [1:0] sel;
    output  [31:0] rlt;

    assign  rlt = (sel == 2'b00) ? src1 : 
                  (sel == 2'b01) ? src2 : src3;
endmodule // mux32_3