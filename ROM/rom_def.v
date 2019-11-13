`ifndef __ROM_DEF__
    `define __ROM_DEF__

    `include "./Global/global_std_def.v"

    `define ROM_SIZE        8192
    `define ROM_DEPTH       2048
    `define ROM_ADDR_WIDTH  11
    `define ROM_ADDR_BUS    (`ROM_ADDR_WIDTH-1):0
    `define ROM_ADDR_LOC    (`ROM_ADDR_WIDTH-1):0

`endif