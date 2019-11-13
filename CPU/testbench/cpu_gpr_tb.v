`timescale 1ns/100ps

`include "./CPU/cpu_gpr.v"
`include "./Global/global_std_def.v"


module cpu_gpr_tb;

    /*  clk & reset  */
    reg clk = `LOW;
    reg reset = `RESET_ENABLE;

    /*  read port 0-1  */
    reg [`REG_ADDR_BUS] rd_addr_0;
    wire [`WORD_DATA_BUS] rd_data_0;

    reg [`REG_ADDR_BUS] rd_addr_1;
    wire [`WORD_DATA_BUS] rd_data_1;

    /*  write port  */
    reg we_n = `DISABLE_;
    reg [`REG_ADDR_BUS] wr_addr;
    reg [`WORD_DATA_BUS] wr_data;


    /*  Instance  */
    cpu_gpr cpu_gpr_01(
        /*  clk & reset  */
        clk,
        reset,

        /*  read port 0-1  */
        rd_addr_0,
        rd_data_0,
    
        rd_addr_1,
        rd_data_1,

        /*  write port  */
        we_n,
        wr_addr,
        wr_data
    );

    /*  clock  */
    always
        #10 clk = ~clk;

    /*  testbench  */
    initial
    begin
        $dumpfile("cpu_gpr.vcd");
        $dumpvars(0,cpu_gpr_tb);
        
        #50 reset = `RESET_DISABLE;
        
        // test we_n
        #50 wr_addr = `REG_ADDR_WIDTH'h0;
        wr_data = `WORD_DATA_WIDTH'hAAAA;
        we_n = `DISABLE_;
        rd_addr_0 = `REG_ADDR_WIDTH'h0;

        // write + read0
        #50 wr_addr = `REG_ADDR_WIDTH'h1;
        wr_data = `WORD_DATA_WIDTH'h1234;
        we_n = `ENABLE_;

        #50 rd_addr_0 = `REG_ADDR_WIDTH'h1;
        #50 we_n = `DISABLE_;

        // write + read1
        #50 wr_addr = `REG_ADDR_WIDTH'h2;
        wr_data = `WORD_DATA_WIDTH'h5678;
        we_n = `ENABLE_;

        #50 we_n = `DISABLE_;
        #50 rd_addr_1 = `REG_ADDR_WIDTH'h2;

        // test reset
        #50 reset = `RESET_ENABLE;
        #50 reset = `RESET_DISABLE;

        #50 rd_addr_0 = `REG_ADDR_WIDTH'h2;
        rd_addr_1 = `REG_ADDR_WIDTH'h1;


        #100 $finish;
    end

endmodule // cpu_gpr_tb