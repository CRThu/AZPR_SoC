`ifndef __CPU_DEF__
    `define __CPU_DEF__

        `include "./Global/global_std_def.v"

        /*  Register  */
        `define REG_NUM         32
        `define REG_ADDR_WIDTH  5
        `define REG_ADDR_BUS    (`REG_ADDR_WIDTH-1):`LSB

        /*  IRQ Channel  */
        `define CPU_IRQ_CH      8

        /*  ALU OP Bus  */
        `define ALU_OP_WIDTH    4
        `define ALU_OP_BUS      (`ALU_OP_WIDTH-1):`LSB

        /*  ALU OP  */
        /*  ALU_OP_NOP  :   No Operation
         *  ALU_OP_AND  :   AND
         *  ALU_OP_OR   :   OR
         *  ALU_OP_XOR  :   XOR
         *  ALU_OP_ADDS :   ADD signed
         *  ALU_OP_ADDU :   ADD unsigned
         *  ALU_OP_SUBS :   SUB signed
         *  ALU_OP_SUBU :   SUB unsigned
         *  ALU_OP_SHRL :   SHIFT right
         *  ALU_OP_SHLL :   SHIFT left
         */
        `define ALU_OP_NOP      4'h0
        `define ALU_OP_AND      4'h1
        `define ALU_OP_OR       4'h2
        `define ALU_OP_XOR      4'h3
        `define ALU_OP_ADDS     4'h4
        `define ALU_OP_ADDU     4'h5
        `define ALU_OP_SUBS     4'h6
        `define ALU_OP_SUBU     4'h7
        `define ALU_OP_SHRL     4'h8
        `define ALU_OP_SHLL     4'h9

        /*  MEM OP Bus  */
        `define MEM_OP_WIDTH    2
        `define MEM_OP_BUS      (`MEM_OP_WIDTH-1):`LSB

        /*  MEM OP  */
        /*  MEM_OP_NOP  :   No Operation
         *  MEM_OP_LDW  :   Load Word
         *  MEM_OP_STW  :   Store Word
         */
        `define MEM_OP_NOP      2'h0
        `define MEM_OP_LDW      2'h1
        `define MEM_OP_STW      2'h2

        /*  CTRL OP Bus  */
        `define CTRL_OP_WIDTH   2
        `define CTRL_OP_BUS     (`CTRL_OP_WIDTH-1):`LSB

        /*  CTRL OP  */
        /*  CTRL_OP_NOP     :   No Operation
         *  CTRL_OP_WRCR    :   Write Control
         *  CTRL_OP_EXRT    :   Exception Return
         */
        `define CTRL_OP_NOP     2'h0
        `define CTRL_OP_WRCR    2'h1
        `define CTRL_OP_EXRT    2'h2

        /*  CPU EXE Mode Bus  */
        `define CPU_EXE_MODE_WIDTH  1
        `define CPU_EXE_MODE_BUS    (`CPU_EXE_MODE_WIDTH-1):`LSB

        /*  CPU EXE Mode  */
        `define CPU_KERNEL_MODE     1'b0
        `define CPU_USER_MODE       1'b1

        /*  CREG ADDR  */
        `define CREG_ADDR_STATUS        5'h0
        `define CREG_ADDR_RRE_STATUS    5'h1
        `define CREG_ADDR_PC            5'h2
        `define CREG_ADDR_EPC           5'h3
        `define CREG_ADDR_EXP_VECTOR    5'h4
        `define CREG_ADDR_CAUSE         5'h5
        `define CREG_ADDR_INT_MASK      5'h6
        `define CREG_ADDR_IRQ           5'h7

        `define CREG_ADDR_ROM_SIZE      5'h1d
        `define CREG_ADDR_SPM_SIZE      5'h1e
        `define CREG_ADDR_CPU_INFO      5'h1f

        /*  CREG Loc  */
        `define CREG_EXE_MODE_LOC       0
        `define CREG_INT_ENABLE_LOC     1
        `define CREG_EXP_CODE_LOC       2:0
        `define CREG_DLY_FLAG_LOC       3

        /*  BUS IF State Bus  */
        `define BUS_IF_STATE_BUS        1:`LSB

        /*  BUS IF State  */
        `define BUS_IF_STATE_IDLE       2'h0
        `define BUS_IF_STATE_REQ        2'h1
        `define BUS_IF_STATE_ACCESS     2'h2
        `define BUS_IF_STATE_STALL      2'h3

        /*  ???  */
        `define RESET_VECTOR            30'h0
        `define SH_AMOUNT_BUS           4:0
        `define SH_AMOUNT_LOC           4:0

        /*  Release  */
        `define RELEASE_YEAR            8'd41
        `define RELEASE_MONTH           8'd7
        `define RELEASE_VERSION         8'd1
        `define RELEASE_REVISION        8'd0

`endif
