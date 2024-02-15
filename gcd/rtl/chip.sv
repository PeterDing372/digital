module chip
    (input  wire             clk,
    input   wire            rst_b,
    input   wire    [7:0]   op_a,
    input   wire    [7:0]   op_b,
    output  wire    [7:0]   res,
    input   wire            ops_val,
    output  wire            ops_rdy,
    input   wire            res_rdy, 
    output  wire            res_val);

    logic           clk_int, rst_b_int, ops_val_int, ops_rdy_int, res_rdy_int, res_val_int;
    logic   [7:0]   op_a_int, op_b_int, res_int;

    // datapath <-> control signals here
    logic [1:0] selA, selB;
    parameter WL = 8;
    logic [WL-1:0] curr_A, curr_B;
    // Instantiate datapath and control modules
    // Remember to add connections for the datapath <-> control signals you created
    control #(.WL(8)) inst_control (.clk(clk_int), .rst_b(rst_b_int), 
                            .ops_val(ops_val_int), .ops_rdy(ops_rdy_int), 
                            .res_rdy(res_rdy_int), .res_val(res_val_int),
                            .selA(selA), .selB(selB),
                            .curr_A(curr_A), .curr_B(curr_B));

    datapath #(.WL(8)) inst_datapath (.clk(clk_int), .rst_b(rst_b_int), 
                            .op_a(op_a_int), .op_b(op_b_int), .res(res_int),
                            .selA(selA), .selB(selB),
                            .curr_A(curr_A), .curr_B(curr_B));

    PADDI ipad_clk(.PAD (clk), .Y(clk_int)); // pad data in pad data out?
    PADDI ipad_rst_b(.PAD (rst_b), .Y(rst_b_int)); // active low
    PADDI ipad_ops_val(.PAD (ops_val), .Y(ops_val_int));
    PADDI ipad_res_rdy(.PAD (res_rdy), .Y(res_rdy_int));

    PADDO opad_ops_rdy(.A(ops_rdy_int), .PAD (ops_rdy));
    PADDO opad_res_val(.A (res_val_int),.PAD (res_val));

    generate
        genvar g;
        for (g = 0; g < 8; g = g + 1) begin: ipad_op_a
            PADDI gen_inst(.PAD (op_a[g]), .Y(op_a_int[g]));
        end
        for (g = 0; g < 8; g = g + 1) begin: ipad_op_b
            PADDI gen_inst(.PAD (op_b[g]), .Y(op_b_int[g]));
        end
        for (g = 0; g < 8; g = g + 1) begin: opad_res
            PADDO gen_inst(.A (res_int[g]), .PAD (res[g]));
        end
    endgenerate

endmodule: chip
