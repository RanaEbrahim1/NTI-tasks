module ALU #(parameter WIDTH = 8) (
input      [WIDTH-1:0] in_a, in_b,
input      [2:0]       opcode,
input                  alu_en,
output reg [WIDTH-1:0] alu_out,
output reg             a_is_zero
);
always @(*) begin
    if (in_a == 0) begin
        a_is_zero = 1'b1;
    end
    else begin
        a_is_zero = 1'b0;
    end    
end

always @(*) begin
    if (~alu_en)begin
        alu_out = {WIDTH{1'b0}};
    end
    else begin
    case (opcode)
    3'b000: begin
           alu_out = in_a + in_b;
         end
    3'b001: begin
           alu_out = in_a - in_b;
         end     
    3'b010: begin
           alu_out = in_a & in_b;
         end
    3'b011: begin
           alu_out = in_a ^ in_b;
         end
    3'b100: begin
           alu_out = in_a | in_b;
         end     
    3'b101: begin
           alu_out = in_a;  
         end 
    default: begin
           alu_out = {WIDTH{1'b0}};  
         end                 
    endcase
    end
end
endmodule