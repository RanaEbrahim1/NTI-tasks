module  shift_register (
input clk, shift_in, LEFT_RIGHT,
input [7:0] in,
output reg [7:0] shift_out 
);
always @(posedge clk) begin
   if (~LEFT_RIGHT)
   shift_out <=  {in[6:0], shift_in};
   else 
   shift_out <= {shift_in, in[7:1]};
end
endmodule