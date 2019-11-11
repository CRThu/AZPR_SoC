`ifndef __GLOBAL_STD_DEF__
    `define __GLOBAL_STD_DEF__

    /*  singal level  */
    `define HIGH        1'b1
    `define LOW         1'b0

    /*  enable & disable  */
    `define DISABLE     1'b0
    `define ENABLE      1'b1
    `define DISABLE_    1'b1
    `define ENABLE_     1'b0

    /*  read & write  */
    `define READ        1'b1
    `define WRITE       1'b0

    /*  Least Significant Bit  */
    `define LSB         0

    /*  byte data  */
    `define BYTE_DATA_WIDTH     8
    `define BYTE_MSB            (`BYTE_DATA_WIDTH-1)
    `define BYTE_DATA_BUS       `BYTE_MSB:`LSB

    /*  word data  */
    `define WORD_DATA_WIDTH     32
    `define WORD_MSB            (`WORD_DATA_WIDTH-1)
    `define WORD_DATA_BUS       `WORD_MSB:`LSB

    /*  word address  */
    `define WORD_ADDR_WIDTH     30
    `define WORD_ADDR_MSB       (`WORD_ADDR_WIDTH-1)
    `define WORD_ADDR_BUS       `WORD_ADDR_MSB:`LSB

    /*  address offset  */
    `define BYTE_OFFSET_WIDTH   2
    `define BYTE_OFFSET_MSB     (`BYTE_OFFSET_WIDTH-1)
    `define BYTE_OFFSET_BUS     `BYTE_OFFSET_MSB:`LSB

    /*  address location  */
    `define WORD_ADDR_LOC       `WORD_ADDR_MSB:`BYTE_OFFSET_WIDTH
    `define BYTE_OFFSET_LOC     `BYTE_OFFSET_MSB:`LSB
    `define BYTE_OFFSET_WORD    2'b00

`endif