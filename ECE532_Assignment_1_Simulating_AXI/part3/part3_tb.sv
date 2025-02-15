`timescale 1ns / 1ps

import axi_vip_pkg::*;
import design_1_axi_vip_1_0_pkg::*;


// test module to drive the AXI VIP
module axi_lite_stimulus();

	//Your Code Here

endmodule 


// testbench entry point
module part3_tb();

	reg aclk;
	reg aresetn;

	// instantiate the "design under test" module
	design_1_wrapper DUT(
		.clk(aclk),
		.resetn(aresetn)
		);

	// clock generator (100MHz)
	initial
	begin
		aclk = 0;
		forever
			#5ns aclk = ~aclk;
	end

	// start the testbench by resetting the system for 5 cycles
	initial
	begin
		aresetn = 0;
		repeat(5) @(posedge aclk);
		forever
			@(posedge aclk) aresetn = 1;
	end

	// instantiate instance of axi_lite_stimulus into the tb
	axi_lite_stimulus mst();

endmodule

