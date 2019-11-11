`include "./Bus/bus_def.v"
`include "./Global/global_std_def.v"
`include "./Global/global_cfg_def.v"

module bus_master_mux(
    /*  master 0  */
    input wire [`WORD_ADDR_BUS] m0_addr,
    input wire m0_as_n,
    input wire m0_rw,
    input wire [`WORD_DATA_BUS] m0_wr_data,
    input wire m0_grnt_n,

    /*  master 1  */
    input wire [`WORD_ADDR_BUS] m1_addr,
    input wire m1_as_n,
    input wire m1_rw,
    input wire [`WORD_DATA_BUS] m1_wr_data,
    input wire m1_grnt_n,

    /*  master 2  */
    input wire [`WORD_ADDR_BUS] m2_addr,
    input wire m2_as_n,
    input wire m2_rw,
    input wire [`WORD_DATA_BUS] m2_wr_data,
    input wire m2_grnt_n,

    /*  master 3  */
    input wire [`WORD_ADDR_BUS] m3_addr,
    input wire m3_as_n,
    input wire m3_rw,
    input wire [`WORD_DATA_BUS] m3_wr_data,
    input wire m3_grnt_n,

    /*  shared signal  */
    output reg [`WORD_ADDR_BUS] s_addr,
    output reg s_as_n,
    output reg s_rw,
    output reg [`WORD_DATA_BUS] s_wr_data
);




endmodule // bus_master_mux