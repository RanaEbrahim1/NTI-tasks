
module PISO_REG #(parameter WIDTH = 20) (
    input clk, rst_n, en,
    input [WIDTH-1:0] parallel_in ,
    output reg serial_out, valid
);

reg [WIDTH-1:0] shift_reg ;
integer         count ;

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        serial_out <= 1'b0;
        valid      <= 1'b0;
        shift_reg  <= {WIDTH{1'b0}};
        count      <= 1'b0;
    end
    else if (en) begin
        shift_reg  <= parallel_in;
        serial_out <= parallel_in[WIDTH-1];
        valid      <= 1'b1;
        count      <= 1;
    end
    else if (count < WIDTH) begin
        shift_reg  <= {shift_reg[WIDTH-2:0], 1'b0};
        serial_out <= shift_reg[WIDTH-1];
        valid      <= 1'b1;
        count      <= count + 1'b1;
    end
    else begin
        serial_out <= 1'b0;
        valid      <= 1'b0;
        count      <= 0;
    end    
end

endmodule
/* module PISO_REG #(parameter WIDTH = 20) (
    input clk, rst_n, en,
    input [WIDTH-1:0] parallel_in ,
    output reg serial_out, valid
);

reg [WIDTH-1:0] shift_reg ;
integer         count ;

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        serial_out <= 1'b0;
        valid      <= 1'b0;
        shift_reg  <= {WIDTH{1'b0}};
        count      <= 1'b0;
    end
    else if (en && !valid) begin
        shift_reg  <= {parallel_in[WIDTH-2:0], 1'b0};
        serial_out <= parallel_in[WIDTH-1];
        valid      <= 1'b1;
        count      <= 1;
    end
    else if (valid) begin
        if (count < WIDTH) begin
            serial_out <= shift_reg[WIDTH-1];
            shift_reg  <= {shift_reg[WIDTH-2:0], 1'b0};
            count      <= count + 1'b1;
        end
        else begin
            serial_out <= 1'b0;
            valid      <= 1'b0;
            count      <= 0;
        end
    end    
end

endmodule */
  /*
module PISO_REG #(parameter WIDTH = 20) (
    input clk,
    input rst_n,
    input en,
    input [WIDTH-1:0] parallel_in,
    output reg serial_out,
    output reg valid
);

reg [WIDTH-1:0] shift_reg;
integer count;

always @(posedge clk or negedge rst_n) begin

    if (!rst_n) begin
        shift_reg  <= 0;
        serial_out <= 0;
        valid      <= 0;
        count      <= 0;
    end

    else if (en && !valid) begin

        shift_reg  <= parallel_in;
        serial_out <= parallel_in[WIDTH-1];
        valid      <= 1'b1;
        count      <= 1;
    end

    else if (valid) begin

        if (count == WIDTH) begin

            // Last bit was already sent
            valid      <= 1'b0;
            serial_out <= 1'b0;
            count      <= 0;

        end

        else begin

            shift_reg  <= {shift_reg[WIDTH-2:0], 1'b0};
            serial_out <= shift_reg[WIDTH-2];
            count      <= count + 1;
        end

    end

end

endmodule */