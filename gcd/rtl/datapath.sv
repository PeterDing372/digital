module datapath 
    #(parameter WL = 8)
    (input  logic               clk,
    input   logic               rst_b,
    input   logic   [WL-1:0]    op_a,
    input   logic   [WL-1:0]    op_b,
    output  logic   [WL-1:0]    res, 
    // data to control
    output logic [WL-1:0] curr_B, curr_A,
    // control signals
    input logic [1:0] selA, selB);

    logic [WL-1:0] toA, toB, A, B;
    // Add datapath here
    always_comb begin
        // selA: 2'b0: op_a; 2'b01: B (swap), 2'b10: A-B;
        case (selA)
            2'b0: toA =  op_a;
            2'b01: toA =  B;
            2'b10: toA =  A - B;
        endcase
        // selB: 2'b0: op_b; 2'b01: A, 2'b11: B;
        case (selB)
            2'b0: toB =  op_b;
            2'b01: toB =  A;
            2'b11: toB = B;
        endcase
    end

    assign {curr_A, curr_B} = {A, B};

    always_ff @(posedge clk) begin
        if (!rst_b) begin
            res <= 0; 
            A <= 0;
            B <= 0;
        end
        else begin
            A <= toA;
            B <= toB;
            res <= A;
        end
    end

endmodule: datapath
