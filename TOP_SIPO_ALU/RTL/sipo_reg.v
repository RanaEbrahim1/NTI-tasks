module SIPO_REG #(parameter WIDTH = 20) (
    input clk, rst_n, shift_en, serial_in,
    output reg [WIDTH-1:0] parallel_out
);

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        parallel_out <= {WIDTH{1'b0}};
    end
    else if (shift_en) begin
        parallel_out <= {parallel_out[WIDTH-2:0] , serial_in} ;
    end
end

endmodule