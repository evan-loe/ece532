`timescale 1ns / 1ps

module part1_tb();

	reg [4:0] n;
	reg [31:0] value_in;
	wire [31:0] value_out;
    reg [31:0] expected;
    
    integer i;

	// instantiate the "design under test" module
	mask532 DUT(
		.n(n),
		.value_in(value_in),
		.value_out(value_out)
		);

    reg clock;
    reg [31:0] input_tests [4:0];
    reg [4:0] input_test_n [4:0];
    reg [31:0] output_test_expected [4:0];
    
    initial begin
        input_tests[0] = 32'h00000000;
        input_tests[1] = 32'h00000000;
        input_tests[2] = 32'h01234567;
        input_tests[3] = 32'hFFFFFFFF;
        input_tests[4] = 32'hFFFFFFFF;
        
        input_test_n[0] = 5'd0;
        input_test_n[1] = 5'd31;
        input_test_n[2] = 32'd12;
        input_test_n[3] = 32'd0;
        input_test_n[4] = 32'd12;
        
        output_test_expected[0] = 32'h00000000;
        output_test_expected[1] = 32'hFFFFFFFE;
        output_test_expected[2] = 32'hFFF34567;
        output_test_expected[3] = 32'hFFFFFFFF;
        output_test_expected[4] = 32'hFFFFFFFF;
    end
    

    always@(clock) // generate the clock signal
        #10 clock <= ~clock; // clock period is 20 ns ( 50 MHz clock signal )
        
    
    always@(posedge clock) begin
        #5;
        value_in <= input_tests[i];
        n <= input_test_n[i];
        expected <= output_test_expected[i];
        i = i+1;
    end
    
    always@(posedge clock) begin
        if (value_out != expected) begin
            $display("MISMATCH [%0t] OUT: %x    EXPECTED: %x", $time, value_out, expected);
        end
        if (i > 7) begin
            $display("END OF SIMULATION");
           $stop;
        end
    end
    
    initial begin
        clock = 1'b0;
        i=0;
        $monitor("[%0t] IN: %x    OUT: %x     MASK: %x    EXPECTED: %x", $time, value_in, value_out, n, expected);
    end
    
endmodule

