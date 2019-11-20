`timescale 1ns/100ps

`include "./CPU/cpu_bus_if.v"
`include "./Global/global_std_def.v"
`include "./Global/global_cfg_def.v"

module cpu_bus_if_tb;

    /*  clk & reset  */
    reg clk=0;
    reg reset=1;

    /*  pipeline control signal  */
    reg stall=0;
    reg flush=0;
    wire busy;

    /*  cpu interface  */
    reg [`WORD_ADDR_BUS] addr;
    reg as_n=`DISABLE_;
    reg rw=`READ;
    reg [`WORD_DATA_BUS] wr_data=`WORD_DATA_WIDTH'h123456;
    wire [`WORD_DATA_BUS] rd_data;

    /*  spm interface  */
    wire [`WORD_ADDR_BUS] spm_addr;
    wire spm_as_n;
    wire spm_rw;
    reg [`WORD_DATA_BUS] spm_rd_data=`WORD_DATA_WIDTH'h234567;
    wire [`WORD_DATA_BUS] spm_wr_data;

    /*  bus interface / control  */
    reg bus_rdy_n=`DISABLE_;
    reg bus_grnt_n=`DISABLE_;
    wire bus_req_n;

    /*  bus interface / data  */
    wire [`WORD_ADDR_BUS] bus_addr;
    wire bus_as_n;
    wire bus_rw;
    reg [`WORD_DATA_BUS] bus_rd_data=`WORD_DATA_WIDTH'h345678;
    wire [`WORD_DATA_BUS] bus_wr_data;


    cpu_bus_if cpu_bus_if_01(
        /*  clk & reset  */
        clk,
        reset,
        
        /*  pipeline control signal  */
        stall,
        flush,
        busy,

        /*  cpu interface  */
        addr,
        as_n,
        rw,
        wr_data,
        rd_data,

        /*  spm interface  */
        spm_addr,
        spm_as_n,
        spm_rw,
        spm_rd_data,
        spm_wr_data,

        /*  bus interface / control  */
        bus_rdy_n,
        bus_grnt_n,
        bus_req_n,

        /*  bus interface / data  */
        bus_addr,
        bus_as_n,
        bus_rw,
        bus_rd_data,
        bus_wr_data
    );

    /*  clock  */
    always
        #10 clk = ~clk;


    /*  testbench  */
    initial
    begin
        $dumpfile("cpu_bus_if.vcd");
        $dumpvars(0,cpu_bus_if_tb);
        
        #40 reset=0;
        #40 reset=1;

        #40 addr = {3'b001,27'h0};
        #40 as_n = `ENABLE_;
        flush = `DISABLE;
        #40 addr = {3'b010,27'h1234};

        #40 bus_grnt_n = `ENABLE_;
        #40 bus_rdy_n = `ENABLE_;
        stall = `ENABLE;

        #40 stall = `DISABLE;

        #100 $finish;
    end



endmodule // cpu_bus_if_tb