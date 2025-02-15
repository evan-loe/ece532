`timescale 1ns / 1ps


module mask_axi532
(
  input aclk,
  input aresetn,

  // AXI-Lite slave interface
  input [31:0]  S_AXI_AWADDR,
  input         S_AXI_AWVALID,
  output        S_AXI_AWREADY,

  input [31:0]  S_AXI_WDATA,
  input [3:0]   S_AXI_WSTRB,
  input         S_AXI_WVALID,
  output        S_AXI_WREADY,

  output [1:0]  S_AXI_BRESP,
  output        S_AXI_BVALID,
  input         S_AXI_BREADY,

  input [31:0]  S_AXI_ARADDR,
  input         S_AXI_ARVALID,
  output        S_AXI_ARREADY,

  output [31:0] S_AXI_RDATA,
  output [1:0]  S_AXI_RRESP,
  output        S_AXI_RVALID,
  input         S_AXI_RREADY,

  // AXI-Lite master interface
  output [31:0] M_AXI_AWADDR,
  output        M_AXI_AWVALID,
  input         M_AXI_AWREADY,

  output [31:0] M_AXI_WDATA,
  output [3:0]  M_AXI_WSTRB,
  output        M_AXI_WVALID,
  input         M_AXI_WREADY,

  input [1:0]   M_AXI_BRESP,
  input         M_AXI_BVALID,
  output        M_AXI_BREADY
);
  
	// wire txn_done;
	// wire init_txn;
	// wire init_write;
  reg  wr_in_progress;

  wire [4:0]    n;
  wire [31:0]   value_in;


  wire [31:0]   output_addr;

	assign M_AXI_AWADDR = output_addr;
	assign M_AXI_AWVALID = wr_in_progress;
	assign M_AXI_WSTRB = 4'b1111;
	assign M_AXI_BREADY = 1'b1;
	
    // Instantiation of Axi Bus Interface S00_AXI
	mask_axi532_v1_0_S00_AXI # ( 
		.C_S_AXI_DATA_WIDTH(32),
		.C_S_AXI_ADDR_WIDTH(32)
	) mask_axi532_v1_0_S00_AXI_inst (
    .n_value(n),
	  .data_value(value_in),
	  .output_addr(output_addr),
	  .init_write(init_write),
		.S_AXI_ACLK(aclk),
		.S_AXI_ARESETN(aresetn),
		.S_AXI_AWADDR(S_AXI_AWADDR),
		.S_AXI_AWPROT(3'b010),
		.S_AXI_AWVALID(S_AXI_AWVALID),
		.S_AXI_AWREADY(S_AXI_AWREADY),
		.S_AXI_WDATA(S_AXI_WDATA),
		.S_AXI_WSTRB(S_AXI_WSTRB),
		.S_AXI_WVALID(S_AXI_WVALID),
		.S_AXI_WREADY(S_AXI_WREADY),
		.S_AXI_BRESP(S_AXI_BRESP),
		.S_AXI_BVALID(S_AXI_BVALID),
		.S_AXI_BREADY(S_AXI_BREADY),
		.S_AXI_ARADDR(S_AXI_ARADDR),
		.S_AXI_ARPROT(3'b010),
		.S_AXI_ARVALID(S_AXI_ARVALID),
		.S_AXI_ARREADY(S_AXI_ARREADY),
		.S_AXI_RDATA(S_AXI_RDATA),
		.S_AXI_RRESP(S_AXI_RRESP),
		.S_AXI_RVALID(S_AXI_RVALID),
		.S_AXI_RREADY(S_AXI_RREADY)
	);
	
	// // Instantiation of Axi Bus Interface M00_AXI
	// mask_axi532_v1_0_M00_AXI # ( 
	// 	.C_M_START_DATA_VALUE(32'hAA000000),
	// 	.C_M_TARGET_SLAVE_BASE_ADDR(32'h40000000),
	// 	.C_M_AXI_ADDR_WIDTH(32),
	// 	.C_M_AXI_DATA_WIDTH(32),
	// 	.C_M_TRANSACTIONS_NUM(4)
	// ) mask_axi532_v1_0_M00_AXI_inst (
	// 	.INIT_AXI_TXN(init_txn),
	// 	.TXN_DONE(tx_done),
	// 	.M_AXI_ACLK(aclk),
	// 	.M_AXI_ARESETN(aresetn),
	// 	.M_AXI_AWADDR(M_AXI_AWADDR),
	// 	.M_AXI_AWPROT(),
	// 	.M_AXI_AWVALID(M_AXI_AWVALID),
	// 	.M_AXI_AWREADY(M_AXI_AWREADY),
	// 	.M_AXI_WDATA(M_AXI_WDATA),
	// 	.M_AXI_WSTRB(M_AXI_WSTRB),
	// 	.M_AXI_WVALID(M_AXI_WVALID),
	// 	.M_AXI_WREADY(M_AXI_WREADY),
	// 	.M_AXI_BRESP(M_AXI_BRESP),
	// 	.M_AXI_BVALID(M_AXI_BVALID),
	// 	.M_AXI_BREADY(M_AXI_BREADY)
	// );

	always@(posedge aclk) begin
		if (aresetn) begin
			wr_in_progress <= 1'b0;
		end else begin
			if (init_write && !wr_in_progress) begin
				wr_in_progress <= 1'b1;
			end else if (M_AXI_WREADY) begin
				wr_in_progress <= 1'b0;
			end
		end
	end

  mask532 mask_logic(
    .n(n),
    .value_in(value_in),
    .value_out(M_AXI_WDATA)
  );
	
endmodule
