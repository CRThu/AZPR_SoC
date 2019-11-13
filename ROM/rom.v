`timescale 1ns/100ps
`include "./ROM/rom_def.v"

module rom(
    input wire clk,
    input wire [`ROM_ADDR_BUS] addr,
    output reg [`WORD_DATA_BUS] dout
);

    reg [`WORD_DATA_BUS] rom_block [`ROM_SIZE/4-1:0];

    always @(posedge clk)
    begin
        dout <= rom_block[addr];
    end

    integer i;
    initial
    begin
        $readmemh("./rom_tb.dat",rom_block);
        for(i=0;i<10;i++)
        begin
            $display("addr = 0x%h,\tdata = 0x%h;\n",i,rom_block[i]);
        end
    end


endmodule // rom