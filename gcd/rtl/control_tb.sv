module control_tb();
    // Number of test inputs
    parameter N = 1024;

    logic           clk, rst_b;
    logic           ops_rdy, ops_val, res_rdy, res_val;
    logic [1:0] selA, selB;
    parameter WL = 8;
    logic [WL-1:0] curr_A, curr_B;


    control #(.WL(8)) inst_control (.clk(clk), .rst_b(rst_b), 
                            .ops_val(ops_val), .ops_rdy(ops_rdy), 
                            .res_rdy(res_rdy), .res_val(res_val),
                            .selA(selA), .selB(selB),
                            .curr_A(curr_A), .curr_B(curr_B));

 
    initial begin
        clk = 0;
        forever begin
            #50;
            clk = ~clk;
        end
    end
    initial begin
        // reset
        rst_b = 0;
        // set control signals
        ops_val = 0;
        res_rdy = 0;
        {curr_A, curr_B} = {8'd0, 8'd0};
        @(posedge clk);
        rst_b = 1;
        {curr_A, curr_B} = {8'd6, 8'd4};
        ops_val = 1;
        @(posedge clk);
        {curr_A, curr_B} = {8'd6, 8'd8};


        @(posedge clk);
        @(posedge clk);
        @(posedge clk);



        $finish; 
        
    end

    initial begin
        $dumpfile("control_tb.vcd"); // Name of the VCD file to generate
        $dumpvars(0, control_tb); // Change 'testbench_top' to the name of your top module
    end

endmodule: control_tb
