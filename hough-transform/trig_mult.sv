

module sin_mult #(
  parameter DATA_WIDTH = 16,
) (
  input                   aclk,
  input                   aresetn,
  input [DATA_WIDTH-1:0]  a,
  input [DATA_WIDTH-1:0]  theta,
  output reg [DATA_WIDTH-1:0] sin
);

  wire [DATA_WIDTH-1:0] sin_table_out;
  reg  [DATA_WIDTH-1:0] a_ff;

  sin_table #(
    .DATA_WIDTH(DATA_WIDTH),
  ) sin_table_inst (
    .aclk(aclk),
    .theta(theta),
    .sin(sin_table_out)
  );

  always @(posedge aclk) begin
    if (!aresetn) begin
      sin <= 0;
    end else begin
      a_ff <= a;
      sin <= a_ff * sin_table_out;
    end
  end

endmodule

module sin_table #(
  parameter DATA_WIDTH = 16,
) (
  input                   aclk,
  input [DATA_WIDTH-1:0]  theta,
  output [DATA_WIDTH-1:0] sin
);

  always@(posedge aclk) begin
    case (theta)
8'd0: sin = 18'h0;
8'd1: sin = 18'h2;
8'd2: sin = 18'h4;
8'd3: sin = 18'h7;
8'd4: sin = 18'h9;
8'd5: sin = 18'hb;
8'd6: sin = 18'hd;
8'd7: sin = 18'h10;
8'd8: sin = 18'h12;
8'd9: sin = 18'h14;
8'd10: sin = 18'h16;
8'd11: sin = 18'h18;
8'd12: sin = 18'h1b;
8'd13: sin = 18'h1d;
8'd14: sin = 18'h1f;
8'd15: sin = 18'h21;
8'd16: sin = 18'h23;
8'd17: sin = 18'h25;
8'd18: sin = 18'h28;
8'd19: sin = 18'h2a;
8'd20: sin = 18'h2c;
8'd21: sin = 18'h2e;
8'd22: sin = 18'h30;
8'd23: sin = 18'h32;
8'd24: sin = 18'h34;
8'd25: sin = 18'h36;
8'd26: sin = 18'h38;
8'd27: sin = 18'h3a;
8'd28: sin = 18'h3c;
8'd29: sin = 18'h3e;
8'd30: sin = 18'h40;
8'd31: sin = 18'h42;
8'd32: sin = 18'h44;
8'd33: sin = 18'h46;
8'd34: sin = 18'h48;
8'd35: sin = 18'h49;
8'd36: sin = 18'h4b;
8'd37: sin = 18'h4d;
8'd38: sin = 18'h4f;
8'd39: sin = 18'h51;
8'd40: sin = 18'h52;
8'd41: sin = 18'h54;
8'd42: sin = 18'h56;
8'd43: sin = 18'h57;
8'd44: sin = 18'h59;
8'd45: sin = 18'h5b;
8'd46: sin = 18'h5c;
8'd47: sin = 18'h5e;
8'd48: sin = 18'h5f;
8'd49: sin = 18'h61;
8'd50: sin = 18'h62;
8'd51: sin = 18'h63;
8'd52: sin = 18'h65;
8'd53: sin = 18'h66;
8'd54: sin = 18'h68;
8'd55: sin = 18'h69;
8'd56: sin = 18'h6a;
8'd57: sin = 18'h6b;
8'd58: sin = 18'h6d;
8'd59: sin = 18'h6e;
8'd60: sin = 18'h6f;
8'd61: sin = 18'h70;
8'd62: sin = 18'h71;
8'd63: sin = 18'h72;
8'd64: sin = 18'h73;
8'd65: sin = 18'h74;
8'd66: sin = 18'h75;
8'd67: sin = 18'h76;
8'd68: sin = 18'h77;
8'd69: sin = 18'h77;
8'd70: sin = 18'h78;
8'd71: sin = 18'h79;
8'd72: sin = 18'h7a;
8'd73: sin = 18'h7a;
8'd74: sin = 18'h7b;
8'd75: sin = 18'h7c;
8'd76: sin = 18'h7c;
8'd77: sin = 18'h7d;
8'd78: sin = 18'h7d;
8'd79: sin = 18'h7e;
8'd80: sin = 18'h7e;
8'd81: sin = 18'h7e;
8'd82: sin = 18'h7f;
8'd83: sin = 18'h7f;
8'd84: sin = 18'h7f;
8'd85: sin = 18'h80;
8'd86: sin = 18'h80;
8'd87: sin = 18'h80;
8'd88: sin = 18'h80;
8'd89: sin = 18'h80;
8'd90: sin = 18'h80;
8'd91: sin = 18'h80;
8'd92: sin = 18'h80;
8'd93: sin = 18'h80;
8'd94: sin = 18'h80;
8'd95: sin = 18'h80;
8'd96: sin = 18'h7f;
8'd97: sin = 18'h7f;
8'd98: sin = 18'h7f;
8'd99: sin = 18'h7e;
8'd100: sin = 18'h7e;
8'd101: sin = 18'h7e;
8'd102: sin = 18'h7d;
8'd103: sin = 18'h7d;
8'd104: sin = 18'h7c;
8'd105: sin = 18'h7c;
8'd106: sin = 18'h7b;
8'd107: sin = 18'h7a;
8'd108: sin = 18'h7a;
8'd109: sin = 18'h79;
8'd110: sin = 18'h78;
8'd111: sin = 18'h77;
8'd112: sin = 18'h77;
8'd113: sin = 18'h76;
8'd114: sin = 18'h75;
8'd115: sin = 18'h74;
8'd116: sin = 18'h73;
8'd117: sin = 18'h72;
8'd118: sin = 18'h71;
8'd119: sin = 18'h70;
8'd120: sin = 18'h6f;
8'd121: sin = 18'h6e;
8'd122: sin = 18'h6d;
8'd123: sin = 18'h6b;
8'd124: sin = 18'h6a;
8'd125: sin = 18'h69;
8'd126: sin = 18'h68;
8'd127: sin = 18'h66;
8'd128: sin = 18'h65;
8'd129: sin = 18'h63;
8'd130: sin = 18'h62;
8'd131: sin = 18'h61;
8'd132: sin = 18'h5f;
8'd133: sin = 18'h5e;
8'd134: sin = 18'h5c;
8'd135: sin = 18'h5b;
8'd136: sin = 18'h59;
8'd137: sin = 18'h57;
8'd138: sin = 18'h56;
8'd139: sin = 18'h54;
8'd140: sin = 18'h52;
8'd141: sin = 18'h51;
8'd142: sin = 18'h4f;
8'd143: sin = 18'h4d;
8'd144: sin = 18'h4b;
8'd145: sin = 18'h49;
8'd146: sin = 18'h48;
8'd147: sin = 18'h46;
8'd148: sin = 18'h44;
8'd149: sin = 18'h42;
8'd150: sin = 18'h40;
8'd151: sin = 18'h3e;
8'd152: sin = 18'h3c;
8'd153: sin = 18'h3a;
8'd154: sin = 18'h38;
8'd155: sin = 18'h36;
8'd156: sin = 18'h34;
8'd157: sin = 18'h32;
8'd158: sin = 18'h30;
8'd159: sin = 18'h2e;
8'd160: sin = 18'h2c;
8'd161: sin = 18'h2a;
8'd162: sin = 18'h28;
8'd163: sin = 18'h25;
8'd164: sin = 18'h23;
8'd165: sin = 18'h21;
8'd166: sin = 18'h1f;
8'd167: sin = 18'h1d;
8'd168: sin = 18'h1b;
8'd169: sin = 18'h18;
8'd170: sin = 18'h16;
8'd171: sin = 18'h14;
8'd172: sin = 18'h12;
8'd173: sin = 18'h10;
8'd174: sin = 18'hd;
8'd175: sin = 18'hb;
8'd176: sin = 18'h9;
8'd177: sin = 18'h7;
8'd178: sin = 18'h4;
8'd179: sin = 18'h2;
    endcase 
  end

