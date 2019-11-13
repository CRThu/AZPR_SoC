`timescale 1ns/100ps

`include "./Bus/bus_top.v"
`include "./Global/global_std_def.v"

module bus_top_tb;

    /*  clock & reset  */
    reg clk = `LOW;
    reg reset = `RESET_DISABLE;

    /*  master 0-3  */
    reg m0_req_n = `DISABLE_;
    wire m0_grnt_n;
    reg [`WORD_ADDR_BUS] m0_addr;
    reg m0_as_n = `DISABLE_;
    reg m0_rw;
    reg [`WORD_DATA_BUS] m0_wr_data;

    reg m1_req_n = `DISABLE_;
    wire m1_grnt_n;
    reg [`WORD_ADDR_BUS] m1_addr;
    reg m1_as_n = `DISABLE_;
    reg m1_rw;
    reg [`WORD_DATA_BUS] m1_wr_data;

    reg m2_req_n = `DISABLE_;
    wire m2_grnt_n;
    reg [`WORD_ADDR_BUS] m2_addr;
    reg m2_as_n = `DISABLE_;
    reg m2_rw;
    reg [`WORD_DATA_BUS] m2_wr_data;

    reg m3_req_n = `DISABLE_;
    wire m3_grnt_n;
    reg [`WORD_ADDR_BUS] m3_addr;
    reg m3_as_n = `DISABLE_;
    reg m3_rw;
    reg [`WORD_DATA_BUS] m3_wr_data;

    /*  master shared signal  */
    wire [`WORD_DATA_BUS] m_rd_data;
    wire m_rdy_n;
    /*  slave 0-7  */
    wire s0_cs_n;
    reg [`WORD_DATA_BUS] s0_rd_data;
    reg s0_rdy_n = `DISABLE_;
    wire s1_cs_n;
    reg [`WORD_DATA_BUS] s1_rd_data;
    reg s1_rdy_n = `DISABLE_;
    wire s2_cs_n;
    reg [`WORD_DATA_BUS] s2_rd_data;
    reg s2_rdy_n = `DISABLE_;
    wire s3_cs_n;
    reg [`WORD_DATA_BUS] s3_rd_data;
    reg s3_rdy_n = `DISABLE_;
    wire s4_cs_n;
    reg [`WORD_DATA_BUS] s4_rd_data;
    reg s4_rdy_n = `DISABLE_;
    wire s5_cs_n;
    reg [`WORD_DATA_BUS] s5_rd_data;
    reg s5_rdy_n = `DISABLE_;
    wire s6_cs_n;
    reg [`WORD_DATA_BUS] s6_rd_data;
    reg s6_rdy_n = `DISABLE_;
    wire s7_cs_n;
    reg [`WORD_DATA_BUS] s7_rd_data;
    reg s7_rdy_n = `DISABLE_;
    /*  slave shared signal  */
    wire [`WORD_ADDR_BUS] s_addr;
    wire s_as_n;
    wire s_rw;
    wire [`WORD_DATA_BUS] s_wr_data;


    bus_top bus_top_01(
        /*  clock & reset  */
        clk,
        reset,

        /*  master 0-3  */
        m0_req_n,
        m0_grnt_n,
        m0_addr,
        m0_as_n,
        m0_rw,
        m0_wr_data,

        m1_req_n,
        m1_grnt_n,
        m1_addr,
        m1_as_n,
        m1_rw,
        m1_wr_data,

        m2_req_n,
        m2_grnt_n,
        m2_addr,
        m2_as_n,
        m2_rw,
        m2_wr_data,

        m3_req_n,
        m3_grnt_n,
        m3_addr,
        m3_as_n,
        m3_rw,
        m3_wr_data,

        /*  master shared signal  */
        m_rd_data,
        m_rdy_n,

        /*  slave 0-7  */
        s0_cs_n,
        s0_rd_data,
        s0_rdy_n,

        s1_cs_n,
        s1_rd_data,
        s1_rdy_n,

        s2_cs_n,
        s2_rd_data,
        s2_rdy_n,
        
        s3_cs_n,
        s3_rd_data,
        s3_rdy_n,
        
        s4_cs_n,
        s4_rd_data,
        s4_rdy_n,
        
        s5_cs_n,
        s5_rd_data,
        s5_rdy_n,
        
        s6_cs_n,
        s6_rd_data,
        s6_rdy_n,
        
        s7_cs_n,
        s7_rd_data,
        s7_rdy_n,

        /*  slave shared signal  */
        s_addr,
        s_as_n,
        s_rw,
        s_wr_data
    );


    /*  clock  */
    always
        #10 clk = ~clk;

    /*  testbench  */
    initial
    begin
        $dumpfile("bus_top.vcd");
        $dumpvars(0,bus_top_tb);

        // test for reset
        #50 reset = `RESET_ENABLE;
        #50 m3_req_n = `ENABLE_;
        #50 reset = `RESET_DISABLE;
        #50 m3_req_n = `DISABLE_;
        #50 reset = `RESET_ENABLE;


        // m0 request usage of bus
        #100 m0_req_n = `ENABLE_;
        m0_addr = `WORD_ADDR_WIDTH'h1000_0000;
        m0_as_n = `ENABLE_;
        m0_rw = `WRITE;
        m0_wr_data = `WORD_DATA_WIDTH'h1234;

        // when m0 using bus, m1 request
        #100 m0_as_n = `DISABLE_;
        
        m1_req_n = `ENABLE_;
        m1_addr = `WORD_ADDR_WIDTH'h3F00_0000;
        m1_as_n = `ENABLE_;
        m1_rw = `READ;
        s7_rd_data = `WORD_DATA_WIDTH'h5678;
        s7_rdy_n = `ENABLE_;

        

        // m0 request finished, m1 will use the bus
        #100 m1_as_n = `DISABLE_;
        s7_rdy_n = `DISABLE_;

        m0_req_n = `DISABLE_;

        // m1 request finished
        #100 m1_req_n = `DISABLE_;

        #100 $finish;
    end


endmodule // bus_top_tb