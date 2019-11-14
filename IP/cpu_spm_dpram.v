`include "./CPU/cpu_spm_def.v"
`include "./Global/global_std_def.v"

/*  Dual Port RAM  */
module cpu_spm_dpram(
    /*  Port A  */
    input wire clka,
    input wire [`SPM_ADDR_BUS] addra,
    input wire [`WORD_DATA_BUS] dina,
    input wire wea,
    output reg [`WORD_DATA_BUS] douta,

    /*  Port B  */
    input wire clkb,
    input wire [`SPM_ADDR_BUS] addrb,
    input wire [`WORD_DATA_BUS] dinb,
    input wire web,
    output reg [`WORD_DATA_BUS] doutb
);

    reg [`WORD_DATA_BUS] ram_block [`SPM_DEPTH-1:0];

    always @(posedge clka)
    begin
        /*  read  */
        douta <= ram_block[addra];

        /*  write  */
        if(wea == `ENABLE)
        begin
            ram_block[addra] <= dina;
        end
    end

    always @(posedge clkb)
    begin
        /*  read  */
        doutb <= ram_block[addrb];

        /*  write  */
        if(web == `ENABLE)
        begin
            ram_block[addrb] <= dinb;
        end
    end

endmodule // cpu_spm_dpram