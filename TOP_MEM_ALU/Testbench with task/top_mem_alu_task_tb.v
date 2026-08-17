module TOP_MEM_ALU_TASK_tb #(
    parameter ALU_WIDTH_tb  = 8 ,
    parameter RAM_AWIDTH_tb = 8 ,
    parameter RAM_DWIDTH_tb = 20 
) ();
reg                          clk, wr_ram, rd_ram, rst_n ;
reg      [RAM_AWIDTH_tb-1:0] addr_ram ;
reg      [RAM_DWIDTH_tb-1:0] data_in_ram ;
wire     [ALU_WIDTH_tb-1:0 ] alu_out ;
wire                         a_is_zero_alu ; 
integer                      i;

TOP_MEM_PISO_SIPO_ALU DUT_TOP (
    .clk(clk), .wr_ram(wr_ram), .rd_ram(rd_ram), .rst_n(rst_n),
    .addr_ram(addr_ram), .data_in_ram(data_in_ram), .alu_out(alu_out), 
    .a_is_zero_alu(a_is_zero_alu)
);

initial begin
    clk = 1'b0;
    forever begin
        #1 clk = ~clk;
    end
end     

initial begin
    rst_n = 1'b0; wr_ram = 1'b0; rd_ram = 1'b0; 
    addr_ram = {RAM_AWIDTH_tb{1'b0}}; data_in_ram = {RAM_DWIDTH_tb{1'b0}};
    repeat(4) @(negedge clk);
    rst_n = 1'b1;
    @(negedge clk);
    //write
    wr_ram = 1'b1;
    addr_ram = 8'b11110000;
    data_in_ram = {RAM_DWIDTH_tb{1'b1}};
    repeat(4) @(negedge clk);
    //read 
    wr_ram = 1'b0;
    rd_ram = 1'b1;
    addr_ram = 8'b11110000;
    @(negedge clk);
    rd_ram = 1'b0;
    repeat(50) @(negedge clk);
    //write 
    wr_ram = 1'b1;
    rd_ram = 1'b1;
    addr_ram = 8'b11111111;
    data_in_ram = {{10{1'b1}} , {10{1'b0}}};
    repeat(4) @(negedge clk);
    //read
    wr_ram = 1'b0;
    rd_ram = 1'b1;
    addr_ram = 8'b11111111;
    @(negedge clk);
    rd_ram = 1'b0;
    repeat(50) @(negedge clk);

    //write 
    for (i=0; i<100; i=i+1) begin
        write (wr_ram, rd_ram, addr_ram, data_in_ram);
    end

    //read
    for (i=20; i<100; i=i+1) begin
        read (wr_ram, rd_ram, addr_ram, data_in_ram);
    end    

    $stop;
end

initial begin
    $monitor("rst_n=%b, wr=%b, rd=%b, addr=%b, data_in=%b, alu_out=%b, a_is_zero=%b",
              rst_n, wr_ram, rd_ram, addr_ram, data_in_ram, alu_out, a_is_zero_alu);
end

task write;
output                     wr_task, rd_task;
output [RAM_AWIDTH_tb-1:0] addr_task;
output [RAM_DWIDTH_tb-1:0] data_in_task;

begin
    wr_task = 1'b1;
    rd_task = $random;
    addr_task = $random;
    data_in_task = $random;
    repeat(30) @(negedge clk);
end
endtask

task read;
output                     wr_task, rd_task;
output [RAM_AWIDTH_tb-1:0] addr_task;
output [RAM_DWIDTH_tb-1:0] data_in_task;

begin
    wr_task = 1'b0;
    rd_task = 1'b1;
    addr_task = $random;
    data_in_task = $random;
    repeat(30) @(negedge clk);
    rd_task = 1'b0;
    repeat(50) @(negedge clk);
end
endtask

endmodule