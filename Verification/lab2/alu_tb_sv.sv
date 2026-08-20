module ALU_tb #(
    parameter WIDTH_tb = 8
);
//DUT
logic [WIDTH_tb-1:0] in_a_tb, in_b_tb;
logic [2:0]          opcode_tb;
logic                alu_en_tb;
logic [WIDTH_tb-1:0] alu_out_tb;
logic                a_is_zero_tb;
//generator
logic [WIDTH_tb-1:0] in_a_gen, in_b_gen;
logic [2:0]          opcode_gen;
logic                alu_en_gen;
//monitor
logic [WIDTH_tb-1:0] in_a_mon, in_b_mon;
logic [2:0]          opcode_mon;
logic                alu_en_mon;
//predictor
logic [WIDTH_tb-1:0] alu_out_expected;
logic                a_is_zero_expected;
//monitor out
logic [WIDTH_tb-1:0] alu_out_dut;
logic                a_is_zero_dut;


ALU #(WIDTH_tb) DUT (
    .alu_en    (alu_en_tb),
    .in_a      (in_a_tb),
    .in_b      (in_b_tb),
    .opcode    (opcode_tb),
    .alu_out   (alu_out_tb),
    .a_is_zero (a_is_zero_tb)
);

initial begin
    alu_en_tb    = 0;
    in_a_tb      = 0;
    in_b_tb      = 0;
    opcode_tb    = 0;

    repeat (10) begin
        generator();
        #10;
        driver();
        #10;
        monitor_in();
        #10;
        predictor();
        #10;
        monitor_out();
        #10;
        check();
        #10;
        $display("////////////////////DONE////////////////////");
    end
    end

//tasks
task generator();
    in_a_gen   = $random;
    in_b_gen   = $random;
    opcode_gen = $random;
    alu_en_gen = $random;
endtask 

task driver();
    in_a_tb   = in_a_gen;
    in_b_tb   = in_b_gen;
    opcode_tb = opcode_gen;
    alu_en_tb = alu_en_gen;
endtask

task monitor_in();
    in_a_mon   = in_a_tb;
    in_b_mon   = in_b_tb;
    opcode_mon = opcode_tb;
    alu_en_mon = alu_en_tb;
    $display("a = %0b, b = %0b, opcode = %0b, alu_en = %0b", 
              in_a_mon, in_b_mon, opcode_mon, alu_en_mon);
endtask

task predictor();
    if (in_a_mon == 0) begin
        a_is_zero_expected = 1'b1;
    end
    else begin
        a_is_zero_expected = 1'b0;
    end    
    if (~alu_en_mon)begin
        alu_out_expected = 0;
    end
    else begin
    case (opcode_mon)
    3'b000: begin
           alu_out_expected = in_a_mon + in_b_mon;
         end
    3'b001: begin
           alu_out_expected = in_a_mon - in_b_mon;
         end     
    3'b010: begin
           alu_out_expected = in_a_mon & in_b_mon;
         end
    3'b011: begin
           alu_out_expected = in_a_mon ^ in_b_mon;
         end
    3'b100: begin
           alu_out_expected = in_a_mon | in_b_mon;
         end     
    3'b101: begin
           alu_out_expected = in_a_mon;  
         end 
    default: begin
           alu_out_expected = 0;
         end                 
    endcase
    end    
    $display("a_is_zero_expected = %0b, alu_out_expected = %0b",
               a_is_zero_expected,       alu_out_expected);
endtask

task monitor_out();
    alu_out_dut   = alu_out_tb;
    a_is_zero_dut = a_is_zero_tb;
    $display("a_is_zero_dut = %0b, alu_out_dut = %0b",
              a_is_zero_dut,       alu_out_dut);
endtask

task check();
    if (a_is_zero_dut == a_is_zero_expected) begin
        $display("a_is_zero is true");
    end
    else begin
        $display("a_is_zero is wrong!");
        $display("Check the design again!");
    end
    if (alu_out_dut == alu_out_expected) begin
        $display("alu_out is true");
    end
    else begin
        $display("alu_out is wrong!");
        $display("Check the design again!");
    end    
endtask

endmodule