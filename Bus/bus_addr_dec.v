`include "./Bus/bus_def.v"
`include "./Global/global_std_def.v"

// book is wrong??? (p74,table:1-19,address)

module bus_addr_dec(
    /*  shared address bus  */
    input wire [`WORD_ADDR_BUS] s_addr,

    /*  chip select  */
    output reg s0_cs_n,
    output reg s1_cs_n,
    output reg s2_cs_n,
    output reg s3_cs_n,
    output reg s4_cs_n,
    output reg s5_cs_n,
    output reg s6_cs_n,
    output reg s7_cs_n
);
    /*  address index  */
    wire [`BUS_SLAVE_INDEX_BUS] s_index;

    assign s_index = s_addr[`BUS_SLAVE_INDEX_LOC];

    always @(*)
    begin
    
        s0_cs_n = `DISABLE_;
        s1_cs_n = `DISABLE_;
        s2_cs_n = `DISABLE_;
        s3_cs_n = `DISABLE_;
        s4_cs_n = `DISABLE_;
        s5_cs_n = `DISABLE_;
        s6_cs_n = `DISABLE_;
        s7_cs_n = `DISABLE_;

        case(s_index)
            `BUS_SLAVE_0: begin s0_cs_n = `ENABLE_; end
            `BUS_SLAVE_1: begin s1_cs_n = `ENABLE_; end
            `BUS_SLAVE_2: begin s2_cs_n = `ENABLE_; end
            `BUS_SLAVE_3: begin s3_cs_n = `ENABLE_; end
            `BUS_SLAVE_4: begin s4_cs_n = `ENABLE_; end
            `BUS_SLAVE_5: begin s5_cs_n = `ENABLE_; end
            `BUS_SLAVE_6: begin s6_cs_n = `ENABLE_; end
            `BUS_SLAVE_7: begin s7_cs_n = `ENABLE_; end
        endcase
    end

endmodule // bus_addr_dec