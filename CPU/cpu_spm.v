`include "./CPU/cpu_spm_def.v"
`include "./IP/cpu_spm_dpram.v"
`include "./Global/global_cfg_def.v"
`include "./Global/global_std_def.v"

/*  Scratch Pad Memory  */
module cpu_spm(
    /*  clock  */
    input wire clk,

    /*  Port A / IF  */
    input wire [`SPM_ADDR_BUS] if_spm_addr,
    input wire if_spm_as_n,
    input wire if_spm_rw,
    input wire [`WORD_DATA_BUS] if_spm_wr_data,
    output wire [`WORD_DATA_BUS] if_spm_rd_data,

    /*  Port B / MEM  */
    input wire [`SPM_ADDR_BUS] mem_spm_addr,
    input wire mem_spm_as_n,
    input wire mem_spm_rw,
    input wire [`WORD_DATA_BUS] mem_spm_wr_data,
    output wire [`WORD_DATA_BUS] mem_spm_rd_data
);
    /*  Write Enable  */
    reg wea,web;

    /*  Generate Write Enable Signal */
    always @(*)
    begin
        /*  Port A  */
        if ((if_spm_as_n == `ENABLE_) && (if_spm_rw == `WRITE))
        begin
            wea = `MEM_ENABLE;  // Memory Write Enable
        end
        else
        begin
            wea = `MEM_DISABLE;  // Memory Write Disable
        end

        /*  Port B  */
        if ((mem_spm_as_n == `ENABLE_) && (mem_spm_rw == `WRITE))
        begin
            web = `MEM_ENABLE;  // Memory Write Enable
        end
        else
        begin
            web = `MEM_DISABLE;  // Memory Write Disable
        end
    end

    /*  Dual Port RAM  */
    cpu_spm_dpram dpram_01(
        /*  Port A / IF  */
        .clka   (clk),
        .addra  (if_spm_addr),
        .dina   (if_spm_wr_data),
        .wea    (wea),
        .douta  (if_spm_rd_data),

        /*  Port B / MEM  */
        .clkb   (clk),
        .addrb  (mem_spm_addr),
        .dinb   (mem_spm_wr_data),
        .web    (web),
        .doutb  (mem_spm_rd_data)
    );

endmodule // cpu_spm