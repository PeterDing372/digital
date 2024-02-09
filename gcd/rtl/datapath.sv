module datapath 
    #(parameter WL = 8)
    (input  logic               clk,
    input   logic               rst_b,
    input   logic   [WL-1:0]    op_a,
    input   logic   [WL-1:0]    op_b,
    output  logic   [WL-1:0]    res);
    // Add inputs/outputs for communication between control and datapath
    // For example: 
    //input logic cl2dp_en
    //output logic dp2cl_a_eq_b

    // Add datapath here

endmodule: datapath
