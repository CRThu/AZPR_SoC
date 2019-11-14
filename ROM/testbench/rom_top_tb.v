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
    reg [`ROM_ADDR_BUS] addr = 0;
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

    integer i;
    
    /*  testbench  */
    initial
    begin
        $dumpfile("rom_top.vcd");
        $dumpvars(0,rom_top_tb);
        
        /*  set rom data to zero  */
        for(i=0;i<`ROM_DEPTH;i=i+1)
        begin
            rom_top_01.sprom_01.rom_block[i] = 0;
        end

        /*  load data  */
        $readmemh("./rom_tb.dat",rom_top_01.sprom_01.rom_block);


        for(i=0;i<11;i=i+1)
        begin
            $display("addr = 0x%h,\tdata = 0x%h;",i,rom_top_01.sprom_01.rom_block[i]);
        end

        #50 reset = `RESET_DISABLE;
        cs_n  = `ENABLE_;
        as_n = `ENABLE_;
        
        while(addr<10)
            #50 addr=addr+1;

        #100 $finish;
    end

endmodule // rom_top_tb