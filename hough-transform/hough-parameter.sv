
module hough_parameter #(
  parameter DATA_WIDTH = 1,
  parameter FRAME_WIDTH = 640,
  parameter FRAME_HEIGHT = 480,
  parameter RHO_MAX = $ceil($sqrt(FRAME_WIDTH*FRAME_WIDTH + FRAME_HEIGHT*FRAME_HEIGHT)), // rho is between 0 and rho_max
  parameter THETA_MAX = 180, // theta is between 0 and 360
  parameter RHO_STEP = 1,
  parameter THETA_STEP = 1,
  parameter FIXEDP_PRECISION = 8
)(
  input  wire                       aclk,
  input  wire                       aresetn,
  input  wire [DATA_WIDTH-1:0]      s_axis_tdata,
  input  wire                       s_axis_tvalid,
  output wire                       s_axis_tready,
  output wire                       s_axis_tlast,

  output wire                       accum_valid_out,
  output wire [$clog2(RHO_MAX):0]   accum_rho_out,
  output wire [$clog2(THETA_MAX):0] accum_theta_out,
  input  wire                       accum_ready_in
);

  local parameter FRAME_PIXEL_COUNT = FRAME_WIDTH * FRAME_HEIGHT;

  // Internal signals
  reg [DATA_WIDTH-1:0]                data_in_reg;
  reg                                 write_en;
  wire                                fifo_full;
  
  wire                                read_rdy;
  wire                                fifo_empty;

  wire [$clog2(FRAME_WIDTH):0]        curr_x;
  wire [$clog2(FRAME_HEIGHT):0]       curr_y;
  reg  [$clog2(FRAME_WIDTH):0]        fifo_x;
  reg  [$clog2(FRAME_HEIGHT):0]       fifo_y;
  reg  [$clog2(FRAME_PIXEL_COUNT):0]  frame_pixel_count;

  // states for the state machine
  enum {IDLE, READ_FIFO, WAIT_MULT, WRITE_TO_HPS, WAIT_FOR_ACCUM}  state;
  reg [1:0]                             state_reg;
  
  wire [$clog2(RHO_MAX)]                rho;
  reg  [$clog2(THETA_MAX)]              curr_theta;


  // AXI Stream input interface
  assign s_axis_tready = ~fifo_full;

  always @(posedge aclk) begin
    if (!aresetn) begin
      data_in_reg  <= {DATA_WIDTH{1'b0}};
      write_en  <= 1'b0;
    end else begin
      if (s_axis_tvalid && s_axis_tready && s_axis_tdata == 'b1) begin
        write_en <= 1'b1;
      end else begin
        write_en <= 1'b0;
      end
    end
  end

  always@(posedge aclk) begin
    if (!aresetn) begin
      frame_pixel_count <= 0;
    end else begin
      if (write_en) begin
        frame_pixel_count <= frame_pixel_count + 1;
      end
    end
  end

  assign curr_x = frame_pixel_count % FRAME_WIDTH;
  assign curr_y = frame_pixel_count / FRAME_WIDTH;

  in_fifo #(
    .DATA_WIDTH(DATA_WIDTH)
  ) in_fifo_inst (
    .wr_clk(aclk),
    .rst(aresetn),
    .wr_en(write_en),
    .full(fifo_full),
    .d_in({curr_x, curr_y}),
    .rd_en(state_reg == READ_FIFO),
    .empty(fifo_empty),
    .d_out({fifo_x, fifo_y})
  );

  local parameter CALC_WIDTH = $clog(RHO_MAX)+FIXEDP_PRECISION;

  wire [CALC_WIDTH-1:0] fifo_x_fp, fifo_y_fp;
  wire [CALC_WIDTH-1:0] rho_y, rho_x
  reg  [CALC_WIDTH-1:0] rho;
  assign fifo_x_fp = fifo_x << FIXEDP_PRECISION;
  assign fifo_y_fp = fifo_y << FIXEDP_PRECISION;

  sin_mult #(
    .DATA_WIDTH(CALC_WIDTH),
  ) sin_mult_inst (
    .aclk(aclk),
    .aresetn(aresetn),
    .a(fifo_y_fp),
    .theta(curr_theta),
    .sin(rho_y)
  );

  cos_mult #(
    .DATA_WIDTH(CALC_WIDTH),
  ) cos_mult_inst (
    .aclk(aclk),
    .aresetn(aresetn),
    .a(fifo_x_fp),
    .theta(curr_theta),
    .cos(rho_x)
  );

  assign accum_rho_out = rho >> FIXEDP_PRECISION;
  assign accum_theta_out = curr_theta;
  assign accum_valid_out = state_reg == WAIT_FOR_ACCUM;

  always @(posedge aclk) begin
    if (!aresetn) begin
      state_reg <= IDLE;
      rho <= 0;
    end else begin
      case (state_reg)
        IDLE: begin
          if (~fifo_empty) begin
            state_reg <= READ_FIFO;
          end
          rho <= 0;
        end
        READ_FIFO: begin
          state_reg <= WAIT_MULT;
          rho <= 0;
        end
        WAIT_MULT: begin
          state_reg <= WRITE_TO_HPS;
          rho <= 0;
        end
        WRITE_TO_HPS: begin
          state_reg <= WAIT_FOR_ACCUM;
          rho <= rho_x + rho_y;
        end
        WAIT_FOR_ACCUM: begin
          rho <= rho;
          if (accum_ready_in) begin
            if (theta < THETA_MAX) begin
              curr_theta <= curr_theta + 1;
              state_reg <= WAIT_MULT;
            end else begin
              curr_theta <= 0;
              if (~fifo_empty) begin
                state_reg <= READ_FIFO;
              end else begin
                state_reg <= IDLE;
              end
            end
          end else begin
            state_reg <= WAIT_FOR_ACCUM;
          end
        end
        default: begin
          state_reg <= IDLE;
          rho <= 0;
        end
      endcase
    end
  end

endmodule
