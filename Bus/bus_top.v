`include "./Bus/bus_def.v"
`include "./Global/global_std_def.v"

`include "./Bus/bus_arbiter.v"
`include "./Bus/bus_master_mux.v"
`include "./Bus/bus_addr_dec.v"
`include "./Bus/bus_slave_mux.v"

module bus_top(
    /*  clock & reset  */
    input wire clk,
    input wire reset,

    /*  master 0-3  */
    input wire m0_req_n,
    output wire m0_grnt_n,
    input wire [`WORD_ADDR_BUS] m0_addr,
    input wire m0_as_n,
    input wire m0_rw,
    input wire [`WORD_DATA_BUS] m0_wr_data,

    input wire m1_req_n,
    output wire m1_grnt_n,
    input wire [`WORD_ADDR_BUS] m1_addr,
    input wire m1_as_n,
    input wire m1_rw,
    input wire [`WORD_DATA_BUS] m1_wr_data,

    input wire m2_req_n,
    output wire m2_grnt_n,
    input wire [`WORD_ADDR_BUS] m2_addr,
    input wire m2_as_n,
    input wire m2_rw,
    input wire [`WORD_DATA_BUS] m2_wr_data,

    input wire m3_req_n,
    output wire m3_grnt_n,
    input wire [`WORD_ADDR_BUS] m3_addr,
    input wire m3_as_n,
    input wire m3_rw,
    input wire [`WORD_DATA_BUS] m3_wr_data,

    /*  master shared signal  */
    output wire [`WORD_DATA_BUS] m_rd_data,
    output wire m_rdy_n,

    /*  slave 0-7  */
    input wire s0_cs_n,
    input wire [`WORD_DATA_BUS] s0_rd_data,
    input wire s0_rdy_n,

    input wire s1_cs_n,
    input wire [`WORD_DATA_BUS] s1_rd_data,
    input wire s1_rdy_n,

    input wire s2_cs_n,
    input wire [`WORD_DATA_BUS] s2_rd_data,
    input wire s2_rdy_n,
    
    input wire s3_cs_n,
    input wire [`WORD_DATA_BUS] s3_rd_data,
    input wire s3_rdy_n,
    
    input wire s4_cs_n,
    input wire [`WORD_DATA_BUS] s4_rd_data,
    input wire s4_rdy_n,
    
    input wire s5_cs_n,
    input wire [`WORD_DATA_BUS] s5_rd_data,
    input wire s5_rdy_n,
    
    input wire s6_cs_n,
    input wire [`WORD_DATA_BUS] s6_rd_data,
    input wire s6_rdy_n,
    
    input wire s7_cs_n,
    input wire [`WORD_DATA_BUS] s7_rd_data,
    input wire s7_rdy_n,

    /*  slave shared signal  */
    output wire [`WORD_ADDR_BUS] s_addr,
    output wire s_as_n,
    output wire s_rw,
    output wire [`WORD_DATA_BUS] s_wr_data
);

    bus_arbiter bus_arbiter_01(
        clk,
        reset,
        m0_req_n,
        m0_grnt_n,
        m1_req_n,
        m1_grnt_n,
        m2_req_n,
        m2_grnt_n,
        m3_req_n,
        m3_grnt_n
    );

    bus_master_mux bus_master_mux_01(
        m0_addr,
        m0_as_n,
        m0_rw,
        m0_wr_data,
        m0_grnt_n,
        m1_addr,
        m1_as_n,
        m1_rw,
        m1_wr_data,
        m1_grnt_n,
        m2_addr,
        m2_as_n,
        m2_rw,
        m2_wr_data,
        m2_grnt_n,
        m3_addr,
        m3_as_n,
        m3_rw,
        m3_wr_data,
        m3_grnt_n,
        s_addr,
        s_as_n,
        s_rw,
        s_wr_data
    );

    bus_addr_dec bus_addr_dec_01(
        s_addr,
        s0_cs_n,
        s1_cs_n,
        s2_cs_n,
        s3_cs_n,
        s4_cs_n,
        s5_cs_n,
        s6_cs_n,
        s7_cs_n
    );

    bus_slave_mux bus_slave_mux_01(
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
        m_rd_data,
        m_rdy_n
    );

endmodule // bus_top