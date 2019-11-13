`include "./CPU/cpu_def.v"
`include "./Global/global_cfg_def.v"
`include "./Global/global_std_def.v"

/*  General Register  */
module cpu_gpr(
    /*  clk & reset  */
    input wire clk,
    input wire reset,

    /*  read port 0-1  */
    input wire [`REG_ADDR_BUS] rd_addr_0,
    output wire [`WORD_DATA_BUS] rd_data_0,
    
    input wire [`REG_ADDR_BUS] rd_addr_1,
    output wire [`WORD_DATA_BUS] rd_data_1,

    /*  write port  */
    input wire we_n,
    input wire [`REG_ADDR_BUS] wr_addr,     //book is wrong???
    input wire [`WORD_DATA_BUS] wr_data
);

    reg [`WORD_DATA_BUS] gpr [(`REG_NUM-1):0];
    integer i;

    /*  Write After Read  */
    /*  Read  */
    assign rd_data_0 = ((we_n == `ENABLE_) && (wr_addr == rd_addr_0)) ? wr_data : gpr[rd_addr_0];
    assign rd_data_1 = ((we_n == `ENABLE_) && (wr_addr == rd_addr_1)) ? wr_data : gpr[rd_addr_1];

    /*  Write  */
    always @(posedge clk or `RESET_EDGE reset)
    begin
        if(reset == `RESET_ENABLE)
        begin
            /*  Reset  */
            for(i=0; i<`REG_NUM; i=i+1)
            begin
                gpr[i] <= #1 `WORD_DATA_WIDTH'h0;
            end
        end
        else
        begin
            /*  Write  */
            if(we_n == `ENABLE_)
            begin
                gpr[wr_addr] <= #1 wr_data;
            end
        end
    end

endmodule // cpu_gpr