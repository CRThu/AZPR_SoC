`timescale 1ns/100ps

`include "./Bus/bus_arbiter.v"
`include "./Global/global_std_def.v"

module bus_arbiter_tb;

    /*  clock & reset  */
    reg clk = `LOW;
    reg reset = `RESET_ENABLE;

    /*  bus master's request & grant buses */
    reg m0_req_n = `DISABLE_;
    wire m0_grnt_n;

    reg m1_req_n = `DISABLE_;
    wire m1_grnt_n;

    reg m2_req_n = `DISABLE_;
    wire m2_grnt_n;
    
    reg m3_req_n = `DISABLE_;
    wire m3_grnt_n;

    /*  Instance  */
    bus_arbiter bus_arbiter_01(

        /*  clock & reset  */
        clk,
        reset,

        /*  bus master's request & grant buses */
        m0_req_n,
        m0_grnt_n,

        m1_req_n,
        m1_grnt_n,

        m2_req_n,
        m2_grnt_n,

        m3_req_n,
        m3_grnt_n
    );

    /*  clock  */
    always
        #10 clk = ~clk;

    /*  testbench  */
    initial
    begin
        $dumpfile("bus_arbiter.vcd");
        $dumpvars(0,bus_arbiter_tb);

        // test for reset
        #50 reset = `RESET_DISABLE;
        #50 m3_req_n = `ENABLE_;
        #50 reset = `RESET_ENABLE;
        #50 m3_req_n = `DISABLE_;
        #50 reset = `RESET_DISABLE;


        // m0 request usage of bus
        #100 m0_req_n = `ENABLE_;

        // when m0 using bus, m1 request
        #50 m1_req_n = `ENABLE_;

        // m0 request finished, m1 will use the bus
        #50 m0_req_n = `DISABLE_;

        // when m1 using, m2 & m3 request
        #30 m3_req_n = `ENABLE_;
        #30 m2_req_n = `ENABLE_;

        // m1 request finished, m2 will use the bus
        #30 m1_req_n = `DISABLE_;

        // m2 request finished, m3 will use the bus
        #50 m2_req_n = `DISABLE_;

        // m3 requested finished, bus is available
        #50 m3_req_n = `DISABLE_;

        #100 $finish;
    end

endmodule // bus_arbiter_tb
