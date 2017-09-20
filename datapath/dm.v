module dm_4k(din, clk, clr, DMWr, byte, addr, dout);
    input   [31:0] din, addr;
    input   clk, clr, DMWr, byte;
    output  [31:0] dout;

    integer i;
    reg     [31:0] dm [1023:0];

    assign dout = ((byte) && (addr[1:0] == 2'b00)) ? {{24{dm[addr[11:2]][7]}}, dm[addr[11:2]][7:0]} : 
                  ((byte) && (addr[1:0] == 2'b01)) ? {{24{dm[addr[11:2]][15]}}, dm[addr[11:2]][15:8]} : 
                  ((byte) && (addr[1:0] == 2'b10)) ? {{24{dm[addr[11:2]][23]}}, dm[addr[11:2]][23:16]} : 
                  ((byte) && (addr[1:0] == 2'b11)) ? {{24{dm[addr[11:2]][31]}}, dm[addr[11:2]][31:24]} : dm[addr[11:2]];

    always @(posedge clk) begin
        if(clr) begin
            for (i = 0; i<1024; i = i + 1) begin
                dm[i] <= 0;
            end
        end
        else if(DMWr) begin
            if(byte) begin
            case (addr[1:0])
                2'b00: dm[addr[11:2]] <= {dm[addr[11:2]][31:8], din[7:0]};
                2'b01: dm[addr[11:2]] <= {dm[addr[11:2]][31:16], din[7:0], dm[addr[11:2]][7:0]};
                2'b10: dm[addr[11:2]] <= {dm[addr[11:2]][31:24], din[7:0], dm[addr[11:2]][15:0]};
                2'b11: dm[addr[11:2]] <= {din[7:0], dm[addr[11:2]][23:0]};
            endcase
            end
            else    dm[addr[11:2]] <= din;
        end
    end

endmodule // dm