endmodule



module cos_mult #(
  parameter DATA_WIDTH = 16,
) (
  input                       aclk,
  input                       aresetn,
  input [DATA_WIDTH-1:0]      a,
  input [DATA_WIDTH-1:0]      theta,
  output reg [DATA_WIDTH-1:0] cos
);

  wire [DATA_WIDTH-1:0] cos_table_out;
  reg  [DATA_WIDTH-1:0] a_ff;

  cos_table #(
    .DATA_WIDTH(DATA_WIDTH),
  ) cos_table_inst (
    .aclk(aclk),
    .theta(theta),
    .cos(cos_table_out)
  );

  always @(posedge aclk) begin
    if (!aresetn) begin
      cos <= 0;
    end else begin
      a_ff <= a;
      cos <= a_ff * cos_table_out;
    end
  end

endmodule

module cos_table #(
  parameter DATA_WIDTH = 16,
) (
  input                   aclk,
  input [DATA_WIDTH-1:0]  theta,
  output [DATA_WIDTH-1:0] cos
);

  always@(posedge aclk) begin
    case (theta)
8'd0: cos = 18'h80;
8'd1: cos = 18'h80;
8'd2: cos = 18'h80;
8'd3: cos = 18'h80;
8'd4: cos = 18'h80;
8'd5: cos = 18'h80;
8'd6: cos = 18'h7f;
8'd7: cos = 18'h7f;
8'd8: cos = 18'h7f;
8'd9: cos = 18'h7e;
8'd10: cos = 18'h7e;
8'd11: cos = 18'h7e;
8'd12: cos = 18'h7d;
8'd13: cos = 18'h7d;
8'd14: cos = 18'h7c;
8'd15: cos = 18'h7c;
8'd16: cos = 18'h7b;
8'd17: cos = 18'h7a;
8'd18: cos = 18'h7a;
8'd19: cos = 18'h79;
8'd20: cos = 18'h78;
8'd21: cos = 18'h77;
8'd22: cos = 18'h77;
8'd23: cos = 18'h76;
8'd24: cos = 18'h75;
8'd25: cos = 18'h74;
8'd26: cos = 18'h73;
8'd27: cos = 18'h72;
8'd28: cos = 18'h71;
8'd29: cos = 18'h70;
8'd30: cos = 18'h6f;
8'd31: cos = 18'h6e;
8'd32: cos = 18'h6d;
8'd33: cos = 18'h6b;
8'd34: cos = 18'h6a;
8'd35: cos = 18'h69;
8'd36: cos = 18'h68;
8'd37: cos = 18'h66;
8'd38: cos = 18'h65;
8'd39: cos = 18'h63;
8'd40: cos = 18'h62;
8'd41: cos = 18'h61;
8'd42: cos = 18'h5f;
8'd43: cos = 18'h5e;
8'd44: cos = 18'h5c;
8'd45: cos = 18'h5b;
8'd46: cos = 18'h59;
8'd47: cos = 18'h57;
8'd48: cos = 18'h56;
8'd49: cos = 18'h54;
8'd50: cos = 18'h52;
8'd51: cos = 18'h51;
8'd52: cos = 18'h4f;
8'd53: cos = 18'h4d;
8'd54: cos = 18'h4b;
8'd55: cos = 18'h49;
8'd56: cos = 18'h48;
8'd57: cos = 18'h46;
8'd58: cos = 18'h44;
8'd59: cos = 18'h42;
8'd60: cos = 18'h40;
8'd61: cos = 18'h3e;
8'd62: cos = 18'h3c;
8'd63: cos = 18'h3a;
8'd64: cos = 18'h38;
8'd65: cos = 18'h36;
8'd66: cos = 18'h34;
8'd67: cos = 18'h32;
8'd68: cos = 18'h30;
8'd69: cos = 18'h2e;
8'd70: cos = 18'h2c;
8'd71: cos = 18'h2a;
8'd72: cos = 18'h28;
8'd73: cos = 18'h25;
8'd74: cos = 18'h23;
8'd75: cos = 18'h21;
8'd76: cos = 18'h1f;
8'd77: cos = 18'h1d;
8'd78: cos = 18'h1b;
8'd79: cos = 18'h18;
8'd80: cos = 18'h16;
8'd81: cos = 18'h14;
8'd82: cos = 18'h12;
8'd83: cos = 18'h10;
8'd84: cos = 18'hd;
8'd85: cos = 18'hb;
8'd86: cos = 18'h9;
8'd87: cos = 18'h7;
8'd88: cos = 18'h4;
8'd89: cos = 18'h2;
8'd90: cos = 18'h0;
8'd91: cos = 18'h3fffe;
8'd92: cos = 18'h3fffc;
8'd93: cos = 18'h3fff9;
8'd94: cos = 18'h3fff7;
8'd95: cos = 18'h3fff5;
8'd96: cos = 18'h3fff3;
8'd97: cos = 18'h3fff0;
8'd98: cos = 18'h3ffee;
8'd99: cos = 18'h3ffec;
8'd100: cos = 18'h3ffea;
8'd101: cos = 18'h3ffe8;
8'd102: cos = 18'h3ffe5;
8'd103: cos = 18'h3ffe3;
8'd104: cos = 18'h3ffe1;
8'd105: cos = 18'h3ffdf;
8'd106: cos = 18'h3ffdd;
8'd107: cos = 18'h3ffdb;
8'd108: cos = 18'h3ffd8;
8'd109: cos = 18'h3ffd6;
8'd110: cos = 18'h3ffd4;
8'd111: cos = 18'h3ffd2;
8'd112: cos = 18'h3ffd0;
8'd113: cos = 18'h3ffce;
8'd114: cos = 18'h3ffcc;
8'd115: cos = 18'h3ffca;
8'd116: cos = 18'h3ffc8;
8'd117: cos = 18'h3ffc6;
8'd118: cos = 18'h3ffc4;
8'd119: cos = 18'h3ffc2;
8'd120: cos = 18'h3ffc0;
8'd121: cos = 18'h3ffbe;
8'd122: cos = 18'h3ffbc;
8'd123: cos = 18'h3ffba;
8'd124: cos = 18'h3ffb8;
8'd125: cos = 18'h3ffb7;
8'd126: cos = 18'h3ffb5;
8'd127: cos = 18'h3ffb3;
8'd128: cos = 18'h3ffb1;
8'd129: cos = 18'h3ffaf;
8'd130: cos = 18'h3ffae;
8'd131: cos = 18'h3ffac;
8'd132: cos = 18'h3ffaa;
8'd133: cos = 18'h3ffa9;
8'd134: cos = 18'h3ffa7;
8'd135: cos = 18'h3ffa5;
8'd136: cos = 18'h3ffa4;
8'd137: cos = 18'h3ffa2;
8'd138: cos = 18'h3ffa1;
8'd139: cos = 18'h3ff9f;
8'd140: cos = 18'h3ff9e;
8'd141: cos = 18'h3ff9d;
8'd142: cos = 18'h3ff9b;
8'd143: cos = 18'h3ff9a;
8'd144: cos = 18'h3ff98;
8'd145: cos = 18'h3ff97;
8'd146: cos = 18'h3ff96;
8'd147: cos = 18'h3ff95;
8'd148: cos = 18'h3ff93;
8'd149: cos = 18'h3ff92;
8'd150: cos = 18'h3ff91;
8'd151: cos = 18'h3ff90;
8'd152: cos = 18'h3ff8f;
8'd153: cos = 18'h3ff8e;
8'd154: cos = 18'h3ff8d;
8'd155: cos = 18'h3ff8c;
8'd156: cos = 18'h3ff8b;
8'd157: cos = 18'h3ff8a;
8'd158: cos = 18'h3ff89;
8'd159: cos = 18'h3ff89;
8'd160: cos = 18'h3ff88;
8'd161: cos = 18'h3ff87;
8'd162: cos = 18'h3ff86;
8'd163: cos = 18'h3ff86;
8'd164: cos = 18'h3ff85;
8'd165: cos = 18'h3ff84;
8'd166: cos = 18'h3ff84;
8'd167: cos = 18'h3ff83;
8'd168: cos = 18'h3ff83;
8'd169: cos = 18'h3ff82;
8'd170: cos = 18'h3ff82;
8'd171: cos = 18'h3ff82;
8'd172: cos = 18'h3ff81;
8'd173: cos = 18'h3ff81;
8'd174: cos = 18'h3ff81;
8'd175: cos = 18'h3ff80;
8'd176: cos = 18'h3ff80;
8'd177: cos = 18'h3ff80;
8'd178: cos = 18'h3ff80;
8'd179: cos = 18'h3ff80;
    endcase 
  end

endmodule