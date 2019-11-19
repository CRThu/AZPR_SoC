`ifndef __GLOBAL_CFG_DEF__
    `define __GLOBAL_CFG_DEF__

    /*  choose RESET polarity  */
    // `define POSITIVE_RESET
    `define NEGATIVE_RESET

    /*  choose MEMORY polarity  */
    `define POSITIVE_MEMORY
    // `define NEGATIVE_MRMORY

    /*  Enable I/O Modules  */
    // `define IMPLEMENT_TIMER
    // `define IMPLEMENT_UART
    // `define IMPLEMENT_GPIO

    /*  generate RESET_ENABLE & RESET_DISABLE & RESET_EDGE */
    // `ifdef POSITIVE_RESET
    //     `define RESET_EDGE      posedge
    //     `define RESET_ENABLE    1'b1
    //     `define RESET_DISABLE   1'b0
    // `elif NEGATIVE_RESET
        `define RESET_EDGE      negedge
        `define RESET_ENABLE    1'b0
        `define RESET_DISABLE   1'b1
    // `endif
    

    /*  generate MEM_ENABLE & MEM_DISABLE  */
    // `ifdef POSITIVE_MEMORY
        `define MEM_ENABLE    1'b1
        `define MEM_DISABLE   1'b0
    // `elif NEGATIVE_MRMORY
    //     `define MEM_ENABLE    1'b0
    //     `define MEM_DISABLE   1'b1
    // `endif

`endif