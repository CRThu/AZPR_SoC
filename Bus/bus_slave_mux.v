`include "./Bus/bus_def.v"
`include "./Global/global_std_def.v"

module bus_slave_mux(
    /*  slave 0  */
    input wire s0_cs_n,
    input wire [`WORD_DATA_BUS] s0_rd_data,
    input wire s0_rdy_n,
    /*  slave 1  */
    input wire s1_cs_n,
    input wire [`WORD_DATA_BUS] s1_rd_data,
    input wire s1_rdy_n,
    /*  slave 2  */
    input wire s2_cs_n,
    input wire [`WORD_DATA_BUS] s2_rd_data,
    input wire s2_rdy_n,
    /*  slave 3  */
    input wire s3_cs_n,
    input wire [`WORD_DATA_BUS] s3_rd_data,
    input wire s3_rdy_n,
    /*  slave 4  */
    input wire s4_cs_n,
    input wire [`WORD_DATA_BUS] s4_rd_data,
    input wire s4_rdy_n,
    /*  slave 5  */
    input wire s5_cs_n,
    input wire [`WORD_DATA_BUS] s5_rd_data,
    input wire s5_rdy_n,
    /*  slave 6  */
    input wire s6_cs_n,
    input wire [`WORD_DATA_BUS] s6_rd_data,
    input wire s6_rdy_n,
    /*  slave 7  */
    input wire s7_cs_n,
    input wire [`WORD_DATA_BUS] s7_rd_data,
    input wire s7_rdy_n,

    /*  master signal  */
    output reg [`WORD_DATA_BUS] m_rd_data,
    output reg m_rdy_n
);

    always @(*)
    begin
        if (s0_cs_n == `ENABLE_)
        begin
           m_rd_data = s0_rd_data;
           m_rdy_n = s0_rdy_n;
        end
        else if (s1_cs_n == `ENABLE_)
        begin
           m_rd_data = s1_rd_data;
           m_rdy_n = s1_rdy_n;
        end
        else if (s2_cs_n == `ENABLE_)
        begin
           m_rd_data = s2_rd_data;
           m_rdy_n = s2_rdy_n;
        end
        else if (s3_cs_n == `ENABLE_)
        begin
           m_rd_data = s3_rd_data;
           m_rdy_n = s3_rdy_n;
        end
        else if (s4_cs_n == `ENABLE_)
        begin
           m_rd_data = s4_rd_data;
           m_rdy_n = s4_rdy_n;
        end
        else if (s5_cs_n == `ENABLE_)
        begin
           m_rd_data = s5_rd_data;
           m_rdy_n = s5_rdy_n;
        end
        else if (s6_cs_n == `ENABLE_)
        begin
           m_rd_data = s6_rd_data;
           m_rdy_n = s6_rdy_n;
        end
        else if (s7_cs_n == `ENABLE_)
        begin
           m_rd_data = s7_rd_data;
           m_rdy_n = s7_rdy_n;
        end
        else
        begin
            m_rd_data = `WORD_DATA_WIDTH'h0;
            m_rdy_n = `DISABLE_;
        end
    end

endmodule // bus_slave_mux