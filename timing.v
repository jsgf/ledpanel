/*
 * Panel Signals
 * 
 * CLK	- clock next bit into shift registers
 * LAT	- latch shift registers to output
 * OE/  - Output Enable.  Question: OE for current line, or whole display?
 * RGB01- 6 bits of RGB per logical scanline (two physical scanlines in parallel, at n and n+8)
 * ABC  - scanline selector, 3 bits
 * 
 * Overall panel timing
 *
 * The panel has 8 logical scanlines, scanned out in pairs to form 16 physical scanlines.
 * 
 * This design relies on the output of the first line being fed into the input of the
 * second, so that two scanlines can be clocked out in 64 cycles.  In effect, this means
 * we have 8x64 pixel scanlines which are split over two physical lines.
 *
 * Therefore, for line N, we clock out N+8 pixels from right to left, then scanline N
 * from right to left.
 */
module timing(input wire	 clk_in,
	      input wire 		  reset,

	      output wire [2:0] 	  line, 
	      output wire [5:0] 	  col,
	      output wire 		  lat, 
	      output wire [PWM_WIDTH-1:0] pwm, 
	      output wire 		  frame_clk);

   parameter PWM_WIDTH = 12;

   localparam COL_START = 0;
   localparam COL_WIDTH = 6;
   localparam COL_END = COL_START + COL_WIDTH;
   
   localparam ROW_START = COL_END;
   localparam ROW_WIDTH = 3;
   localparam ROW_END = ROW_START + ROW_WIDTH;

   localparam PWM_START = ROW_END;
   localparam PWM_END = PWM_WIDTH + PWM_START;

   localparam DIRFLAG_START = PWM_END;
   localparam DIRFLAG_END = DIRFLAG_START + 1;

   localparam COUNTER_WIDTH = DIRFLAG_END;
   
   reg [COUNTER_WIDTH-1:0] 		  counter = 0;
   
   always @ (posedge clk_in or posedge reset)
     begin
	if (reset) begin
	   counter <= 0;
	end else begin
	   counter <= counter + 'd1;
	end
     end
   
   assign col = counter[COL_END-1:COL_START];
   assign line = counter[ROW_END-1:ROW_START];
   wire [PWM_WIDTH-1:0] _pwm;
   assign _pwm = counter[PWM_END-1:PWM_START];
`ifdef USE_ZIGZAG
   // Zigzag pwm avoids having all the LEDs turn on at once, but it
   // adds odd temporal phase effects for dim LEDs
   assign pwm = counter[DIRFLAG_START] ? ~_pwm : _pwm;
`else
   assign pwm = _pwm;
`endif

   // Frame done at the end of a full pwm cycle
   assign frame_clk = (counter[DIRFLAG_START-1:0] == 0);

   // Latch when scanline finishes
   assign lat = (col == 0);
endmodule
