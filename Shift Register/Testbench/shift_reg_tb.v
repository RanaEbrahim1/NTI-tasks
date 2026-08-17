module shift_register_tb ();

reg        clk, shift_in, LEFT_RIGHT ;
reg  [7:0] in ;
wire [7:0] shift_out ;
integer    i ;

shift_register TB (
    .clk(clk), .shift_in(shift_in), . LEFT_RIGHT(LEFT_RIGHT), 
    .shift_out(shift_out)
);

initial begin
    clk = 1'b0 ;
    forever begin
        #1 clk = ~clk;
    end
end

initial begin
    shift_in = 1'b0; LEFT_RIGHT = 1'b0; in = 8'b0;
    @(negedge clk);
    in = 8'b11110000 ;
    @(negedge clk);
    for (i=0; i<50; i=i+1) begin
        shift_in = $random;
        LEFT_RIGHT = $random;
    end
    $stop;
end

initial begin
    $monitor("in = %b, shift_in = %b, LEFT_RIGHT = %b, shift_out = %b",
              in,      shift_in,      LEFT_RIGHT,      shift_out);
end

endmodule