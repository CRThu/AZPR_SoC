`timescale 1ns/100ps
`include "./CPU/cpu_spm_def.v"
`include "./CPU/cpu_spm.v"
`include "./Global/global_std_def.v"

module cpu_spm_tb;

    /*  clock  */
    reg clk = `LOW;

    /*  Port A / IF  */
    reg [`SPM_ADDR_BUS] if_spm_addr;
    reg if_spm_as_n = `DISABLE_;
    reg if_spm_rw = `READ;
    reg [`WORD_DATA_BUS] if_spm_wr_data;
    wire [`WORD_DATA_BUS] if_spm_rd_data;

    /*  Port B / MEM  */
    reg [`SPM_ADDR_BUS] mem_spm_addr;
    reg mem_spm_as_n = `DISABLE_;
    reg mem_spm_rw = `READ;
    reg [`WORD_DATA_BUS] mem_spm_wr_data;
    wire [`WORD_DATA_BUS] mem_spm_rd_data;

    cpu_spm cpu_spm_01(
        /*  clock  */
        clk,

        /*  Port A / IF  */
        if_spm_addr,
        if_spm_as_n,
        if_spm_rw,
        if_spm_wr_data,
        if_spm_rd_data,

        /*  Port B / MEM  */
        mem_spm_addr,
        mem_spm_as_n,
        mem_spm_rw,
        mem_spm_wr_data,
        mem_spm_rd_data
    );

    /*  clock  */
    always
        #10 clk = ~clk;

    integer i;
    
    /*  testbench  */
    initial
    begin
        $dumpfile("cpu_spm.vcd");
        $dumpvars(0,cpu_spm_tb);
        
        /*  set rom data to zero  */
        for(i=0;i<`SPM_DEPTH;i=i+1)
        begin
            cpu_spm_01.dpram_01.ram_block[i] = 0;
        end

        // mem port read addr 0
        #40 mem_spm_addr = 0;
        mem_spm_as_n = `ENABLE_;
        mem_spm_rw = `READ;
        // if port write addr 0
        #50 if_spm_addr = 0;
        if_spm_wr_data = `WORD_DATA_WIDTH'h1234;
        #50 if_spm_rw = `WRITE;
        #50 if_spm_as_n = `ENABLE_;
        // if port read addr 1
        #50 if_spm_as_n = `DISABLE_;
        #50 if_spm_rw = `READ;
        if_spm_addr = 1;
        // mem port write addr 1
        #50 mem_spm_addr = 1;
        mem_spm_wr_data = `WORD_DATA_WIDTH'habcd;
        #50 mem_spm_rw = `WRITE;

        #100 $finish;
    end

endmodule // cpu_spm_tb