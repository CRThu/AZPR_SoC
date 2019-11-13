`include "./Bus/bus_def.v"
`include "./Global/global_std_def.v"
`include "./Global/global_cfg_def.v"

module bus_arbiter(
    /*  clock & reset  */
    input wire clk,
    input wire reset,

    /*  bus master's request & grant buses */
    input wire m0_req_n,
    output reg m0_grnt_n,

    input wire m1_req_n,
    output reg m1_grnt_n,

    input wire m2_req_n,
    output reg m2_grnt_n,
    
    input wire m3_req_n,
    output reg m3_grnt_n
);

    reg [`BUS_OWNER_BUS] owner;

    /*  grant usage of bus  */
    always@(*)
    begin
        m0_grnt_n = `DISABLE_;
        m1_grnt_n = `DISABLE_;
        m2_grnt_n = `DISABLE_;
        m3_grnt_n = `DISABLE_;
        case (owner)
            `BUS_OWNER_MASTER_0: begin m0_grnt_n = `ENABLE_; end
            `BUS_OWNER_MASTER_1: begin m1_grnt_n = `ENABLE_; end
            `BUS_OWNER_MASTER_2: begin m2_grnt_n = `ENABLE_; end
            `BUS_OWNER_MASTER_3: begin m3_grnt_n = `ENABLE_; end
        endcase
    end

    /*  arbiter of usage of bus  */
    always@(posedge clk or `RESET_EDGE reset)
    begin
        if (reset == `RESET_ENABLE)
        begin
            /*  reset  */
            owner <= #1 `BUS_OWNER_MASTER_0;
        end
        else
        begin
            /*  arbiter polling  */
            case (owner)
                `BUS_OWNER_MASTER_0:
                begin
                    if (m0_req_n == `ENABLE_)
                    begin
                        owner <= #1 `BUS_OWNER_MASTER_0;
                    end
                    else if(m1_req_n == `ENABLE_)
                    begin
                        owner <= #1 `BUS_OWNER_MASTER_1;
                    end
                    else if(m2_req_n == `ENABLE_)
                    begin
                        owner <= #1 `BUS_OWNER_MASTER_2;
                    end
                    else if(m3_req_n == `ENABLE_)
                    begin
                        owner <= #1 `BUS_OWNER_MASTER_3;
                    end
                end

                `BUS_OWNER_MASTER_1:
                begin
                    if (m1_req_n == `ENABLE_)
                    begin
                        owner <= #1 `BUS_OWNER_MASTER_1;
                    end
                    else if(m2_req_n == `ENABLE_)
                    begin
                        owner <= #1 `BUS_OWNER_MASTER_2;
                    end
                    else if(m3_req_n == `ENABLE_)
                    begin
                        owner <= #1 `BUS_OWNER_MASTER_3;
                    end
                    else if(m0_req_n == `ENABLE_)
                    begin
                        owner <= #1 `BUS_OWNER_MASTER_0;
                    end
                end

                `BUS_OWNER_MASTER_2:
                begin
                    if (m2_req_n == `ENABLE_)
                    begin
                        owner <= #1 `BUS_OWNER_MASTER_2;
                    end
                    else if(m3_req_n == `ENABLE_)
                    begin
                        owner <= #1 `BUS_OWNER_MASTER_3;
                    end
                    else if(m0_req_n == `ENABLE_)
                    begin
                        owner <= #1 `BUS_OWNER_MASTER_0;
                    end
                    else if(m1_req_n == `ENABLE_)
                    begin
                        owner <= #1 `BUS_OWNER_MASTER_1;
                    end
                end

                `BUS_OWNER_MASTER_3:
                begin
                    if (m3_req_n == `ENABLE_)
                    begin
                        owner <= #1 `BUS_OWNER_MASTER_3;
                    end
                    else if(m0_req_n == `ENABLE_)
                    begin
                        owner <= #1 `BUS_OWNER_MASTER_0;
                    end
                    else if(m1_req_n == `ENABLE_)
                    begin
                        owner <= #1 `BUS_OWNER_MASTER_1;
                    end
                    else if(m2_req_n == `ENABLE_)
                    begin
                        owner <= #1 `BUS_OWNER_MASTER_2;
                    end
                end
            endcase
        end

    end
endmodule // bus_arbiterf