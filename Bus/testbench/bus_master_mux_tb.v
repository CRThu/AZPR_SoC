`timescale 1ns/100ps

`include "./Bus/bus_master_mux.v"
`include "./Global/global_std_def.v"

module bus_master_mux_tb;

    /*  master 0  */
    reg [`WORD_ADDR_BUS] m0_addr = `WORD_ADDR_WIDTH'h12;
    reg m0_as_n = 1'b0;
    reg m0_rw = 1'b0;
    reg [`WORD_DATA_BUS] m0_wr_data = `WORD_DATA_WIDTH'h1234;
    reg m0_grnt_n = `DISABLE_;

    /*  master 1  */
    reg [`WORD_ADDR_BUS] m1_addr = `WORD_ADDR_WIDTH'h34;
    reg m1_as_n = 1'b0;
    reg m1_rw = 1'b1;
    reg [`WORD_DATA_BUS] m1_wr_data = `WORD_DATA_WIDTH'h3456;
    reg m1_grnt_n = `DISABLE_;

    /*  master 2  */
    reg [`WORD_ADDR_BUS] m2_addr = `WORD_ADDR_WIDTH'h56;
    reg m2_as_n = 1'b1;
    reg m2_rw = 1'b0;
    reg [`WORD_DATA_BUS] m2_wr_data = `WORD_DATA_WIDTH'h5678;
    reg m2_grnt_n = `DISABLE_;

    /*  master 3  */
    reg [`WORD_ADDR_BUS] m3_addr = `WORD_ADDR_WIDTH'h78;
    reg m3_as_n = 1'b1;
    reg m3_rw = 1'b1;
    reg [`WORD_DATA_BUS] m3_wr_data = `WORD_DATA_WIDTH'h7890;
    reg m3_grnt_n = `DISABLE_;

    /*  shared signal  */
    wire [`WORD_ADDR_BUS] s_addr;
    wire s_as_n;
    wire s_rw;
    wire [`WORD_DATA_BUS] s_wr_data;

    /*  Instance  */
    bus_master_mux bus_master_mux_01(
        /*  master 0  */
        m0_addr,
        m0_as_n,
        m0_rw,
        m0_wr_data,
        m0_grnt_n,

        /*  master 1  */
        m1_addr,
        m1_as_n,
        m1_rw,
        m1_wr_data,
        m1_grnt_n,

        /*  master 2  */
        m2_addr,
        m2_as_n,
        m2_rw,
        m2_wr_data,
        m2_grnt_n,

        /*  master 3  */
        m3_addr,
        m3_as_n,
        m3_rw,
        m3_wr_data,
        m3_grnt_n,

        /*  shared signal  */
        s_addr,
        s_as_n,
        s_rw,
        s_wr_data
    );

    /*  testbench  */
    initial
    begin
        $dumpfile("bus_master_mux.vcd");
        $dumpvars(0,bus_master_mux_tb);

        // m0
        #50 m0_grnt_n = `ENABLE_;
        // m1
        #50 m0_grnt_n = `DISABLE_;
        #50 m1_grnt_n = `ENABLE_;
        // m2
        #50 m1_grnt_n = `DISABLE_;
        #50 m2_grnt_n = `ENABLE_;
        // m3
        #50 m2_grnt_n = `DISABLE_;
        #50 m3_grnt_n = `ENABLE_;
        // free
        #50 m3_grnt_n = `DISABLE_;

        #100 $finish;
    end

endmodule // bus_master_mux_tb
