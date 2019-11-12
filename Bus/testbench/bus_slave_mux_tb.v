`timescale 1ns/100ps

`include "./Bus/bus_slave_mux.v"
`include "./Global/global_std_def.v"

module bus_slave_mux_tb;

    /*  slave 0  */
    reg s0_cs_n = `DISABLE_;
    reg [`WORD_DATA_BUS] s0_rd_data=`WORD_DATA_WIDTH'h0123;
    reg s0_rdy_n = `DISABLE_;
    /*  slave 1  */
    reg s1_cs_n = `DISABLE_;
    reg [`WORD_DATA_BUS] s1_rd_data=`WORD_DATA_WIDTH'h1234;
    reg s1_rdy_n = `ENABLE_;
    /*  slave 2  */
    reg s2_cs_n = `DISABLE_;
    reg [`WORD_DATA_BUS] s2_rd_data=`WORD_DATA_WIDTH'h2345;
    reg s2_rdy_n = `DISABLE_;
    /*  slave 3  */
    reg s3_cs_n = `DISABLE_;
    reg [`WORD_DATA_BUS] s3_rd_data=`WORD_DATA_WIDTH'h3456;
    reg s3_rdy_n = `ENABLE_;
    /*  slave 4  */
    reg s4_cs_n = `DISABLE_;
    reg [`WORD_DATA_BUS] s4_rd_data=`WORD_DATA_WIDTH'h4567;
    reg s4_rdy_n = `DISABLE_;
    /*  slave 5  */
    reg s5_cs_n = `DISABLE_;
    reg [`WORD_DATA_BUS] s5_rd_data=`WORD_DATA_WIDTH'h5678;
    reg s5_rdy_n = `ENABLE_;
    /*  slave 6  */
    reg s6_cs_n = `DISABLE_;
    reg [`WORD_DATA_BUS] s6_rd_data=`WORD_DATA_WIDTH'h6789;
    reg s6_rdy_n = `DISABLE_;
    /*  slave 7  */
    reg s7_cs_n = `DISABLE_;
    reg [`WORD_DATA_BUS] s7_rd_data=`WORD_DATA_WIDTH'h7890;
    reg s7_rdy_n = `ENABLE_;

    /*  master signal  */
    wire [`WORD_DATA_BUS] m_rd_data;
    wire m_rdy_n;
    
    bus_slave_mux bus_slave_mux_01(
        /*  slave 0  */
        s0_cs_n,
        s0_rd_data,
        s0_rdy_n,
        /*  slave 1  */
        s1_cs_n,
        s1_rd_data,
        s1_rdy_n,
        /*  slave 2  */
        s2_cs_n,
        s2_rd_data,
        s2_rdy_n,
        /*  slave 3  */
        s3_cs_n,
        s3_rd_data,
        s3_rdy_n,
        /*  slave 4  */
        s4_cs_n,
        s4_rd_data,
        s4_rdy_n,
        /*  slave 5  */
        s5_cs_n,
        s5_rd_data,
        s5_rdy_n,
        /*  slave 6  */
        s6_cs_n,
        s6_rd_data,
        s6_rdy_n,
        /*  slave 7  */
        s7_cs_n,
        s7_rd_data,
        s7_rdy_n,
        
        /*  master signal  */
        m_rd_data,
        m_rdy_n
    );

    /*  testbench  */
    initial
    begin
        $dumpfile("bus_slave_mux.vcd");
        $dumpvars(0,bus_slave_mux_tb);

        // s0
        #50 s0_cs_n = `ENABLE_;
        // s1
        #50 s0_cs_n = `DISABLE_;
        #50 s1_cs_n = `ENABLE_;
        // s2
        #50 s1_cs_n = `DISABLE_;
        #50 s2_cs_n = `ENABLE_;
        // s3
        #50 s2_cs_n = `DISABLE_;
        #50 s3_cs_n = `ENABLE_;
        // s4
        #50 s3_cs_n = `DISABLE_;
        #50 s4_cs_n = `ENABLE_;
        // s5
        #50 s4_cs_n = `DISABLE_;
        #50 s5_cs_n = `ENABLE_;
        // s6
        #50 s5_cs_n = `DISABLE_;
        #50 s6_cs_n = `ENABLE_;
        // s7
        #50 s6_cs_n = `DISABLE_;
        #50 s7_cs_n = `ENABLE_;
        // free
        #50 s7_cs_n = `DISABLE_;

        #100 $finish;
    end

endmodule // bus_slave_mux_tb