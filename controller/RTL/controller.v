module CONTROLLER #(
    parameter WIDTH = 3) 
(
    input                   clk, rst, zero, in_a, in_b,
    input       [WIDTH-1:0] phase, opcode,
    output reg              sel, rd, ld_ir, halt, inc_pc,
    output reg              ld_ac, ld_pc, wr, data_e, alu_out
);

localparam  INST_FETCH = 3'b001;
localparam  INST_ADDR  = 3'b000;
localparam  INST_LOAD  = 3'b010;
localparam  OP_ADDR    = 3'b100;
localparam  IDLE       = 3'b011;
localparam  OP_FETCH   = 3'b101;
localparam  ALU_OP     = 3'b110;
localparam  STORE      = 3'b111;

reg  CS, NS ;
wire alu_op, HALT,SKZ, JMP ;

assign alu_op = (opcode == 3'b101) |
                (opcode == 3'b011) |
                (opcode == 3'b100) |
                (opcode == 3'b101) ;
assign HALT   = (opcode == 3'b000) ;  
assign SKZ    = (opcode == 3'b001) ; 
assign JMP    = (opcode == 3'b111) ;  
assign STO    = (opcode == 3'b110) ;            

//state memory
always @(posedge clk) begin
    if (rst) begin
        CS <= INST_ADDR;
    end
    else begin
        CS <= NS;
    end
end

//next state logic
always @(*) begin
  case (opcode)
  3'b010 : begin
            alu_out = in_a + in_b ;
           end
  3'b011 : begin
            alu_out = in_a & in_b ;
           end
  3'b100 : begin
            alu_out = in_a ^ in_b ;
           end
  3'b101 : begin
            alu_out = in_b ;
           end
  default: begin
            alu_out = in_a ;
           end
  endcase
end
always @(*) begin    
    case (CS)
    INST_ADDR : if (phase == 3'b001) begin
                  NS = INST_FETCH ;
                end
                else begin
                  NS = INST_ADDR  ;
                end
    INST_FETCH: if (phase == 3'b010) begin
                  NS = INST_LOAD  ;
                end
                else begin
                  NS = INST_FETCH ;
                end
    INST_LOAD : if (phase == 3'b011) begin
                  NS = IDLE       ;
                end
                else begin
                  NS = INST_LOAD  ;
                end
    IDLE      : if (phase == 3'b001) begin
                  NS = OP_ADDR    ;
                end
                else begin
                  NS = IDLE       ;
                end
    OP_ADDR   : if (phase == 3'b001) begin
                  NS = OP_FETCH   ;
                end
                else begin
                  NS = OP_ADDR    ;
                end
    OP_FETCH  : if (phase == 3'b001) begin
                  NS = ALU_OP     ;
                end
                else begin
                  NS = OP_FETCH   ;
                end
    ALU_OP    : if (phase == 3'b001) begin
                  NS = STORE      ;
                end
                else begin
                  NS = ALU_OP     ;
                end
    STORE     : if (phase == 3'b001) begin
                  NS = INST_ADDR  ;
                end
                else begin
                  NS = STORE      ;
                end
    default   : begin
                  NS = INST_ADDR  ;
                end
    endcase
end

//output logic
always @(*) begin
    case (CS)
    INST_ADDR : begin
                  outputs (1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0); 
                end
    INST_FETCH: begin
                  outputs (1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0); 
                end
    INST_LOAD : begin
                  outputs (1'b1, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0); 
                end
    IDLE      : begin
                  outputs (1'b1, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0); 
                end
    OP_ADDR   : begin
                  outputs (1'b0, 1'b0, 1'b0, HALT, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0); 
                end
    OP_FETCH  : begin
                  outputs (1'b0, alu_op, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0); 
                end
    ALU_OP    : begin
                  outputs (1'b0, alu_op, 1'b0, 1'b0, (SKZ && zero), 1'b0, JMP, 1'b0, STO); 
                end
    STORE     : begin
                  outputs (1'b0, alu_op, 1'b0, 1'b0, 1'b0, alu_op, JMP, STO, STO); 
                end
    default   : begin
                  outputs (1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0); 
                end
    endcase    
end

task outputs;
input sel_t    ; 
input rd_t     ; 
input ld_ir_t  ; 
input halt_t   ; 
input inc_pc_t ; 
input ld_ac_t  ; 
input ld_pc_t  ;
input wr_t     ; 
input data_e_t ; 
begin
sel    <= sel_t    ;
rd     <= rd_t     ; 
ld_ir  <= ld_ir_t  ;
halt   <= halt_t   ;
inc_pc <= inc_pc_t ;
ld_ac  <= ld_ac_t  ;
ld_pc  <= ld_pc_t  ;
wr     <= wr_t     ;
data_e <= data_e_t ;
end
endtask


endmodule