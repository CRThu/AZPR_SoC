`include "./ROM/rom_def.v"
`include "./IP/rom_sprom.v"
`include "./Global/global_cfg_def.v"

module rom_top(
    /*  clock & reset  */
    input wire clk,
    input wire reset,

    /*  bus  */
    input wire cs_n,
    input wire as_n,
    input wire [`ROM_ADDR_BUS] addr,
    output wire [`WORD_DATA_BUS] rd_data,
    output reg rdy_n
);

    /*  Single Port ROM  */
    rom_sprom sprom_01(
        .clk    (clk),
        .addr   (addr),
        .dout   (rd_data)
    );

    always @(posedge clk or `RESET_EDGE reset) begin
        if(reset == `RESET_ENABLE)
        begin
            rdy_n <= #1 `DISABLE_;
        end
        else
        begin
            if((cs_n == `ENABLE_) && (as_n == `ENABLE_ ))
            begin
                rdy_n <= #1 `ENABLE_;
            end
            else
            begin
                rdy_n <= #1 `DISABLE_;
            end
        end
    end

endmodule // rom_top