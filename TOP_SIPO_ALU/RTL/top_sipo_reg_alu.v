module TOP_MODULE #(
    parameter WIDTH_REG = 20,
    parameter WIDTH_ALU  = 8   ) 
(
    input                   clk_reg, rst_n_reg, shift_en_reg, serial_in_reg,
    output  [WIDTH_ALU-1:0] alu_out,
    output                  a_is_zero_alu
);     

wire [WIDTH_REG-1:0] parallel_out_reg ;
wire [WIDTH_ALU-1:0] in_a_alu, in_b_alu ;
wire [2:0]           opcode_alu ;
wire                 alu_en ;

assign in_a_alu   = parallel_out_reg [15:8] ;
assign in_b_alu   = parallel_out_reg [7:0] ;
assign opcode_alu = parallel_out_reg [18:16] ;
assign alu_en     = parallel_out_reg [19] ;

SIPO_REG #(.WIDTH(WIDTH_REG)) DUT_REG (
    .clk(clk_reg), .rst_n(rst_n_reg), .shift_en(shift_en_reg), .serial_in(serial_in_reg),
    .parallel_out(parallel_out_reg)
    );

ALU      #(.WIDTH(WIDTH_ALU)) DUT_ALU (
    .in_a(in_a_alu), .in_b(in_b_alu), .opcode(opcode_alu), .alu_en(alu_en),
    .alu_out(alu_out), .a_is_zero(a_is_zero_alu)
    );

endmodule