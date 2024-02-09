module control 
    #(parameter WL = 8)
    (input  logic   clk,
    input   logic   rst_b,
    input   logic   ops_val,
    output  logic   ops_rdy,
    input   logic   res_rdy,
    output  logic   res_val);
    // Add inputs/outputs for communication between control and datapath
    // For example: 
    //output logic cl2dp_en
    //input logic dp2cl_a_eq_b

    // Add control FSM here

endmodule: control
