module Register_tb #(parameter WIDTH_tb = 8) ();
reg                 clk_tb, load_tb, rst_tb;
reg  [WIDTH_tb-1:0] data_in_tb;
wire [WIDTH_tb-1:0] data_out_tb;

Register #(.WIDTH(WIDTH_tb)) DUT (
    .clk      (clk_tb),
    .load     (load_tb),
    .rst      (rst_tb),
    .data_in  (data_in_tb),
    .data_out (data_out_tb)
);

initial begin
    clk_tb= 1'b0;
    forever begin
        #1 clk_tb= ~clk_tb;
      end
    end

    initial begin
        rst_tb = 1'b0;  load_tb = 1'b0;  data_in_tb = 8'b0; #20;
        rst_tb = 1'b0;  load_tb = 1'b1;  data_in_tb = 8'b01010101; #10;
        rst_tb = 1'b0;  load_tb = 1'b1;  data_in_tb = 8'b10101010; #10;
        rst_tb = 1'b0;  load_tb = 1'b1;  data_in_tb = 8'b11111111; #10;
        rst_tb = 1'b1;  load_tb = 1'b1;  data_in_tb = 8'b11111111; #10;
        $stop;
    end

    initial begin
        $monitor("rst = %b, load = %b, data_in = %b, data_out = %b",
                  rst_tb,   load_tb,   data_in_tb,   data_out_tb);
    end
endmodule