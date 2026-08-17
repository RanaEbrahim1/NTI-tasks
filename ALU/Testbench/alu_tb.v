module ALU_tb #(parameter WIDTH_tb = 8) ();
reg  [WIDTH_tb-1:0] in_a_tb, in_b_tb;
reg  [2:0]       opcode_tb;
wire [WIDTH_tb-1:0] alu_out_tb;
wire             a_is_zero_tb;

ALU #(WIDTH_tb) DUT (
    .in_a      (in_a_tb),
    .in_b      (in_b_tb),
    .opcode    (opcode_tb),
    .alu_out   (alu_out_tb),
    .a_is_zero (a_is_zero_tb)
);

initial begin
    in_a_tb = 8'b01000010;  in_b_tb = 8'b10000110;  opcode_tb = 3'b000;  #10;  
    in_a_tb = 8'b01000010;  in_b_tb = 8'b10000110;  opcode_tb = 3'b001;  #10; 
    in_a_tb = 8'b01000010;  in_b_tb = 8'b10000110;  opcode_tb = 3'b010;  #10; 
    in_a_tb = 8'b01000010;  in_b_tb = 8'b10000110;  opcode_tb = 3'b011;  #10; 
    in_a_tb = 8'b01000010;  in_b_tb = 8'b10000110;  opcode_tb = 3'b100;  #10; 
    in_a_tb = 8'b01000010;  in_b_tb = 8'b10000110;  opcode_tb = 3'b101;  #10; 
    in_a_tb = 8'b01000010;  in_b_tb = 8'b10000110;  opcode_tb = 3'b110;  #10; 
    in_a_tb = 8'b01000010;  in_b_tb = 8'b10000110;  opcode_tb = 3'b111;  #10; 
    in_a_tb = 8'b00000000;  in_b_tb = 8'b10000110;  opcode_tb = 3'b111;  #10; 
    $stop;
end

initial begin
    $monitor ("in_a = %b, in_b = %b, opcode = %b, alu_out = %Sb, a_is_zero = %b",
               in_a_tb,   in_b_tb,   opcode_tb,   alu_out_tb,   a_is_zero_tb  );
end
endmodule