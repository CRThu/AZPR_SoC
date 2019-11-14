`ifndef __CPU_SPM_DEF__
    `define __CPU_SPM_DEF__

    `include "./Global/global_std_def.v"

    `define SPM_SIZE        16384
    `define SPM_DEPTH       4096
    `define SPM_ADDR_WIDTH  12
    `define SPM_ADDR_BUS    (`SPM_ADDR_WIDTH-1):`LSB
    `define SPM_ADDR_LOC    11:0

`endif