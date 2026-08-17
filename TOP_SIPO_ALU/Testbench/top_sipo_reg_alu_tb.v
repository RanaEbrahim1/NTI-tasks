module  TOP_SIPO_ALU_tb #(
    parameter WIDTH_REG_tb = 20 ,
    parameter WIDTH_ALU_tb = 8   ) ();

reg                     clk, rst_n_reg_tb, shift_en_reg_tb, serial_in_reg_tb ;
wire [WIDTH_ALU_tb-1:0] alu_out_tb ;
wire                    a_is_zero_alu_tb ;
integer i;

TOP_MODULE #(
    .WIDTH_REG(WIDTH_REG_tb), .WIDTH_ALU(WIDTH_ALU_tb)
) DUT (
    .clk_reg(clk), .rst_n_reg(rst_n_reg_tb), .shift_en_reg(shift_en_reg_tb), .serial_in_reg(serial_in_reg_tb),
    .alu_out(alu_out_tb), .a_is_zero_alu(a_is_zero_alu_tb)
);

initial begin
    clk = 1'b0;
    forever begin
        #1 clk = ~clk;
    end
end    

initial begin
    rst_n_reg_tb = 1'b0; shift_en_reg_tb = 1'b0; serial_in_reg_tb = 1'b0;  @(negedge clk);
    rst_n_reg_tb = 1'b1; shift_en_reg_tb = 1'b0; serial_in_reg_tb = 1'b0;  @(negedge clk);
    rst_n_reg_tb = 1'b1; shift_en_reg_tb = 1'b1; serial_in_reg_tb = 1'b0;  @(negedge clk);
    for (i=0; i<20; i=i+1) begin
       serial_in_reg_tb = 1'b1; 
      @(negedge clk);
    end
    $stop;
end

initial begin
    $monitor("rst_en = %b, shift_en = %b, serial_in = %b, alu_out = %b, a_is_zero = %b",
              rst_n_reg_tb, shift_en_reg_tb, serial_in_reg_tb, alu_out_tb, a_is_zero_alu_tb );
end

endmodule