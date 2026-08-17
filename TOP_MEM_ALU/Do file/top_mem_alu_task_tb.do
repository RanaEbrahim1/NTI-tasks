vlib work      
vlog top_mem_piso_sipo_alu.v top_mem_alu_task_tb.v     
vsim -voptargs=+acc work.TOP_MEM_ALU_TASK_tb
add wave sim /TOP_MEM_ALU_TASK_tb/DUT_TOP/*
run -all
#quit -sim