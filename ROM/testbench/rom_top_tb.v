`timescale 1ns/100ps

`include "./ROM/rom_top.v"
`include "./Global/global_std_def.v"

module rom_top_tb;

    /*  clock & reset  */
    reg clk = `LOW;
    reg reset = `RESET_ENABLE;

    /*  bus  */
    reg cs_n = `DISABLE_;
    reg as_n = `DISABLE_;
    reg [`ROM_ADDR_BUS] addr=0;
    wire [`WORD_DATA_BUS] rd_data;
    wire rdy_n;

    rom_top rom_top_01(
        /*  clock & reset  */
        clk,
        reset,

        /*  bus  */
        cs_n,
        as_n,
        addr,
        rd_data,
        rdy_n
    );


    /*  clock  */
    always
        #10 clk = ~clk;

    /*  testbench  */
    initial
    begin
        $dumpfile("rom_top.vcd");
        $dumpvars(0,rom_top_tb);
        
        #50 reset = `RESET_DISABLE;
        cs_n  = `ENABLE_;
        as_n = `ENABLE_;
        
        while(addr<10)
            #50 addr=addr+1;

        #100 $finish;
    end

endmodule // rom_top_tb