`include "./ROM/rom_def.v"
`include "./Global/global_std_def.v"

/*  Single Port ROM  */
module rom_sprom(
    input wire clk,
    input wire [`ROM_ADDR_BUS] addr,
    output reg [`WORD_DATA_BUS] dout
);

    reg [`WORD_DATA_BUS] rom_block [`ROM_DEPTH-1:0];

    always @(posedge clk)
    begin
        dout <= rom_block[addr];
    end

endmodule // rom