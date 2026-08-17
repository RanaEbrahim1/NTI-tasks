module CONTROLLER_tb #(
    parameter WIDTH_tb = 3
) ();

reg                clk, rst, zero, in_a, in_b;
reg [WIDTH_tb-1:0] phase, opcode;
wire               sel, rd, ld_ir, halt, inc_pc;
wire               ld_ac, ld_pc, wr, data_e, alu_out;
integer            i;

CONTROLLER #(WIDTH_tb) TB (
    .clk(clk), .rst(rst), .zero(zero), .in_a(in_a), .in_b(in_b), 
    .phase(phase), .opcode(opcode), .sel(sel), .rd(rd), .ld_ir(ld_ir),
    .halt(halt), .inc_pc(inc_pc), .ld_ac(ld_ac), .ld_pc(ld_pc), 
    .wr(wr), .data_e(data_e), .alu_out(alu_out)
);

initial begin
    clk = 1'b0;
    forever begin
        #1 clk = ~clk; 
    end
end

initial begin
    rst = 1'b1; zero = 1'b0; in_a = 1'b0; in_b = 1'b0;
    phase = {WIDTH_tb{1'b0}}; opcode = {WIDTH_tb{1'b0}};
    repeat (5) @(negedge clk);
    rst = 1'b0; 
    repeat (5) @(negedge clk);
    for (i=0; i<50; i=i+1) begin
        zero   = $random;
        in_a   = $random;
        in_b   = $random;
        phase  = $random;
        opcode = $random;
        repeat (5) @(negedge clk);
    end
    $stop;
end

initial begin
    $monitor("zero = %b, in_a = %b, in_b = %b, phase = %b, opcode = %b, sel = %b, rd = %b, ld_ir = %b, halt = %b, inc_pc = %b, ld_ac = %b, ld_pc = %b, wr = %b, data_e = %b, alu_out = %b ",
              zero,      in_a,      in_b,      phase,      opcode,      sel,      rd,      ld_ir,      halt,      inc_pc,      ld_ac,      ld_pc,      wr,      data_e,      alu_out      );
end
endmodule