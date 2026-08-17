module MEM_TRUE #(
    parameter AWIDTH    = 8 ,
    parameter DWIDTH    = 20 ,
    parameter RAM_DEPTH = 2**AWIDTH 
) (
    input                   clk, wr, rd, rst_n,
    input      [AWIDTH-1:0] addr,
    input      [DWIDTH-1:0] data_in,
    output reg [DWIDTH-1:0] data_out,
    output reg              valid
);

reg [DWIDTH-1:0] mem [0:RAM_DEPTH-1];

integer i;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        for (i=0; i<RAM_DEPTH; i=i+1) begin
            mem[i] <= 1'b0;
        end
        data_out <= {DWIDTH{1'b0}};
        valid <= 1'b0;
    end
    else if (wr) begin
        mem [addr] <= data_in ;
        valid <= 1'b0;
    end
    else if (rd) begin
        data_out <= mem[addr] ;
        valid <= 1'b1 ;
    end
    else begin
        valid <= 1'b0;
    end
end

endmodule