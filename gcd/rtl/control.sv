module control 
    #(parameter WL = 8)
    (input  logic   clk,
    input   logic   rst_b,
    input   logic   ops_val,
    output  logic   ops_rdy,
    input   logic   res_rdy,
    output  logic   res_val,
    // control logics to datapath
    output logic [1:0] selA, selB,
    // data from datapath
    input logic [WL-1:0] curr_B, curr_A);
    // inputs/outputs for communication between control and datapath

    logic A_lt_B; 
    enum {Ready, Compute, Done} PS, NS;
    // selA: 2'b0: inA; 2'b01: B, 2'b10: A-B; 2'b11: A
    // selB: 2'b0: inB; 2'b01: A, 2'b11: B;
    // Add control FSM here
    always_comb begin : ctrl_states
        case (PS)
        Ready : begin
                NS = (ops_val) ? Compute : Ready;
                selA = 2'b0;
                selB = 2'b0;
        end
        Compute : begin
                NS = (curr_B == 0) ? Done : Compute;
                if (A_lt_B) begin // swap
                    selA = 2'b01; 
                    selB = 2'b01;
                end
                else begin // A - B
                    selA = 2'b10; 
                    selB = 2'b11;
                end
        end // end Compute
        Done : begin 
                NS = (res_rdy) ? Ready : Done;
                if (res_rdy) begin
                    selA = 2'b0; 
                    selB = 2'b0;
                end 
                else begin // remain until result sent successful
                    selA = 2'b11; 
                    selB = 2'b11;
                end 
        end // end Done
        endcase
    end
    assign A_lt_B = curr_A < curr_B;
    assign {res_val, ops_rdy} = {PS == Done, PS == Ready};

    always_ff @(posedge clk) begin : registers
        if(!rst_b) PS <= Ready;
        else PS <= NS;
    end

endmodule: control
