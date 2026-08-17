vlib work      
vlog top_mem_piso_sipo_alu.v top_mem_piso_sipo_alu_tb.v     
vsim -voptargs=+acc work.TOP_MEM_PISO_SIPO_ALU_tb
add wave /TOP_MEM_PISO_SIPO_ALU_tb/DUT/*
run -all
#quit -sim