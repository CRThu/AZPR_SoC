`timescale 1ns/100ps

`include "./Bus/bus_addr_dec.v"
`include "./Global/global_std_def.v"

module bus_addr_dec_tb;

    /*  shared address bus  */
    reg [`WORD_ADDR_BUS] s_addr;
    /*  chip select  */
    wire s0_cs_n;
    wire s1_cs_n;
    wire s2_cs_n;
    wire s3_cs_n;
    wire s4_cs_n;
    wire s5_cs_n;
    wire s6_cs_n;
    wire s7_cs_;

    bus_addr_dec bus_addr_dec_01(
        /*  shared address bus  */
        s_addr,

        /*  chip select  */
        s0_cs_n,
        s1_cs_n,
        s2_cs_n,
        s3_cs_n,
        s4_cs_n,
        s5_cs_n,
        s6_cs_n,
        s7_cs_n
    );


    /*  testbench  */
    initial
    begin
        $dumpfile("bus_addr_dec.vcd");
        $dumpvars(0,bus_addr_dec_tb);

        s_addr = `WORD_ADDR_WIDTH'h0000_0000;
        while (s_addr != `WORD_ADDR_WIDTH'h3F00_0000)
        begin
            #10 s_addr = s_addr + `WORD_ADDR_WIDTH'h0100_0000;
        end

        #100 $finish;
    end

endmodule // bus_addr_dec_tb