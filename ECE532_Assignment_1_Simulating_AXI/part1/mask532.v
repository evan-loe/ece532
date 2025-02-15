`timescale 1ns / 1ps

module mask532
(
  input [4:0] 	n,
  input [31:0]  value_in,
  output [31:0] value_out
);

    wire [63:0] mask_large;
    wire [31:0] mask;
    
    assign mask_large = {{32{1'b1}}, {32{1'b0}}} >> n;
    assign mask = mask_large[31:0];
    
    assign value_out = value_in | mask;

endmodule