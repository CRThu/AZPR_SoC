`include "./Bus/bus_def.v"
`include "./Global/global_std_def.v"

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

    /*  bus master mux  */
    always @(*)
    begin
        if (m0_grnt_n == `ENABLE_)
        begin
            /*  master 0 using bus  */
            s_addr      = m0_addr;
            s_as_n      = m0_as_n;
            s_rw        = m0_rw;
            s_wr_data   = m0_wr_data;
        end
        else if (m1_grnt_n == `ENABLE_)
        begin
            /*  master 1 using bus  */
            s_addr      = m1_addr;
            s_as_n      = m1_as_n;
            s_rw        = m1_rw;
            s_wr_data   = m1_wr_data;
        end
        else if (m2_grnt_n == `ENABLE_)
        begin
            /*  master 2 using bus  */
            s_addr      = m2_addr;
            s_as_n      = m2_as_n;
            s_rw        = m2_rw;
            s_wr_data   = m2_wr_data;
        end
        else if (m3_grnt_n == `ENABLE_)
        begin
            /*  master 3 using bus  */
            s_addr      = m3_addr;
            s_as_n      = m3_as_n;
            s_rw        = m3_rw;
            s_wr_data   = m3_wr_data;
        end
        else
        begin
            /*  default  */
            s_addr      = `WORD_ADDR_WIDTH'h0;
            s_as_n      = `DISABLE_;
            s_rw        = `READ;
            s_wr_data   = `WORD_DATA_WIDTH'h0;
        end
    end

endmodule // bus_master_mux