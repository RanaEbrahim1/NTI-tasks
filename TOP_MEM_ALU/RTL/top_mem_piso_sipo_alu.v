module TOP_MEM_PISO_SIPO_ALU #(
    parameter REG_WIDTH  = 20,
    parameter ALU_WIDTH  = 8 ,
    parameter RAM_AWIDTH = 8 ,
    parameter RAM_DWIDTH = 20,
    parameter RAM_DEPTH  = 2**RAM_AWIDTH
)(
    input                       clk, wr_ram, rd_ram, rst_n,
    input      [RAM_AWIDTH-1:0] addr_ram,
    input      [RAM_DWIDTH-1:0] data_in_ram,
    output     [ALU_WIDTH-1:0 ] alu_out,
    output                      a_is_zero_alu      
);

//MEM
wire [RAM_DWIDTH-1:0]     data_out_ram ;
wire                      valid_ram ;

//PISO
wire                      en_piso ;
wire [REG_WIDTH-1:0]      parallel_in_piso ;
wire                      serial_out_piso, valid_piso ;
assign en_piso          = valid_ram ;
assign parallel_in_piso = data_out_ram ;

//SIPO
wire                      shift_en_sipo, serial_in_sipo ;
wire [REG_WIDTH-1:0]      parallel_out_sipo ;
assign shift_en_sipo    = valid_piso ;
assign serial_in_sipo   = serial_out_piso ;

//ALU
wire [ALU_WIDTH-1:0]      in_a_alu, in_b_alu ;
wire [2:0]                opcode_alu ;
wire                      alu_en ;
assign in_a_alu         = parallel_out_sipo [15:8] ;
assign in_b_alu         = parallel_out_sipo [7:0] ;
assign opcode_alu       = parallel_out_sipo [18:16] ;
assign alu_en           = parallel_out_sipo [19] ;



MEM_TRUE #(.AWIDTH(RAM_AWIDTH), .DWIDTH(RAM_DWIDTH), .RAM_DEPTH(RAM_DEPTH)) DUT_RAM (
    .clk(clk), .rst_n(rst_n), .rd(rd_ram), .wr(wr_ram), .valid(valid_ram),
    .addr(addr_ram), .data_in(data_in_ram), .data_out(data_out_ram) 
);

PISO_REG #(.WIDTH(REG_WIDTH)) DUT_PISO (
    .clk(clk), .rst_n(rst_n), .en(en_piso), .parallel_in(parallel_in_piso), 
    .serial_out(serial_out_piso), .valid(valid_piso)
);

SIPO_REG #(.WIDTH(REG_WIDTH)) DUT_SIPO (
    .clk(clk), .rst_n(rst_n), .shift_en(shift_en_sipo), 
    .serial_in(serial_in_sipo), .parallel_out(parallel_out_sipo)
);

ALU #(.WIDTH(ALU_WIDTH)) DUT_ALU (
    .in_a(in_a_alu), .in_b(in_b_alu), .opcode(opcode_alu), .alu_en(alu_en), 
    .alu_out(alu_out), .a_is_zero(a_is_zero_alu)
);

endmodule