`ifndef __BUS_DEF__
    `define __BUS_DEF__

    `include "./Global/global_std_def.v"

    /*  bus master num  */
    `define BUS_MASTER_CH           4
    `define BUS_MASTER_INDEX_WIDTH  2

    /*  bus master owner bus  */
    `define BUS_OWNER_BUS           (`BUS_MASTER_INDEX_WIDTH-1):`LSB

    /*  bus owner master  */
    `define BUS_OWNER_MASTER_0      2'h0
    `define BUS_OWNER_MASTER_1      2'h1
    `define BUS_OWNER_MASTER_2      2'h2
    `define BUS_OWNER_MASTER_3      2'h3

    /*  bus slave num  */
    `define BUS_SLAVE_CH            8
    `define BUS_SLAVE_INDEX_WIDTH   3

    /*  bus slave index bus  */
    `define BUS_SLAVE_INDEX_BUS     (`BUS_SLAVE_INDEX_WIDTH-1):`LSB
    //  ??? why ???
    `define BUS_SLAVE_INDEX_LOC     29:27

    /*  bus slave  */
    `define BUS_SLAVE_0     3'h0
    `define BUS_SLAVE_1     3'h1
    `define BUS_SLAVE_2     3'h2
    `define BUS_SLAVE_3     3'h3
    `define BUS_SLAVE_4     3'h4
    `define BUS_SLAVE_5     3'h5
    `define BUS_SLAVE_6     3'h6
    `define BUS_SLAVE_7     3'h7

`endif