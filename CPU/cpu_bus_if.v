`include "./CPU/cpu_spm_def.v"
`include "./IP/cpu_spm_dpram.v"
`include "./Global/global_std_def.v"
`include "./Global/global_cfg_def.v"
`include "./Bus/bus_def.v"
`include "./CPU/cpu_def.v"

// book is wrong??? (p112-wire->reg)
module cpu_bus_if(
    /*  clk & reset  */
    input wire clk,
    input wire reset,

    /*  pipeline control signal  */
    input wire stall,
    input wire flush,
    output reg busy,

    /*  cpu interface  */
    input wire [`WORD_ADDR_BUS] addr,
    input wire as_n,
    input wire rw,
    input wire [`WORD_DATA_BUS] wr_data,
    output reg [`WORD_DATA_BUS] rd_data,

    /*  spm interface  */
    output wire [`WORD_ADDR_BUS] spm_addr,
    output reg spm_as_n,
    output wire spm_rw,
    input wire [`WORD_DATA_BUS] spm_rd_data,
    output wire [`WORD_DATA_BUS] spm_wr_data,

    /*  bus interface / control  */
    input wire bus_rdy_n,
    input wire bus_grnt_n,
    output reg bus_req_n,

    /*  bus interface / data  */
    output reg [`WORD_ADDR_BUS] bus_addr,
    output reg bus_as_n,
    output reg bus_rw,
    input wire [`WORD_DATA_BUS] bus_rd_data,
    output reg [`WORD_DATA_BUS] bus_wr_data
);

    reg [1:0] state;
    reg [31:0] rd_buf;  /*  read buffer  */
    wire [2:0] s_index; /*  bus slave index  */

    /*  SPM Control  */
    /*  Bus Slave Index  */
    assign s_index = addr[`BUS_SLAVE_INDEX_LOC];
    /*  output wire  */
    assign spm_addr = addr;
    assign spm_rw = rw;
    assign spm_wr_data = wr_data;
    
    /*  SPM Access Control  */
    always @(*)
    begin
        /*  default  */
        rd_data = `WORD_DATA_WIDTH'h0;
        spm_as_n = `DISABLE_;
        busy = `DISABLE;
        /*  bus status  */
        case(state)
            `BUS_IF_STATE_IDLE : /*  IDLE  */
            begin
                /*  SPM Access  */
                if((flush == `DISABLE) && (as_n == `ENABLE_))
                begin
                    /*  Access SPM  */
                    if(s_index == `BUS_SLAVE_1)
                    begin
                        if(stall == `DISABLE)   // Detect for stall
                        begin
                            spm_as_n = `ENABLE_;
                            if(rw == `READ) // Read Access
                            begin
                                rd_data = spm_rd_data;
                            end
                        end
                    end
                    else
                    begin
                        /*  Access Bus  */
                        busy = `ENABLE;
                    end
                end
            end
            `BUS_IF_STATE_REQ : /*  Request Bus  */
            begin
                busy = `ENABLE;
            end
            `BUS_IF_STATE_ACCESS :
            begin
                /*  Wait for Ready  */
                if(bus_rdy_n == `ENABLE_)   // Wait for Ready
                begin
                    if(rw == `READ) // Read Access
                    begin
                        rd_data = bus_rd_data;
                    end
                end
                else
                begin
                    // no Ready Signal
                    busy = `ENABLE;
                end
            end
            `BUS_IF_STATE_STALL : // Stall
            begin
                if(rw == `READ) // Read Accesss
                begin
                    rd_data = rd_buf;
                end
            end
        endcase
    end

    /*  Bus Control  */
    always @(posedge clk or `RESET_EDGE reset)
    begin
        if(reset == `RESET_ENABLE)
        begin
            /*  reset  */
            state       <= #1 `BUS_IF_STATE_IDLE;
            bus_req_n   <= #1 `DISABLE_;
            bus_addr    <= #1 `WORD_ADDR_WIDTH'h0;
            bus_as_n    <= #1 `DISABLE_;
            bus_rw      <= #1 `READ;
            bus_wr_data <= #1 `WORD_DATA_WIDTH'h0;
            rd_buf      <= #1 `WORD_DATA_WIDTH'h0;
        end
        else
        begin
            /*  bus state  */
            case(state)
                `BUS_IF_STATE_IDLE : // idle
                begin
                    /*  SPM Access  */
                    if((flush ==  `DISABLE) && (as_n ==`ENABLE_))
                    begin
                        /*  Choose Access Object  */
                        if(s_index != `BUS_SLAVE_1)
                        begin
                            /*  Access Bus  */
                            state       <= #1 `BUS_IF_STATE_REQ;
                            bus_req_n   <= #1 `ENABLE_;
                            bus_addr    <= #1 addr;
                            bus_rw      <= #1 rw;
                            bus_wr_data <= #1 wr_data;
                        end
                    end 
                end
                `BUS_IF_STATE_REQ : // Request Bus
                begin
                    /*  Wait for Bus Granted  */
                    if(bus_grnt_n == `ENABLE_)
                    begin
                        state       <= #1 `BUS_IF_STATE_ACCESS;
                        bus_as_n    <= #1 `ENABLE_;
                    end
                end
                `BUS_IF_STATE_ACCESS : // Access Bus
                begin
                    bus_as_n    <= #1 `DISABLE_;
                    /*  Wait for Ready  */
                    if(bus_rdy_n == `ENABLE_)
                    begin
                        bus_req_n   <= #1 `DISABLE_;
                        bus_addr    <= #1 `WORD_ADDR_WIDTH'h0;
                        bus_rw      <= #1 `READ;
                        bus_wr_data <= #1 `WORD_DATA_WIDTH'h0;
                        /*  Save Read Data  */
                        if(bus_rw == `READ)
                        begin
                            rd_buf  <= #1 bus_rd_data;
                        end
                        /*  Detect Stall  */
                        if(stall == `ENABLE)
                        begin
                            /*  stall  */
                            state   <= #1 `BUS_IF_STATE_STALL;
                        end
                        else
                        begin
                            /*  not stall  */
                            state   <= #1 `BUS_IF_STATE_IDLE;
                        end
                    end
                end
                `BUS_IF_STATE_STALL : // Stall
                begin
                    /*  Detect Stall  */
                    if(stall == `DISABLE)
                    begin
                        state   <= #1 `BUS_IF_STATE_IDLE;
                    end
                end
            endcase
        end
    end
endmodule // bus_if