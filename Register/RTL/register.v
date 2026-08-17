module Register #(parameter WIDTH = 8) (
    input            clk, load, rst,
    input      [WIDTH-1:0] data_in,
    output reg [WIDTH-1:0] data_out
);

always @(posedge clk ) begin
    if (rst) begin
        data_out <= 0;
    end
    else if (load) begin
        data_out <= data_in;
    end
end
endmodule